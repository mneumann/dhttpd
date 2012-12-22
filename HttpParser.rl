/**
 * Copyright (c) 2005 Zed A. Shaw
 * You can redistribute it and/or modify it under the same terms as Ruby.
 *
 * Copyright (c) 2012 by Michael Neumann (mneumann@ntecs.de)
 */

// compile with ragel -G2 -D ...

import std.stdio;

/** Machine **/

%%{
  
  machine http_parser;

  action mark {
    mark = cast(BytePos)(fpc - buffer.ptr);
  }

  action request_uri {
    on_request_uri(BytePosRange(mark, cast(BytePos)(fpc - buffer.ptr)));
  }

  action fragment {
    on_fragment(BytePosRange(mark, cast(BytePos)(fpc - buffer.ptr)));
  }

  action request_method { 
    on_request_method(BytePosRange(mark, cast(BytePos)(fpc - buffer.ptr)));
  }

  action http_version {	
    on_http_version(BytePosRange(mark, cast(BytePos)(fpc - buffer.ptr)));
  }

  action request_path {
    on_request_path(BytePosRange(mark, cast(BytePos)(fpc - buffer.ptr)));
  }

  action mark_query { 
    mark_query = cast(BytePos)(fpc - buffer.ptr);
  }

  action query {
    on_query(BytePosRange(mark_query, cast(BytePos)(fpc - buffer.ptr)));
  }

  action field_accept {
    on_field_accept(BytePosRange(mark, cast(BytePos)(fpc - buffer.ptr)));
  }

  action field_accept_charset {
    on_field_accept_charset(BytePosRange(mark, cast(BytePos)(fpc - buffer.ptr)));
  }

  action field_cookie {
    on_field_cookie(BytePosRange(mark, cast(BytePos)(fpc - buffer.ptr)));
  }

  action field_date {
    on_field_date(BytePosRange(mark, cast(BytePos)(fpc - buffer.ptr)));
  }

  action field_name {
    field_name = BytePosRange(mark, cast(BytePos)(fpc - buffer.ptr));
  }

  action field_value {
    on_field(BytePosRange2(field_name, BytePosRange(mark, cast(BytePos)(fpc - buffer.ptr))));
  }

  action done {
    on_header_done(BytePosRange(cast(BytePos)(fpc - buffer.ptr + 1), cast(BytePos)(buffer.length)));
    fbreak;
  }

  include http_parser_common "HttpParserCommon.rl";

}%%

/** Data **/
%% write data;

alias uint BytePos;

struct BytePosRange {
  this(BytePos f, BytePos t) { from = f; to = t; }
  BytePos from;
  BytePos to;
};

struct BytePosRange2 {
  this(BytePosRange _a, BytePosRange _b) { a = _a; b = _b; }
  BytePosRange a;
  BytePosRange b;
};

class HttpParser
{
  private int saved_cs;

  private BytePos mark;
  private BytePos mark_query;
  private BytePosRange field_name;

  private size_t nread;

  // dummy visitor 
  void on_request_uri(BytePosRange r) {}
  void on_fragment(BytePosRange r) {}
  void on_request_method(BytePosRange r) {}
  void on_http_version(BytePosRange r) {}
  void on_request_path(BytePosRange r) {}
  void on_query(BytePosRange r) {}
  void on_header_done(BytePosRange r) {}

  void on_field_accept(BytePosRange r) {}
  void on_field_accept_charset(BytePosRange r) {}
  void on_field_cookie(BytePosRange r) {}
  void on_field_date(BytePosRange r) {}
  void on_field(BytePosRange2 name_value) {}

  this()
  {
    int cs = 0;
    %% write init;
    saved_cs = cs;
  }

  size_t execute(const char buffer[])
  {
    assert(buffer.length > 0);

    // Ragel uses: cs, p, pe
    int cs = saved_cs;           // current ragel machine state
    const(char) *p = &buffer[0];        // pointer to start of data
    const(char) *pe = &buffer[$-1] + 1; // pointer to end of data

    %% write exec;

    if (!has_error())
    {
      saved_cs = cs;
    }

    nread += (p - buffer.ptr);

    assert(p <= pe); // buffer overflow after parsing execute

    return nread;
  }

  int finish()
  {
    if (has_error()) {
      return -1;
    } else if (is_finished()) {
      return 1;
    } else {
      return 0;
    }
  }

  bool has_error() {
    return (saved_cs == http_parser_error);
  }

  bool is_finished() {
    return (saved_cs >= http_parser_first_final);
  }
}
