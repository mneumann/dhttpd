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

  action field_accept_encoding {
    on_field_accept_encoding(BytePosRange(mark, cast(BytePos)(fpc - buffer.ptr)));
  }

  action field_accept_language {
    on_field_accept_language(BytePosRange(mark, cast(BytePos)(fpc - buffer.ptr)));
  }

  action field_accept_datetime {
    on_field_accept_datetime(BytePosRange(mark, cast(BytePos)(fpc - buffer.ptr)));
  }

  action field_authorization {
    on_field_authorization(BytePosRange(mark, cast(BytePos)(fpc - buffer.ptr)));
  }

  action field_cache_control {
    on_field_cache_control(BytePosRange(mark, cast(BytePos)(fpc - buffer.ptr)));
  }

  action field_connection {
    on_field_connection(BytePosRange(mark, cast(BytePos)(fpc - buffer.ptr)));
  }

  action field_cookie {
    on_field_cookie(BytePosRange(mark, cast(BytePos)(fpc - buffer.ptr)));
  }

  action field_content_length {
    on_field_content_length(BytePosRange(mark, cast(BytePos)(fpc - buffer.ptr)));
  }

  action field_content_md5 {
    on_field_content_md5(BytePosRange(mark, cast(BytePos)(fpc - buffer.ptr)));
  }

  action field_content_type {
    on_field_content_type(BytePosRange(mark, cast(BytePos)(fpc - buffer.ptr)));
  }

  action field_date {
    on_field_date(BytePosRange(mark, cast(BytePos)(fpc - buffer.ptr)));
  }

  action field_expect {
    on_field_date(BytePosRange(mark, cast(BytePos)(fpc - buffer.ptr)));
  }

  action field_from {
    on_field_from(BytePosRange(mark, cast(BytePos)(fpc - buffer.ptr)));
  }

  action field_host {
    on_field_host(BytePosRange(mark, cast(BytePos)(fpc - buffer.ptr)));
  }

  action field_if_match {
    on_field_if_match(BytePosRange(mark, cast(BytePos)(fpc - buffer.ptr)));
  }

  action field_if_modified_since {
    on_field_if_modified_since(BytePosRange(mark, cast(BytePos)(fpc - buffer.ptr)));
  }

  action field_if_none_match {
    on_field_if_none_match(BytePosRange(mark, cast(BytePos)(fpc - buffer.ptr)));
  }

  action field_if_range {
    on_field_if_range(BytePosRange(mark, cast(BytePos)(fpc - buffer.ptr)));
  }

  action field_if_unmodified_since {
    on_field_if_unmodified_since(BytePosRange(mark, cast(BytePos)(fpc - buffer.ptr)));
  }

  action field_max_forwards {
    on_field_max_forwards(BytePosRange(mark, cast(BytePos)(fpc - buffer.ptr)));
  }

  action field_pragma {
    on_field_pragma(BytePosRange(mark, cast(BytePos)(fpc - buffer.ptr)));
  }

  action field_proxy_authorization {
    on_field_proxy_authorization(BytePosRange(mark, cast(BytePos)(fpc - buffer.ptr)));
  }

  action field_range {
    on_field_range(BytePosRange(mark, cast(BytePos)(fpc - buffer.ptr)));
  }

  action field_referer {
    on_field_referer(BytePosRange(mark, cast(BytePos)(fpc - buffer.ptr)));
  }

  action field_te {
    on_field_te(BytePosRange(mark, cast(BytePos)(fpc - buffer.ptr)));
  }

  action field_upgrade {
    on_field_upgrade(BytePosRange(mark, cast(BytePos)(fpc - buffer.ptr)));
  }

  action field_user_agent {
    on_field_user_agent(BytePosRange(mark, cast(BytePos)(fpc - buffer.ptr)));
  }

  action field_via {
    on_field_via(BytePosRange(mark, cast(BytePos)(fpc - buffer.ptr)));
  }

  action field_warning {
    on_field_warning(BytePosRange(mark, cast(BytePos)(fpc - buffer.ptr)));
  }

  action field_x_requested_with {
    on_field_x_requested_with(BytePosRange(mark, cast(BytePos)(fpc - buffer.ptr)));
  }

  action field_dnt {
    on_field_dnt(BytePosRange(mark, cast(BytePos)(fpc - buffer.ptr)));
  }

  action field_x_forwarded_for {
    on_field_x_forwarded_for(BytePosRange(mark, cast(BytePos)(fpc - buffer.ptr)));
  }

  action field_x_forwarded_proto {
    on_field_x_forwarded_for(BytePosRange(mark, cast(BytePos)(fpc - buffer.ptr)));
  }

  action field_front_end_https {
    on_field_front_end_https(BytePosRange(mark, cast(BytePos)(fpc - buffer.ptr)));
  }

  action field_x_att_deviceid {
    on_field_x_att_deviceid(BytePosRange(mark, cast(BytePos)(fpc - buffer.ptr)));
  }

  action field_x_wap_profile {
    on_field_x_wap_profile(BytePosRange(mark, cast(BytePos)(fpc - buffer.ptr)));
  }

  action field_proxy_connection {
    on_field_proxy_connection(BytePosRange(mark, cast(BytePos)(fpc - buffer.ptr)));
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
  void on_field_accept_encoding(BytePosRange r) {}
  void on_field_accept_language(BytePosRange r) {}
  void on_field_accept_datetime(BytePosRange r) {}
  void on_field_authorization(BytePosRange r) {}

  void on_field_cache_control(BytePosRange r) {}
  void on_field_connection(BytePosRange r) {}
  void on_field_cookie(BytePosRange r) {}
  void on_field_content_length(BytePosRange r) {}
  void on_field_content_md5(BytePosRange r) {}
  void on_field_content_type(BytePosRange r) {}
  void on_field_date(BytePosRange r) {}
  void on_field_expect(BytePosRange r) {}
  void on_field_from(BytePosRange r) {}
  void on_field_host(BytePosRange r) {}
  void on_field_if_match(BytePosRange r) {}
  void on_field_if_modified_since(BytePosRange r) {}
  void on_field_if_none_match(BytePosRange r) {}
  void on_field_if_range(BytePosRange r) {}
  void on_field_if_unmodified_since(BytePosRange r) {}
  void on_field_max_forwards(BytePosRange r) {}
  void on_field_pragma(BytePosRange r) {}
  void on_field_proxy_authorization(BytePosRange r) {}
  void on_field_range(BytePosRange r) {}
  void on_field_referer(BytePosRange r) {}
  void on_field_te(BytePosRange r) {}
  void on_field_upgrade(BytePosRange r) {}
  void on_field_user_agent(BytePosRange r) {}
  void on_field_via(BytePosRange r) {}
  void on_field_warning(BytePosRange r) {}

  void on_field_x_requested_with(BytePosRange r) {}
  void on_field_dnt(BytePosRange r) {}
  void on_field_x_forwarded_for(BytePosRange r) {}
  void on_field_x_forwarded_proto(BytePosRange r) {}
  void on_field_front_end_https(BytePosRange r) {}
  void on_field_x_att_deviceid(BytePosRange r) {}
  void on_field_x_wap_profile(BytePosRange r) {}
  void on_field_proxy_connection(BytePosRange r) {}

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
