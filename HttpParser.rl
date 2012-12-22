/**
 * Copyright (c) 2005 Zed A. Shaw
 * You can redistribute it and/or modify it under the same terms as Ruby.
 *
 * Copyright (c) 2012 by Michael Neumann (mneumann@ntecs.de)
 */

// compile with ragel -G2 -D ...

import std.stdio;

static char upcase_char(char c)
{
    if (c >= 'a' && c <= 'z')
      return (c & ~0x20);
    else if (c == '-')
      return ('_');
    else
      return c;
}

static void upcase_str(char []str)
{
  foreach (ref char c; str)
  {
    c = upcase_char(c);
  }
}

/** Machine **/

%%{
  
  machine http_parser;

  action mark { mark = fpc; }

  action request_uri {
    on_request_uri(get_mark_str(mark, fpc, buffer));
    mark = null;
  }

  action fragment {
    on_fragment(get_mark_str(mark, fpc, buffer));
    mark = null;
  }

  action request_method { 
    on_request_method(get_mark_str(mark, fpc, buffer));
    mark = null;
  }

  action http_version {	
    on_http_version(get_mark_str(mark, fpc, buffer));
    mark = null;
  }

  action write_field {
    saved_field = get_mark_str(mark, fpc, buffer);
    upcase_str(saved_field);
    mark = null;
  }

  action write_value {
    on_http_field(saved_field, get_mark_str(mark, fpc, buffer));
    saved_field.length = 0;
    mark = null;
  }

  action request_path {
    on_request_path(get_mark_str(mark, fpc, buffer));
  }

  action start_query { 
    assert(mark);
    query_pos = saved_mark_buf.length + (fpc - mark);
  }

  action query_string {
    on_query_string(get_mark_str(mark, fpc, buffer)[query_pos..$]);
    query_pos = 0;
  }

  action done { 
    on_header_done(buffer[(fpc - buffer.ptr + 1) .. $]);
    fbreak;
  }

  include http_parser_common "HttpParserCommon.rl";

}%%

/** Data **/
%% write data;

class HttpParser
{
  int saved_cs;
  char saved_mark_buf[];
  char saved_field[];

  size_t nread;

  private size_t query_pos;

  // dummy visitor 
  void on_http_version(const char v[]) {}
  void on_http_field(const char field[], const char value[]) {}
  void on_request_method(const char v[]) {}
  void on_request_uri(const char v[]) {}
  void on_request_path(const char v[]) {}
  void on_query_string(const char v[]) {}
  void on_fragment(const char v[]) {}
  void on_header_done(const char v[]) {}

  this()
  {
    int cs = 0;
    %% write init;
    saved_cs = cs;
  }

  char[] get_mark_str(char *mark, char *fpc, char buffer[])
  {
    assert(mark);
    auto buf = saved_mark_buf ~ buffer[(mark - buffer.ptr) .. (fpc - buffer.ptr)];
    saved_mark_buf.length = 0;
    return buf;
  }

  /** exec **/

  size_t execute(/*const*/ char buffer[])
  {
    // Ragel uses: cs, p, pe
    int cs = saved_cs;           // current ragel machine state
    assert(buffer.length > 0);
    /*const*/ char *p = &buffer[0];        // pointer to start of data
    /*const*/ char *pe = &buffer[$-1] + 1; // pointer to end of data

    /*const*/ char *mark = null;
 
    if (saved_mark_buf.length > 0)
    {
      // we are in an mark section so continue the marking
      mark = p;
    }

    // exec begin
    %% write exec;
    // exec end

    if (!has_error())
    {
      saved_cs = cs;
    }

    if (mark)
    {
      // within a marking the buffer ends. save what we currently read in
      saved_mark_buf ~= buffer[(mark - buffer.ptr) .. $];
      assert(saved_mark_buf.length > 0);
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
};
