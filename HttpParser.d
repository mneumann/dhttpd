
#line 1 "HttpParser.rl"
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


#line 91 "HttpParser.rl"


/** Data **/

#line 41 "HttpParser.d"
static const int http_parser_start = 1;
static const int http_parser_first_final = 57;
static const int http_parser_error = 0;

static const int http_parser_en_main = 1;


#line 95 "HttpParser.rl"

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
    
#line 75 "HttpParser.d"
	{
	cs = http_parser_start;
	}

#line 120 "HttpParser.rl"
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
    
#line 112 "HttpParser.d"
	{
	if ( p == pe )
		goto _test_eof;
	switch ( cs )
	{
case 1:
	switch( (*p) ) {
		case 36u: goto tr0;
		case 95u: goto tr0;
		default: break;
	}
	if ( (*p) < 48u ) {
		if ( 45u <= (*p) && (*p) <= 46u )
			goto tr0;
	} else if ( (*p) > 57u ) {
		if ( 65u <= (*p) && (*p) <= 90u )
			goto tr0;
	} else
		goto tr0;
	goto st0;
st0:
cs = 0;
	goto _out;
tr0:
#line 36 "HttpParser.rl"
	{ mark = p; }
	goto st2;
st2:
	if ( ++p == pe )
		goto _test_eof2;
case 2:
#line 144 "HttpParser.d"
	switch( (*p) ) {
		case 32u: goto tr2;
		case 36u: goto st38;
		case 95u: goto st38;
		default: break;
	}
	if ( (*p) < 48u ) {
		if ( 45u <= (*p) && (*p) <= 46u )
			goto st38;
	} else if ( (*p) > 57u ) {
		if ( 65u <= (*p) && (*p) <= 90u )
			goto st38;
	} else
		goto st38;
	goto st0;
tr2:
#line 48 "HttpParser.rl"
	{ 
    on_request_method(get_mark_str(mark, p, buffer));
    mark = null;
  }
	goto st3;
st3:
	if ( ++p == pe )
		goto _test_eof3;
case 3:
#line 171 "HttpParser.d"
	switch( (*p) ) {
		case 42u: goto tr4;
		case 43u: goto tr5;
		case 47u: goto tr6;
		case 58u: goto tr7;
		default: break;
	}
	if ( (*p) < 65u ) {
		if ( 45u <= (*p) && (*p) <= 57u )
			goto tr5;
	} else if ( (*p) > 90u ) {
		if ( 97u <= (*p) && (*p) <= 122u )
			goto tr5;
	} else
		goto tr5;
	goto st0;
tr4:
#line 36 "HttpParser.rl"
	{ mark = p; }
	goto st4;
st4:
	if ( ++p == pe )
		goto _test_eof4;
case 4:
#line 196 "HttpParser.d"
	switch( (*p) ) {
		case 32u: goto tr8;
		case 35u: goto tr9;
		default: break;
	}
	goto st0;
tr8:
#line 38 "HttpParser.rl"
	{
    on_request_uri(get_mark_str(mark, p, buffer));
    mark = null;
  }
	goto st5;
tr30:
#line 36 "HttpParser.rl"
	{ mark = p; }
#line 43 "HttpParser.rl"
	{
    on_fragment(get_mark_str(mark, p, buffer));
    mark = null;
  }
	goto st5;
tr33:
#line 43 "HttpParser.rl"
	{
    on_fragment(get_mark_str(mark, p, buffer));
    mark = null;
  }
	goto st5;
tr41:
#line 70 "HttpParser.rl"
	{
    on_request_path(get_mark_str(mark, p, buffer));
  }
#line 38 "HttpParser.rl"
	{
    on_request_uri(get_mark_str(mark, p, buffer));
    mark = null;
  }
	goto st5;
tr52:
#line 74 "HttpParser.rl"
	{ 
    assert(mark);
    query_pos = saved_mark_buf.length + (p - mark);
  }
#line 79 "HttpParser.rl"
	{
    on_query_string(get_mark_str(mark, p, buffer)[query_pos..$]);
    query_pos = 0;
  }
#line 38 "HttpParser.rl"
	{
    on_request_uri(get_mark_str(mark, p, buffer));
    mark = null;
  }
	goto st5;
tr56:
#line 79 "HttpParser.rl"
	{
    on_query_string(get_mark_str(mark, p, buffer)[query_pos..$]);
    query_pos = 0;
  }
#line 38 "HttpParser.rl"
	{
    on_request_uri(get_mark_str(mark, p, buffer));
    mark = null;
  }
	goto st5;
st5:
	if ( ++p == pe )
		goto _test_eof5;
case 5:
#line 270 "HttpParser.d"
	if ( (*p) == 72u )
		goto tr10;
	goto st0;
tr10:
#line 36 "HttpParser.rl"
	{ mark = p; }
	goto st6;
st6:
	if ( ++p == pe )
		goto _test_eof6;
case 6:
#line 282 "HttpParser.d"
	if ( (*p) == 84u )
		goto st7;
	goto st0;
st7:
	if ( ++p == pe )
		goto _test_eof7;
case 7:
	if ( (*p) == 84u )
		goto st8;
	goto st0;
st8:
	if ( ++p == pe )
		goto _test_eof8;
case 8:
	if ( (*p) == 80u )
		goto st9;
	goto st0;
st9:
	if ( ++p == pe )
		goto _test_eof9;
case 9:
	if ( (*p) == 47u )
		goto st10;
	goto st0;
st10:
	if ( ++p == pe )
		goto _test_eof10;
case 10:
	if ( 48u <= (*p) && (*p) <= 57u )
		goto st11;
	goto st0;
st11:
	if ( ++p == pe )
		goto _test_eof11;
case 11:
	if ( (*p) == 46u )
		goto st12;
	if ( 48u <= (*p) && (*p) <= 57u )
		goto st11;
	goto st0;
st12:
	if ( ++p == pe )
		goto _test_eof12;
case 12:
	if ( 48u <= (*p) && (*p) <= 57u )
		goto st13;
	goto st0;
st13:
	if ( ++p == pe )
		goto _test_eof13;
case 13:
	if ( (*p) == 13u )
		goto tr18;
	if ( 48u <= (*p) && (*p) <= 57u )
		goto st13;
	goto st0;
tr18:
#line 53 "HttpParser.rl"
	{	
    on_http_version(get_mark_str(mark, p, buffer));
    mark = null;
  }
	goto st14;
tr26:
#line 36 "HttpParser.rl"
	{ mark = p; }
#line 64 "HttpParser.rl"
	{
    on_http_field(saved_field, get_mark_str(mark, p, buffer));
    saved_field.length = 0;
    mark = null;
  }
	goto st14;
tr29:
#line 64 "HttpParser.rl"
	{
    on_http_field(saved_field, get_mark_str(mark, p, buffer));
    saved_field.length = 0;
    mark = null;
  }
	goto st14;
st14:
	if ( ++p == pe )
		goto _test_eof14;
case 14:
#line 368 "HttpParser.d"
	if ( (*p) == 10u )
		goto st15;
	goto st0;
st15:
	if ( ++p == pe )
		goto _test_eof15;
case 15:
	switch( (*p) ) {
		case 13u: goto st16;
		case 33u: goto tr21;
		case 124u: goto tr21;
		case 126u: goto tr21;
		default: break;
	}
	if ( (*p) < 45u ) {
		if ( (*p) > 39u ) {
			if ( 42u <= (*p) && (*p) <= 43u )
				goto tr21;
		} else if ( (*p) >= 35u )
			goto tr21;
	} else if ( (*p) > 46u ) {
		if ( (*p) < 65u ) {
			if ( 48u <= (*p) && (*p) <= 57u )
				goto tr21;
		} else if ( (*p) > 90u ) {
			if ( 94u <= (*p) && (*p) <= 122u )
				goto tr21;
		} else
			goto tr21;
	} else
		goto tr21;
	goto st0;
st16:
	if ( ++p == pe )
		goto _test_eof16;
case 16:
	if ( (*p) == 10u )
		goto tr22;
	goto st0;
tr22:
#line 84 "HttpParser.rl"
	{ 
    on_header_done(buffer[(p - buffer.ptr + 1) .. $]);
    {p++; cs = 57; if (true) goto _out;}
  }
	goto st57;
st57:
	if ( ++p == pe )
		goto _test_eof57;
case 57:
#line 419 "HttpParser.d"
	goto st0;
tr21:
#line 36 "HttpParser.rl"
	{ mark = p; }
	goto st17;
st17:
	if ( ++p == pe )
		goto _test_eof17;
case 17:
#line 429 "HttpParser.d"
	switch( (*p) ) {
		case 33u: goto st17;
		case 58u: goto tr24;
		case 124u: goto st17;
		case 126u: goto st17;
		default: break;
	}
	if ( (*p) < 45u ) {
		if ( (*p) > 39u ) {
			if ( 42u <= (*p) && (*p) <= 43u )
				goto st17;
		} else if ( (*p) >= 35u )
			goto st17;
	} else if ( (*p) > 46u ) {
		if ( (*p) < 65u ) {
			if ( 48u <= (*p) && (*p) <= 57u )
				goto st17;
		} else if ( (*p) > 90u ) {
			if ( 94u <= (*p) && (*p) <= 122u )
				goto st17;
		} else
			goto st17;
	} else
		goto st17;
	goto st0;
tr27:
#line 36 "HttpParser.rl"
	{ mark = p; }
	goto st18;
tr24:
#line 58 "HttpParser.rl"
	{
    saved_field = get_mark_str(mark, p, buffer);
    upcase_str(saved_field);
    mark = null;
  }
	goto st18;
st18:
	if ( ++p == pe )
		goto _test_eof18;
case 18:
#line 471 "HttpParser.d"
	switch( (*p) ) {
		case 13u: goto tr26;
		case 32u: goto tr27;
		default: break;
	}
	goto tr25;
tr25:
#line 36 "HttpParser.rl"
	{ mark = p; }
	goto st19;
st19:
	if ( ++p == pe )
		goto _test_eof19;
case 19:
#line 486 "HttpParser.d"
	if ( (*p) == 13u )
		goto tr29;
	goto st19;
tr9:
#line 38 "HttpParser.rl"
	{
    on_request_uri(get_mark_str(mark, p, buffer));
    mark = null;
  }
	goto st20;
tr43:
#line 70 "HttpParser.rl"
	{
    on_request_path(get_mark_str(mark, p, buffer));
  }
#line 38 "HttpParser.rl"
	{
    on_request_uri(get_mark_str(mark, p, buffer));
    mark = null;
  }
	goto st20;
tr54:
#line 74 "HttpParser.rl"
	{ 
    assert(mark);
    query_pos = saved_mark_buf.length + (p - mark);
  }
#line 79 "HttpParser.rl"
	{
    on_query_string(get_mark_str(mark, p, buffer)[query_pos..$]);
    query_pos = 0;
  }
#line 38 "HttpParser.rl"
	{
    on_request_uri(get_mark_str(mark, p, buffer));
    mark = null;
  }
	goto st20;
tr58:
#line 79 "HttpParser.rl"
	{
    on_query_string(get_mark_str(mark, p, buffer)[query_pos..$]);
    query_pos = 0;
  }
#line 38 "HttpParser.rl"
	{
    on_request_uri(get_mark_str(mark, p, buffer));
    mark = null;
  }
	goto st20;
st20:
	if ( ++p == pe )
		goto _test_eof20;
case 20:
#line 541 "HttpParser.d"
	switch( (*p) ) {
		case 32u: goto tr30;
		case 37u: goto tr32;
		case 60u: goto st0;
		case 62u: goto st0;
		case 127u: goto st0;
		default: break;
	}
	if ( (*p) > 31u ) {
		if ( 34u <= (*p) && (*p) <= 35u )
			goto st0;
	} else
		goto st0;
	goto tr31;
tr31:
#line 36 "HttpParser.rl"
	{ mark = p; }
	goto st21;
st21:
	if ( ++p == pe )
		goto _test_eof21;
case 21:
#line 564 "HttpParser.d"
	switch( (*p) ) {
		case 32u: goto tr33;
		case 37u: goto st22;
		case 60u: goto st0;
		case 62u: goto st0;
		case 127u: goto st0;
		default: break;
	}
	if ( (*p) > 31u ) {
		if ( 34u <= (*p) && (*p) <= 35u )
			goto st0;
	} else
		goto st0;
	goto st21;
tr32:
#line 36 "HttpParser.rl"
	{ mark = p; }
	goto st22;
st22:
	if ( ++p == pe )
		goto _test_eof22;
case 22:
#line 587 "HttpParser.d"
	if ( (*p) < 65u ) {
		if ( 48u <= (*p) && (*p) <= 57u )
			goto st23;
	} else if ( (*p) > 70u ) {
		if ( 97u <= (*p) && (*p) <= 102u )
			goto st23;
	} else
		goto st23;
	goto st0;
st23:
	if ( ++p == pe )
		goto _test_eof23;
case 23:
	if ( (*p) < 65u ) {
		if ( 48u <= (*p) && (*p) <= 57u )
			goto st21;
	} else if ( (*p) > 70u ) {
		if ( 97u <= (*p) && (*p) <= 102u )
			goto st21;
	} else
		goto st21;
	goto st0;
tr5:
#line 36 "HttpParser.rl"
	{ mark = p; }
	goto st24;
st24:
	if ( ++p == pe )
		goto _test_eof24;
case 24:
#line 618 "HttpParser.d"
	switch( (*p) ) {
		case 43u: goto st24;
		case 58u: goto st25;
		default: break;
	}
	if ( (*p) < 48u ) {
		if ( 45u <= (*p) && (*p) <= 46u )
			goto st24;
	} else if ( (*p) > 57u ) {
		if ( (*p) > 90u ) {
			if ( 97u <= (*p) && (*p) <= 122u )
				goto st24;
		} else if ( (*p) >= 65u )
			goto st24;
	} else
		goto st24;
	goto st0;
tr7:
#line 36 "HttpParser.rl"
	{ mark = p; }
	goto st25;
st25:
	if ( ++p == pe )
		goto _test_eof25;
case 25:
#line 644 "HttpParser.d"
	switch( (*p) ) {
		case 32u: goto tr8;
		case 34u: goto st0;
		case 35u: goto tr9;
		case 37u: goto st26;
		case 60u: goto st0;
		case 62u: goto st0;
		case 127u: goto st0;
		default: break;
	}
	if ( (*p) <= 31u )
		goto st0;
	goto st25;
st26:
	if ( ++p == pe )
		goto _test_eof26;
case 26:
	if ( (*p) < 65u ) {
		if ( 48u <= (*p) && (*p) <= 57u )
			goto st27;
	} else if ( (*p) > 70u ) {
		if ( 97u <= (*p) && (*p) <= 102u )
			goto st27;
	} else
		goto st27;
	goto st0;
st27:
	if ( ++p == pe )
		goto _test_eof27;
case 27:
	if ( (*p) < 65u ) {
		if ( 48u <= (*p) && (*p) <= 57u )
			goto st25;
	} else if ( (*p) > 70u ) {
		if ( 97u <= (*p) && (*p) <= 102u )
			goto st25;
	} else
		goto st25;
	goto st0;
tr6:
#line 36 "HttpParser.rl"
	{ mark = p; }
	goto st28;
st28:
	if ( ++p == pe )
		goto _test_eof28;
case 28:
#line 692 "HttpParser.d"
	switch( (*p) ) {
		case 32u: goto tr41;
		case 34u: goto st0;
		case 35u: goto tr43;
		case 37u: goto st29;
		case 59u: goto tr45;
		case 60u: goto st0;
		case 62u: goto st0;
		case 63u: goto tr46;
		case 127u: goto st0;
		default: break;
	}
	if ( (*p) <= 31u )
		goto st0;
	goto st28;
st29:
	if ( ++p == pe )
		goto _test_eof29;
case 29:
	if ( (*p) < 65u ) {
		if ( 48u <= (*p) && (*p) <= 57u )
			goto st30;
	} else if ( (*p) > 70u ) {
		if ( 97u <= (*p) && (*p) <= 102u )
			goto st30;
	} else
		goto st30;
	goto st0;
st30:
	if ( ++p == pe )
		goto _test_eof30;
case 30:
	if ( (*p) < 65u ) {
		if ( 48u <= (*p) && (*p) <= 57u )
			goto st28;
	} else if ( (*p) > 70u ) {
		if ( 97u <= (*p) && (*p) <= 102u )
			goto st28;
	} else
		goto st28;
	goto st0;
tr45:
#line 70 "HttpParser.rl"
	{
    on_request_path(get_mark_str(mark, p, buffer));
  }
	goto st31;
st31:
	if ( ++p == pe )
		goto _test_eof31;
case 31:
#line 744 "HttpParser.d"
	switch( (*p) ) {
		case 32u: goto tr8;
		case 34u: goto st0;
		case 35u: goto tr9;
		case 37u: goto st32;
		case 60u: goto st0;
		case 62u: goto st0;
		case 63u: goto st34;
		case 127u: goto st0;
		default: break;
	}
	if ( (*p) <= 31u )
		goto st0;
	goto st31;
st32:
	if ( ++p == pe )
		goto _test_eof32;
case 32:
	if ( (*p) < 65u ) {
		if ( 48u <= (*p) && (*p) <= 57u )
			goto st33;
	} else if ( (*p) > 70u ) {
		if ( 97u <= (*p) && (*p) <= 102u )
			goto st33;
	} else
		goto st33;
	goto st0;
st33:
	if ( ++p == pe )
		goto _test_eof33;
case 33:
	if ( (*p) < 65u ) {
		if ( 48u <= (*p) && (*p) <= 57u )
			goto st31;
	} else if ( (*p) > 70u ) {
		if ( 97u <= (*p) && (*p) <= 102u )
			goto st31;
	} else
		goto st31;
	goto st0;
tr46:
#line 70 "HttpParser.rl"
	{
    on_request_path(get_mark_str(mark, p, buffer));
  }
	goto st34;
st34:
	if ( ++p == pe )
		goto _test_eof34;
case 34:
#line 795 "HttpParser.d"
	switch( (*p) ) {
		case 32u: goto tr52;
		case 34u: goto st0;
		case 35u: goto tr54;
		case 37u: goto tr55;
		case 60u: goto st0;
		case 62u: goto st0;
		case 127u: goto st0;
		default: break;
	}
	if ( (*p) <= 31u )
		goto st0;
	goto tr53;
tr53:
#line 74 "HttpParser.rl"
	{ 
    assert(mark);
    query_pos = saved_mark_buf.length + (p - mark);
  }
	goto st35;
st35:
	if ( ++p == pe )
		goto _test_eof35;
case 35:
#line 820 "HttpParser.d"
	switch( (*p) ) {
		case 32u: goto tr56;
		case 34u: goto st0;
		case 35u: goto tr58;
		case 37u: goto st36;
		case 60u: goto st0;
		case 62u: goto st0;
		case 127u: goto st0;
		default: break;
	}
	if ( (*p) <= 31u )
		goto st0;
	goto st35;
tr55:
#line 74 "HttpParser.rl"
	{ 
    assert(mark);
    query_pos = saved_mark_buf.length + (p - mark);
  }
	goto st36;
st36:
	if ( ++p == pe )
		goto _test_eof36;
case 36:
#line 845 "HttpParser.d"
	if ( (*p) < 65u ) {
		if ( 48u <= (*p) && (*p) <= 57u )
			goto st37;
	} else if ( (*p) > 70u ) {
		if ( 97u <= (*p) && (*p) <= 102u )
			goto st37;
	} else
		goto st37;
	goto st0;
st37:
	if ( ++p == pe )
		goto _test_eof37;
case 37:
	if ( (*p) < 65u ) {
		if ( 48u <= (*p) && (*p) <= 57u )
			goto st35;
	} else if ( (*p) > 70u ) {
		if ( 97u <= (*p) && (*p) <= 102u )
			goto st35;
	} else
		goto st35;
	goto st0;
st38:
	if ( ++p == pe )
		goto _test_eof38;
case 38:
	switch( (*p) ) {
		case 32u: goto tr2;
		case 36u: goto st39;
		case 95u: goto st39;
		default: break;
	}
	if ( (*p) < 48u ) {
		if ( 45u <= (*p) && (*p) <= 46u )
			goto st39;
	} else if ( (*p) > 57u ) {
		if ( 65u <= (*p) && (*p) <= 90u )
			goto st39;
	} else
		goto st39;
	goto st0;
st39:
	if ( ++p == pe )
		goto _test_eof39;
case 39:
	switch( (*p) ) {
		case 32u: goto tr2;
		case 36u: goto st40;
		case 95u: goto st40;
		default: break;
	}
	if ( (*p) < 48u ) {
		if ( 45u <= (*p) && (*p) <= 46u )
			goto st40;
	} else if ( (*p) > 57u ) {
		if ( 65u <= (*p) && (*p) <= 90u )
			goto st40;
	} else
		goto st40;
	goto st0;
st40:
	if ( ++p == pe )
		goto _test_eof40;
case 40:
	switch( (*p) ) {
		case 32u: goto tr2;
		case 36u: goto st41;
		case 95u: goto st41;
		default: break;
	}
	if ( (*p) < 48u ) {
		if ( 45u <= (*p) && (*p) <= 46u )
			goto st41;
	} else if ( (*p) > 57u ) {
		if ( 65u <= (*p) && (*p) <= 90u )
			goto st41;
	} else
		goto st41;
	goto st0;
st41:
	if ( ++p == pe )
		goto _test_eof41;
case 41:
	switch( (*p) ) {
		case 32u: goto tr2;
		case 36u: goto st42;
		case 95u: goto st42;
		default: break;
	}
	if ( (*p) < 48u ) {
		if ( 45u <= (*p) && (*p) <= 46u )
			goto st42;
	} else if ( (*p) > 57u ) {
		if ( 65u <= (*p) && (*p) <= 90u )
			goto st42;
	} else
		goto st42;
	goto st0;
st42:
	if ( ++p == pe )
		goto _test_eof42;
case 42:
	switch( (*p) ) {
		case 32u: goto tr2;
		case 36u: goto st43;
		case 95u: goto st43;
		default: break;
	}
	if ( (*p) < 48u ) {
		if ( 45u <= (*p) && (*p) <= 46u )
			goto st43;
	} else if ( (*p) > 57u ) {
		if ( 65u <= (*p) && (*p) <= 90u )
			goto st43;
	} else
		goto st43;
	goto st0;
st43:
	if ( ++p == pe )
		goto _test_eof43;
case 43:
	switch( (*p) ) {
		case 32u: goto tr2;
		case 36u: goto st44;
		case 95u: goto st44;
		default: break;
	}
	if ( (*p) < 48u ) {
		if ( 45u <= (*p) && (*p) <= 46u )
			goto st44;
	} else if ( (*p) > 57u ) {
		if ( 65u <= (*p) && (*p) <= 90u )
			goto st44;
	} else
		goto st44;
	goto st0;
st44:
	if ( ++p == pe )
		goto _test_eof44;
case 44:
	switch( (*p) ) {
		case 32u: goto tr2;
		case 36u: goto st45;
		case 95u: goto st45;
		default: break;
	}
	if ( (*p) < 48u ) {
		if ( 45u <= (*p) && (*p) <= 46u )
			goto st45;
	} else if ( (*p) > 57u ) {
		if ( 65u <= (*p) && (*p) <= 90u )
			goto st45;
	} else
		goto st45;
	goto st0;
st45:
	if ( ++p == pe )
		goto _test_eof45;
case 45:
	switch( (*p) ) {
		case 32u: goto tr2;
		case 36u: goto st46;
		case 95u: goto st46;
		default: break;
	}
	if ( (*p) < 48u ) {
		if ( 45u <= (*p) && (*p) <= 46u )
			goto st46;
	} else if ( (*p) > 57u ) {
		if ( 65u <= (*p) && (*p) <= 90u )
			goto st46;
	} else
		goto st46;
	goto st0;
st46:
	if ( ++p == pe )
		goto _test_eof46;
case 46:
	switch( (*p) ) {
		case 32u: goto tr2;
		case 36u: goto st47;
		case 95u: goto st47;
		default: break;
	}
	if ( (*p) < 48u ) {
		if ( 45u <= (*p) && (*p) <= 46u )
			goto st47;
	} else if ( (*p) > 57u ) {
		if ( 65u <= (*p) && (*p) <= 90u )
			goto st47;
	} else
		goto st47;
	goto st0;
st47:
	if ( ++p == pe )
		goto _test_eof47;
case 47:
	switch( (*p) ) {
		case 32u: goto tr2;
		case 36u: goto st48;
		case 95u: goto st48;
		default: break;
	}
	if ( (*p) < 48u ) {
		if ( 45u <= (*p) && (*p) <= 46u )
			goto st48;
	} else if ( (*p) > 57u ) {
		if ( 65u <= (*p) && (*p) <= 90u )
			goto st48;
	} else
		goto st48;
	goto st0;
st48:
	if ( ++p == pe )
		goto _test_eof48;
case 48:
	switch( (*p) ) {
		case 32u: goto tr2;
		case 36u: goto st49;
		case 95u: goto st49;
		default: break;
	}
	if ( (*p) < 48u ) {
		if ( 45u <= (*p) && (*p) <= 46u )
			goto st49;
	} else if ( (*p) > 57u ) {
		if ( 65u <= (*p) && (*p) <= 90u )
			goto st49;
	} else
		goto st49;
	goto st0;
st49:
	if ( ++p == pe )
		goto _test_eof49;
case 49:
	switch( (*p) ) {
		case 32u: goto tr2;
		case 36u: goto st50;
		case 95u: goto st50;
		default: break;
	}
	if ( (*p) < 48u ) {
		if ( 45u <= (*p) && (*p) <= 46u )
			goto st50;
	} else if ( (*p) > 57u ) {
		if ( 65u <= (*p) && (*p) <= 90u )
			goto st50;
	} else
		goto st50;
	goto st0;
st50:
	if ( ++p == pe )
		goto _test_eof50;
case 50:
	switch( (*p) ) {
		case 32u: goto tr2;
		case 36u: goto st51;
		case 95u: goto st51;
		default: break;
	}
	if ( (*p) < 48u ) {
		if ( 45u <= (*p) && (*p) <= 46u )
			goto st51;
	} else if ( (*p) > 57u ) {
		if ( 65u <= (*p) && (*p) <= 90u )
			goto st51;
	} else
		goto st51;
	goto st0;
st51:
	if ( ++p == pe )
		goto _test_eof51;
case 51:
	switch( (*p) ) {
		case 32u: goto tr2;
		case 36u: goto st52;
		case 95u: goto st52;
		default: break;
	}
	if ( (*p) < 48u ) {
		if ( 45u <= (*p) && (*p) <= 46u )
			goto st52;
	} else if ( (*p) > 57u ) {
		if ( 65u <= (*p) && (*p) <= 90u )
			goto st52;
	} else
		goto st52;
	goto st0;
st52:
	if ( ++p == pe )
		goto _test_eof52;
case 52:
	switch( (*p) ) {
		case 32u: goto tr2;
		case 36u: goto st53;
		case 95u: goto st53;
		default: break;
	}
	if ( (*p) < 48u ) {
		if ( 45u <= (*p) && (*p) <= 46u )
			goto st53;
	} else if ( (*p) > 57u ) {
		if ( 65u <= (*p) && (*p) <= 90u )
			goto st53;
	} else
		goto st53;
	goto st0;
st53:
	if ( ++p == pe )
		goto _test_eof53;
case 53:
	switch( (*p) ) {
		case 32u: goto tr2;
		case 36u: goto st54;
		case 95u: goto st54;
		default: break;
	}
	if ( (*p) < 48u ) {
		if ( 45u <= (*p) && (*p) <= 46u )
			goto st54;
	} else if ( (*p) > 57u ) {
		if ( 65u <= (*p) && (*p) <= 90u )
			goto st54;
	} else
		goto st54;
	goto st0;
st54:
	if ( ++p == pe )
		goto _test_eof54;
case 54:
	switch( (*p) ) {
		case 32u: goto tr2;
		case 36u: goto st55;
		case 95u: goto st55;
		default: break;
	}
	if ( (*p) < 48u ) {
		if ( 45u <= (*p) && (*p) <= 46u )
			goto st55;
	} else if ( (*p) > 57u ) {
		if ( 65u <= (*p) && (*p) <= 90u )
			goto st55;
	} else
		goto st55;
	goto st0;
st55:
	if ( ++p == pe )
		goto _test_eof55;
case 55:
	switch( (*p) ) {
		case 32u: goto tr2;
		case 36u: goto st56;
		case 95u: goto st56;
		default: break;
	}
	if ( (*p) < 48u ) {
		if ( 45u <= (*p) && (*p) <= 46u )
			goto st56;
	} else if ( (*p) > 57u ) {
		if ( 65u <= (*p) && (*p) <= 90u )
			goto st56;
	} else
		goto st56;
	goto st0;
st56:
	if ( ++p == pe )
		goto _test_eof56;
case 56:
	if ( (*p) == 32u )
		goto tr2;
	goto st0;
		default: break;
	}
	_test_eof2: cs = 2; goto _test_eof; 
	_test_eof3: cs = 3; goto _test_eof; 
	_test_eof4: cs = 4; goto _test_eof; 
	_test_eof5: cs = 5; goto _test_eof; 
	_test_eof6: cs = 6; goto _test_eof; 
	_test_eof7: cs = 7; goto _test_eof; 
	_test_eof8: cs = 8; goto _test_eof; 
	_test_eof9: cs = 9; goto _test_eof; 
	_test_eof10: cs = 10; goto _test_eof; 
	_test_eof11: cs = 11; goto _test_eof; 
	_test_eof12: cs = 12; goto _test_eof; 
	_test_eof13: cs = 13; goto _test_eof; 
	_test_eof14: cs = 14; goto _test_eof; 
	_test_eof15: cs = 15; goto _test_eof; 
	_test_eof16: cs = 16; goto _test_eof; 
	_test_eof57: cs = 57; goto _test_eof; 
	_test_eof17: cs = 17; goto _test_eof; 
	_test_eof18: cs = 18; goto _test_eof; 
	_test_eof19: cs = 19; goto _test_eof; 
	_test_eof20: cs = 20; goto _test_eof; 
	_test_eof21: cs = 21; goto _test_eof; 
	_test_eof22: cs = 22; goto _test_eof; 
	_test_eof23: cs = 23; goto _test_eof; 
	_test_eof24: cs = 24; goto _test_eof; 
	_test_eof25: cs = 25; goto _test_eof; 
	_test_eof26: cs = 26; goto _test_eof; 
	_test_eof27: cs = 27; goto _test_eof; 
	_test_eof28: cs = 28; goto _test_eof; 
	_test_eof29: cs = 29; goto _test_eof; 
	_test_eof30: cs = 30; goto _test_eof; 
	_test_eof31: cs = 31; goto _test_eof; 
	_test_eof32: cs = 32; goto _test_eof; 
	_test_eof33: cs = 33; goto _test_eof; 
	_test_eof34: cs = 34; goto _test_eof; 
	_test_eof35: cs = 35; goto _test_eof; 
	_test_eof36: cs = 36; goto _test_eof; 
	_test_eof37: cs = 37; goto _test_eof; 
	_test_eof38: cs = 38; goto _test_eof; 
	_test_eof39: cs = 39; goto _test_eof; 
	_test_eof40: cs = 40; goto _test_eof; 
	_test_eof41: cs = 41; goto _test_eof; 
	_test_eof42: cs = 42; goto _test_eof; 
	_test_eof43: cs = 43; goto _test_eof; 
	_test_eof44: cs = 44; goto _test_eof; 
	_test_eof45: cs = 45; goto _test_eof; 
	_test_eof46: cs = 46; goto _test_eof; 
	_test_eof47: cs = 47; goto _test_eof; 
	_test_eof48: cs = 48; goto _test_eof; 
	_test_eof49: cs = 49; goto _test_eof; 
	_test_eof50: cs = 50; goto _test_eof; 
	_test_eof51: cs = 51; goto _test_eof; 
	_test_eof52: cs = 52; goto _test_eof; 
	_test_eof53: cs = 53; goto _test_eof; 
	_test_eof54: cs = 54; goto _test_eof; 
	_test_eof55: cs = 55; goto _test_eof; 
	_test_eof56: cs = 56; goto _test_eof; 

	_test_eof: {}
	_out: {}
	}

#line 151 "HttpParser.rl"
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
