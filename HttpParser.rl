/**
 * Copyright (c) 2005 Zed A. Shaw
 * You can redistribute it and/or modify it under the same terms as Ruby.
 *
 * Copyright (c) 2012 by Michael Neumann (mneumann@ntecs.de)
 */

// compile with ragel -G2 -D ...

/*
static void snake_upcase_char(char *c)
{
    if (*c >= 'a' && *c <= 'z')
      *c &= ~0x20;
    else if (*c == '-')
      *c = '_';
}
*/

/** Machine **/

%%{
  
  machine http_parser;

  action mark { mark = current_position(buffer, fpc); }

  action start_field { field_start = current_position(buffer, fpc); }
  action snake_upcase_field { /*snake_upcase_char(fpc);*/ }
  action write_field { field_end = current_position(buffer, fpc); }

  action start_value { mark = current_position(buffer, fpc); }
  action write_value {
    on_http_field(buffer[field_start .. field_end],
                  buffer[mark .. current_position(buffer, fpc)]);
  }

  action request_method { 
    on_request_method(buffer[mark .. current_position(buffer, fpc)]);
  }

  action request_uri { 
    on_request_uri(buffer[mark .. current_position(buffer, fpc)]);
  }

  action fragment {
    on_fragment(buffer[mark .. current_position(buffer, fpc)]);
  }

  action start_query { query_start = current_position(buffer, fpc); }

  action query_string {
    on_query_string(buffer[query_start .. current_position(buffer, fpc)]);
  }

  action http_version {	
    on_http_version(buffer[mark .. current_position(buffer, fpc)]);
  }

  action request_path {
    on_request_path(buffer[mark .. current_position(buffer, fpc)]);
  }

  action done { 
    body_start = current_position(buffer, fpc) + 1;
    on_header_done(buffer[body_start .. $]);
    fbreak;
  }

  include http_parser_common "HttpParserCommon.rl";

}%%

/** Data **/
%% write data;

class HttpParser
{
  int saved_cs;
  size_t body_start;
  size_t nread;
  size_t mark;

  size_t field_start;
  size_t field_end;
  size_t query_start;

  // dummy visitor 
  void on_http_version(const char v[]) {}
  void on_http_field(const char field[], const char value[]) {}
  void on_request_method(const char v[]) {}
  void on_request_uri(const char v[]) {}
  void on_request_path(const char v[]) {}
  void on_query_string(const char v[]) {}
  void on_fragment(const char v[]) {}
  void on_header_done(const char v[]) {}

  size_t current_position(const char buffer[], const char *fpc)
  {
    assert(fpc >= buffer.ptr);
    return fpc - buffer.ptr;
  }

  this()
  {
    int cs = 0;
    %% write init;
    saved_cs = cs;
  }

  /** exec **/

  //
  // The passed buffer must always contain *all* data.
  //
  size_t execute(char buffer[], size_t off)
  {
    // Ragel uses: cs, p, pe
    char *p = &buffer[off];      // pointer to start of data
    char *pe = &buffer[$-1] + 1; // pointer to end of data
    int cs = saved_cs;                  // current ragel machine state 

    assert(off <= buffer.length); // offset past end of buffer

    assert(pe - p == buffer.length - off); // pointers aren't same distance

    // exec begin
    %% write exec;
    // exec end

    if (!has_error())
      saved_cs = cs;

    nread += p - (&buffer[off]);

    assert(p <= pe); // buffer overflow after parsing execute
    assert(nread <= buffer.length); // nread longer than length
    assert(body_start <= buffer.length); // body starts after buffer end
    assert(mark < buffer.length);  // mark is after buffer end
    assert(field_end <= buffer.length); // field has length longer than whole buffer
    assert(field_start < buffer.length); // field starts after buffer end

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
