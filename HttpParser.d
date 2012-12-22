
#line 1 "HttpParser.rl"
/**
 * Copyright (c) 2005 Zed A. Shaw
 * You can redistribute it and/or modify it under the same terms as Ruby.
 *
 * Copyright (c) 2012 by Michael Neumann (mneumann@ntecs.de)
 */

// compile with ragel -G2 -D ...

import std.stdio;

/** Machine **/


#line 81 "HttpParser.rl"


/** Data **/

#line 23 "HttpParser.d"
static const int http_parser_start = 1;
static const int http_parser_first_final = 89;
static const int http_parser_error = 0;

static const int http_parser_en_main = 1;


#line 85 "HttpParser.rl"

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
    
#line 76 "HttpParser.d"
	{
	cs = http_parser_start;
	}

#line 129 "HttpParser.rl"
    saved_cs = cs;
  }

  size_t execute(const char buffer[])
  {
    assert(buffer.length > 0);

    // Ragel uses: cs, p, pe
    int cs = saved_cs;           // current ragel machine state
    const(char) *p = &buffer[0];        // pointer to start of data
    const(char) *pe = &buffer[$-1] + 1; // pointer to end of data

    
#line 95 "HttpParser.d"
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
#line 18 "HttpParser.rl"
	{
    mark = cast(BytePos)(p - buffer.ptr);
  }
	goto st2;
st2:
	if ( ++p == pe )
		goto _test_eof2;
case 2:
#line 129 "HttpParser.d"
	switch( (*p) ) {
		case 32u: goto tr2;
		case 36u: goto st70;
		case 95u: goto st70;
		default: break;
	}
	if ( (*p) < 48u ) {
		if ( 45u <= (*p) && (*p) <= 46u )
			goto st70;
	} else if ( (*p) > 57u ) {
		if ( 65u <= (*p) && (*p) <= 90u )
			goto st70;
	} else
		goto st70;
	goto st0;
tr2:
#line 30 "HttpParser.rl"
	{ 
    on_request_method(BytePosRange(mark, cast(BytePos)(p - buffer.ptr)));
  }
	goto st3;
st3:
	if ( ++p == pe )
		goto _test_eof3;
case 3:
#line 155 "HttpParser.d"
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
#line 18 "HttpParser.rl"
	{
    mark = cast(BytePos)(p - buffer.ptr);
  }
	goto st4;
st4:
	if ( ++p == pe )
		goto _test_eof4;
case 4:
#line 182 "HttpParser.d"
	switch( (*p) ) {
		case 32u: goto tr8;
		case 35u: goto tr9;
		default: break;
	}
	goto st0;
tr8:
#line 22 "HttpParser.rl"
	{
    on_request_uri(BytePosRange(mark, cast(BytePos)(p - buffer.ptr)));
  }
	goto st5;
tr78:
#line 18 "HttpParser.rl"
	{
    mark = cast(BytePos)(p - buffer.ptr);
  }
#line 26 "HttpParser.rl"
	{
    on_fragment(BytePosRange(mark, cast(BytePos)(p - buffer.ptr)));
  }
	goto st5;
tr81:
#line 26 "HttpParser.rl"
	{
    on_fragment(BytePosRange(mark, cast(BytePos)(p - buffer.ptr)));
  }
	goto st5;
tr89:
#line 38 "HttpParser.rl"
	{
    on_request_path(BytePosRange(mark, cast(BytePos)(p - buffer.ptr)));
  }
#line 22 "HttpParser.rl"
	{
    on_request_uri(BytePosRange(mark, cast(BytePos)(p - buffer.ptr)));
  }
	goto st5;
tr100:
#line 42 "HttpParser.rl"
	{ 
    mark_query = cast(BytePos)(p - buffer.ptr);
  }
#line 46 "HttpParser.rl"
	{
    on_query(BytePosRange(mark_query, cast(BytePos)(p - buffer.ptr)));
  }
#line 22 "HttpParser.rl"
	{
    on_request_uri(BytePosRange(mark, cast(BytePos)(p - buffer.ptr)));
  }
	goto st5;
tr104:
#line 46 "HttpParser.rl"
	{
    on_query(BytePosRange(mark_query, cast(BytePos)(p - buffer.ptr)));
  }
#line 22 "HttpParser.rl"
	{
    on_request_uri(BytePosRange(mark, cast(BytePos)(p - buffer.ptr)));
  }
	goto st5;
st5:
	if ( ++p == pe )
		goto _test_eof5;
case 5:
#line 249 "HttpParser.d"
	if ( (*p) == 72u )
		goto tr10;
	goto st0;
tr10:
#line 18 "HttpParser.rl"
	{
    mark = cast(BytePos)(p - buffer.ptr);
  }
	goto st6;
st6:
	if ( ++p == pe )
		goto _test_eof6;
case 6:
#line 263 "HttpParser.d"
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
#line 34 "HttpParser.rl"
	{	
    on_http_version(BytePosRange(mark, cast(BytePos)(p - buffer.ptr)));
  }
	goto st14;
tr29:
#line 18 "HttpParser.rl"
	{
    mark = cast(BytePos)(p - buffer.ptr);
  }
#line 70 "HttpParser.rl"
	{
    on_field(BytePosRange2(field_name, BytePosRange(mark, cast(BytePos)(p - buffer.ptr))));
  }
	goto st14;
tr32:
#line 70 "HttpParser.rl"
	{
    on_field(BytePosRange2(field_name, BytePosRange(mark, cast(BytePos)(p - buffer.ptr))));
  }
	goto st14;
tr49:
#line 18 "HttpParser.rl"
	{
    mark = cast(BytePos)(p - buffer.ptr);
  }
#line 54 "HttpParser.rl"
	{
    on_field_accept_charset(BytePosRange(mark, cast(BytePos)(p - buffer.ptr)));
  }
#line 70 "HttpParser.rl"
	{
    on_field(BytePosRange2(field_name, BytePosRange(mark, cast(BytePos)(p - buffer.ptr))));
  }
	goto st14;
tr52:
#line 54 "HttpParser.rl"
	{
    on_field_accept_charset(BytePosRange(mark, cast(BytePos)(p - buffer.ptr)));
  }
#line 70 "HttpParser.rl"
	{
    on_field(BytePosRange2(field_name, BytePosRange(mark, cast(BytePos)(p - buffer.ptr))));
  }
	goto st14;
tr54:
#line 18 "HttpParser.rl"
	{
    mark = cast(BytePos)(p - buffer.ptr);
  }
#line 50 "HttpParser.rl"
	{
    on_field_accept(BytePosRange(mark, cast(BytePos)(p - buffer.ptr)));
  }
#line 70 "HttpParser.rl"
	{
    on_field(BytePosRange2(field_name, BytePosRange(mark, cast(BytePos)(p - buffer.ptr))));
  }
	goto st14;
tr57:
#line 50 "HttpParser.rl"
	{
    on_field_accept(BytePosRange(mark, cast(BytePos)(p - buffer.ptr)));
  }
#line 70 "HttpParser.rl"
	{
    on_field(BytePosRange2(field_name, BytePosRange(mark, cast(BytePos)(p - buffer.ptr))));
  }
	goto st14;
tr65:
#line 18 "HttpParser.rl"
	{
    mark = cast(BytePos)(p - buffer.ptr);
  }
#line 58 "HttpParser.rl"
	{
    on_field_cookie(BytePosRange(mark, cast(BytePos)(p - buffer.ptr)));
  }
#line 70 "HttpParser.rl"
	{
    on_field(BytePosRange2(field_name, BytePosRange(mark, cast(BytePos)(p - buffer.ptr))));
  }
	goto st14;
tr68:
#line 58 "HttpParser.rl"
	{
    on_field_cookie(BytePosRange(mark, cast(BytePos)(p - buffer.ptr)));
  }
#line 70 "HttpParser.rl"
	{
    on_field(BytePosRange2(field_name, BytePosRange(mark, cast(BytePos)(p - buffer.ptr))));
  }
	goto st14;
tr74:
#line 18 "HttpParser.rl"
	{
    mark = cast(BytePos)(p - buffer.ptr);
  }
#line 62 "HttpParser.rl"
	{
    on_field_date(BytePosRange(mark, cast(BytePos)(p - buffer.ptr)));
  }
#line 70 "HttpParser.rl"
	{
    on_field(BytePosRange2(field_name, BytePosRange(mark, cast(BytePos)(p - buffer.ptr))));
  }
	goto st14;
tr77:
#line 62 "HttpParser.rl"
	{
    on_field_date(BytePosRange(mark, cast(BytePos)(p - buffer.ptr)));
  }
#line 70 "HttpParser.rl"
	{
    on_field(BytePosRange2(field_name, BytePosRange(mark, cast(BytePos)(p - buffer.ptr))));
  }
	goto st14;
st14:
	if ( ++p == pe )
		goto _test_eof14;
case 14:
#line 442 "HttpParser.d"
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
		case 65u: goto tr22;
		case 67u: goto tr23;
		case 68u: goto tr24;
		case 97u: goto tr22;
		case 99u: goto tr23;
		case 100u: goto tr24;
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
		if ( (*p) < 66u ) {
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
		goto tr25;
	goto st0;
tr25:
#line 74 "HttpParser.rl"
	{
    on_header_done(BytePosRange(cast(BytePos)(p - buffer.ptr + 1), cast(BytePos)(buffer.length)));
    {p++; cs = 89; if (true) goto _out;}
  }
	goto st89;
st89:
	if ( ++p == pe )
		goto _test_eof89;
case 89:
#line 499 "HttpParser.d"
	goto st0;
tr21:
#line 18 "HttpParser.rl"
	{
    mark = cast(BytePos)(p - buffer.ptr);
  }
	goto st17;
st17:
	if ( ++p == pe )
		goto _test_eof17;
case 17:
#line 511 "HttpParser.d"
	switch( (*p) ) {
		case 33u: goto st17;
		case 58u: goto tr27;
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
tr30:
#line 18 "HttpParser.rl"
	{
    mark = cast(BytePos)(p - buffer.ptr);
  }
	goto st18;
tr27:
#line 66 "HttpParser.rl"
	{
    field_name = BytePosRange(mark, cast(BytePos)(p - buffer.ptr));
  }
	goto st18;
st18:
	if ( ++p == pe )
		goto _test_eof18;
case 18:
#line 553 "HttpParser.d"
	switch( (*p) ) {
		case 13u: goto tr29;
		case 32u: goto tr30;
		default: break;
	}
	goto tr28;
tr28:
#line 18 "HttpParser.rl"
	{
    mark = cast(BytePos)(p - buffer.ptr);
  }
	goto st19;
st19:
	if ( ++p == pe )
		goto _test_eof19;
case 19:
#line 570 "HttpParser.d"
	if ( (*p) == 13u )
		goto tr32;
	goto st19;
tr22:
#line 18 "HttpParser.rl"
	{
    mark = cast(BytePos)(p - buffer.ptr);
  }
	goto st20;
st20:
	if ( ++p == pe )
		goto _test_eof20;
case 20:
#line 584 "HttpParser.d"
	switch( (*p) ) {
		case 33u: goto st17;
		case 58u: goto tr27;
		case 67u: goto st21;
		case 99u: goto st21;
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
st21:
	if ( ++p == pe )
		goto _test_eof21;
case 21:
	switch( (*p) ) {
		case 33u: goto st17;
		case 58u: goto tr27;
		case 67u: goto st22;
		case 99u: goto st22;
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
st22:
	if ( ++p == pe )
		goto _test_eof22;
case 22:
	switch( (*p) ) {
		case 33u: goto st17;
		case 58u: goto tr27;
		case 69u: goto st23;
		case 101u: goto st23;
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
st23:
	if ( ++p == pe )
		goto _test_eof23;
case 23:
	switch( (*p) ) {
		case 33u: goto st17;
		case 58u: goto tr27;
		case 80u: goto st24;
		case 112u: goto st24;
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
st24:
	if ( ++p == pe )
		goto _test_eof24;
case 24:
	switch( (*p) ) {
		case 33u: goto st17;
		case 58u: goto tr27;
		case 84u: goto st25;
		case 116u: goto st25;
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
st25:
	if ( ++p == pe )
		goto _test_eof25;
case 25:
	switch( (*p) ) {
		case 33u: goto st17;
		case 45u: goto st26;
		case 46u: goto st17;
		case 58u: goto tr39;
		case 124u: goto st17;
		case 126u: goto st17;
		default: break;
	}
	if ( (*p) < 48u ) {
		if ( (*p) > 39u ) {
			if ( 42u <= (*p) && (*p) <= 43u )
				goto st17;
		} else if ( (*p) >= 35u )
			goto st17;
	} else if ( (*p) > 57u ) {
		if ( (*p) > 90u ) {
			if ( 94u <= (*p) && (*p) <= 122u )
				goto st17;
		} else if ( (*p) >= 65u )
			goto st17;
	} else
		goto st17;
	goto st0;
st26:
	if ( ++p == pe )
		goto _test_eof26;
case 26:
	switch( (*p) ) {
		case 33u: goto st17;
		case 58u: goto tr27;
		case 67u: goto st27;
		case 99u: goto st27;
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
st27:
	if ( ++p == pe )
		goto _test_eof27;
case 27:
	switch( (*p) ) {
		case 33u: goto st17;
		case 58u: goto tr27;
		case 72u: goto st28;
		case 104u: goto st28;
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
st28:
	if ( ++p == pe )
		goto _test_eof28;
case 28:
	switch( (*p) ) {
		case 33u: goto st17;
		case 58u: goto tr27;
		case 65u: goto st29;
		case 97u: goto st29;
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
		if ( (*p) < 66u ) {
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
st29:
	if ( ++p == pe )
		goto _test_eof29;
case 29:
	switch( (*p) ) {
		case 33u: goto st17;
		case 58u: goto tr27;
		case 82u: goto st30;
		case 114u: goto st30;
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
st30:
	if ( ++p == pe )
		goto _test_eof30;
case 30:
	switch( (*p) ) {
		case 33u: goto st17;
		case 58u: goto tr27;
		case 83u: goto st31;
		case 115u: goto st31;
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
st31:
	if ( ++p == pe )
		goto _test_eof31;
case 31:
	switch( (*p) ) {
		case 33u: goto st17;
		case 58u: goto tr27;
		case 69u: goto st32;
		case 101u: goto st32;
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
st32:
	if ( ++p == pe )
		goto _test_eof32;
case 32:
	switch( (*p) ) {
		case 33u: goto st17;
		case 58u: goto tr27;
		case 84u: goto st33;
		case 116u: goto st33;
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
st33:
	if ( ++p == pe )
		goto _test_eof33;
case 33:
	switch( (*p) ) {
		case 33u: goto st17;
		case 58u: goto tr47;
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
tr50:
#line 18 "HttpParser.rl"
	{
    mark = cast(BytePos)(p - buffer.ptr);
  }
	goto st34;
tr47:
#line 66 "HttpParser.rl"
	{
    field_name = BytePosRange(mark, cast(BytePos)(p - buffer.ptr));
  }
	goto st34;
st34:
	if ( ++p == pe )
		goto _test_eof34;
case 34:
#line 1026 "HttpParser.d"
	switch( (*p) ) {
		case 13u: goto tr49;
		case 32u: goto tr50;
		default: break;
	}
	goto tr48;
tr48:
#line 18 "HttpParser.rl"
	{
    mark = cast(BytePos)(p - buffer.ptr);
  }
	goto st35;
st35:
	if ( ++p == pe )
		goto _test_eof35;
case 35:
#line 1043 "HttpParser.d"
	if ( (*p) == 13u )
		goto tr52;
	goto st35;
tr55:
#line 18 "HttpParser.rl"
	{
    mark = cast(BytePos)(p - buffer.ptr);
  }
	goto st36;
tr39:
#line 66 "HttpParser.rl"
	{
    field_name = BytePosRange(mark, cast(BytePos)(p - buffer.ptr));
  }
	goto st36;
st36:
	if ( ++p == pe )
		goto _test_eof36;
case 36:
#line 1063 "HttpParser.d"
	switch( (*p) ) {
		case 13u: goto tr54;
		case 32u: goto tr55;
		default: break;
	}
	goto tr53;
tr53:
#line 18 "HttpParser.rl"
	{
    mark = cast(BytePos)(p - buffer.ptr);
  }
	goto st37;
st37:
	if ( ++p == pe )
		goto _test_eof37;
case 37:
#line 1080 "HttpParser.d"
	if ( (*p) == 13u )
		goto tr57;
	goto st37;
tr23:
#line 18 "HttpParser.rl"
	{
    mark = cast(BytePos)(p - buffer.ptr);
  }
	goto st38;
st38:
	if ( ++p == pe )
		goto _test_eof38;
case 38:
#line 1094 "HttpParser.d"
	switch( (*p) ) {
		case 33u: goto st17;
		case 58u: goto tr27;
		case 79u: goto st39;
		case 111u: goto st39;
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
st39:
	if ( ++p == pe )
		goto _test_eof39;
case 39:
	switch( (*p) ) {
		case 33u: goto st17;
		case 58u: goto tr27;
		case 79u: goto st40;
		case 111u: goto st40;
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
st40:
	if ( ++p == pe )
		goto _test_eof40;
case 40:
	switch( (*p) ) {
		case 33u: goto st17;
		case 58u: goto tr27;
		case 75u: goto st41;
		case 107u: goto st41;
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
st41:
	if ( ++p == pe )
		goto _test_eof41;
case 41:
	switch( (*p) ) {
		case 33u: goto st17;
		case 58u: goto tr27;
		case 73u: goto st42;
		case 105u: goto st42;
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
st42:
	if ( ++p == pe )
		goto _test_eof42;
case 42:
	switch( (*p) ) {
		case 33u: goto st17;
		case 58u: goto tr27;
		case 69u: goto st43;
		case 101u: goto st43;
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
st43:
	if ( ++p == pe )
		goto _test_eof43;
case 43:
	switch( (*p) ) {
		case 33u: goto st17;
		case 58u: goto tr63;
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
tr66:
#line 18 "HttpParser.rl"
	{
    mark = cast(BytePos)(p - buffer.ptr);
  }
	goto st44;
tr63:
#line 66 "HttpParser.rl"
	{
    field_name = BytePosRange(mark, cast(BytePos)(p - buffer.ptr));
  }
	goto st44;
st44:
	if ( ++p == pe )
		goto _test_eof44;
case 44:
#line 1291 "HttpParser.d"
	switch( (*p) ) {
		case 13u: goto tr65;
		case 32u: goto tr66;
		default: break;
	}
	goto tr64;
tr64:
#line 18 "HttpParser.rl"
	{
    mark = cast(BytePos)(p - buffer.ptr);
  }
	goto st45;
st45:
	if ( ++p == pe )
		goto _test_eof45;
case 45:
#line 1308 "HttpParser.d"
	if ( (*p) == 13u )
		goto tr68;
	goto st45;
tr24:
#line 18 "HttpParser.rl"
	{
    mark = cast(BytePos)(p - buffer.ptr);
  }
	goto st46;
st46:
	if ( ++p == pe )
		goto _test_eof46;
case 46:
#line 1322 "HttpParser.d"
	switch( (*p) ) {
		case 33u: goto st17;
		case 58u: goto tr27;
		case 65u: goto st47;
		case 97u: goto st47;
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
		if ( (*p) < 66u ) {
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
st47:
	if ( ++p == pe )
		goto _test_eof47;
case 47:
	switch( (*p) ) {
		case 33u: goto st17;
		case 58u: goto tr27;
		case 84u: goto st48;
		case 116u: goto st48;
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
st48:
	if ( ++p == pe )
		goto _test_eof48;
case 48:
	switch( (*p) ) {
		case 33u: goto st17;
		case 58u: goto tr27;
		case 69u: goto st49;
		case 101u: goto st49;
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
st49:
	if ( ++p == pe )
		goto _test_eof49;
case 49:
	switch( (*p) ) {
		case 33u: goto st17;
		case 58u: goto tr72;
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
tr75:
#line 18 "HttpParser.rl"
	{
    mark = cast(BytePos)(p - buffer.ptr);
  }
	goto st50;
tr72:
#line 66 "HttpParser.rl"
	{
    field_name = BytePosRange(mark, cast(BytePos)(p - buffer.ptr));
  }
	goto st50;
st50:
	if ( ++p == pe )
		goto _test_eof50;
case 50:
#line 1457 "HttpParser.d"
	switch( (*p) ) {
		case 13u: goto tr74;
		case 32u: goto tr75;
		default: break;
	}
	goto tr73;
tr73:
#line 18 "HttpParser.rl"
	{
    mark = cast(BytePos)(p - buffer.ptr);
  }
	goto st51;
st51:
	if ( ++p == pe )
		goto _test_eof51;
case 51:
#line 1474 "HttpParser.d"
	if ( (*p) == 13u )
		goto tr77;
	goto st51;
tr9:
#line 22 "HttpParser.rl"
	{
    on_request_uri(BytePosRange(mark, cast(BytePos)(p - buffer.ptr)));
  }
	goto st52;
tr91:
#line 38 "HttpParser.rl"
	{
    on_request_path(BytePosRange(mark, cast(BytePos)(p - buffer.ptr)));
  }
#line 22 "HttpParser.rl"
	{
    on_request_uri(BytePosRange(mark, cast(BytePos)(p - buffer.ptr)));
  }
	goto st52;
tr102:
#line 42 "HttpParser.rl"
	{ 
    mark_query = cast(BytePos)(p - buffer.ptr);
  }
#line 46 "HttpParser.rl"
	{
    on_query(BytePosRange(mark_query, cast(BytePos)(p - buffer.ptr)));
  }
#line 22 "HttpParser.rl"
	{
    on_request_uri(BytePosRange(mark, cast(BytePos)(p - buffer.ptr)));
  }
	goto st52;
tr106:
#line 46 "HttpParser.rl"
	{
    on_query(BytePosRange(mark_query, cast(BytePos)(p - buffer.ptr)));
  }
#line 22 "HttpParser.rl"
	{
    on_request_uri(BytePosRange(mark, cast(BytePos)(p - buffer.ptr)));
  }
	goto st52;
st52:
	if ( ++p == pe )
		goto _test_eof52;
case 52:
#line 1522 "HttpParser.d"
	switch( (*p) ) {
		case 32u: goto tr78;
		case 37u: goto tr80;
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
	goto tr79;
tr79:
#line 18 "HttpParser.rl"
	{
    mark = cast(BytePos)(p - buffer.ptr);
  }
	goto st53;
st53:
	if ( ++p == pe )
		goto _test_eof53;
case 53:
#line 1547 "HttpParser.d"
	switch( (*p) ) {
		case 32u: goto tr81;
		case 37u: goto st54;
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
	goto st53;
tr80:
#line 18 "HttpParser.rl"
	{
    mark = cast(BytePos)(p - buffer.ptr);
  }
	goto st54;
st54:
	if ( ++p == pe )
		goto _test_eof54;
case 54:
#line 1572 "HttpParser.d"
	if ( (*p) < 65u ) {
		if ( 48u <= (*p) && (*p) <= 57u )
			goto st55;
	} else if ( (*p) > 70u ) {
		if ( 97u <= (*p) && (*p) <= 102u )
			goto st55;
	} else
		goto st55;
	goto st0;
st55:
	if ( ++p == pe )
		goto _test_eof55;
case 55:
	if ( (*p) < 65u ) {
		if ( 48u <= (*p) && (*p) <= 57u )
			goto st53;
	} else if ( (*p) > 70u ) {
		if ( 97u <= (*p) && (*p) <= 102u )
			goto st53;
	} else
		goto st53;
	goto st0;
tr5:
#line 18 "HttpParser.rl"
	{
    mark = cast(BytePos)(p - buffer.ptr);
  }
	goto st56;
st56:
	if ( ++p == pe )
		goto _test_eof56;
case 56:
#line 1605 "HttpParser.d"
	switch( (*p) ) {
		case 43u: goto st56;
		case 58u: goto st57;
		default: break;
	}
	if ( (*p) < 48u ) {
		if ( 45u <= (*p) && (*p) <= 46u )
			goto st56;
	} else if ( (*p) > 57u ) {
		if ( (*p) > 90u ) {
			if ( 97u <= (*p) && (*p) <= 122u )
				goto st56;
		} else if ( (*p) >= 65u )
			goto st56;
	} else
		goto st56;
	goto st0;
tr7:
#line 18 "HttpParser.rl"
	{
    mark = cast(BytePos)(p - buffer.ptr);
  }
	goto st57;
st57:
	if ( ++p == pe )
		goto _test_eof57;
case 57:
#line 1633 "HttpParser.d"
	switch( (*p) ) {
		case 32u: goto tr8;
		case 34u: goto st0;
		case 35u: goto tr9;
		case 37u: goto st58;
		case 60u: goto st0;
		case 62u: goto st0;
		case 127u: goto st0;
		default: break;
	}
	if ( (*p) <= 31u )
		goto st0;
	goto st57;
st58:
	if ( ++p == pe )
		goto _test_eof58;
case 58:
	if ( (*p) < 65u ) {
		if ( 48u <= (*p) && (*p) <= 57u )
			goto st59;
	} else if ( (*p) > 70u ) {
		if ( 97u <= (*p) && (*p) <= 102u )
			goto st59;
	} else
		goto st59;
	goto st0;
st59:
	if ( ++p == pe )
		goto _test_eof59;
case 59:
	if ( (*p) < 65u ) {
		if ( 48u <= (*p) && (*p) <= 57u )
			goto st57;
	} else if ( (*p) > 70u ) {
		if ( 97u <= (*p) && (*p) <= 102u )
			goto st57;
	} else
		goto st57;
	goto st0;
tr6:
#line 18 "HttpParser.rl"
	{
    mark = cast(BytePos)(p - buffer.ptr);
  }
	goto st60;
st60:
	if ( ++p == pe )
		goto _test_eof60;
case 60:
#line 1683 "HttpParser.d"
	switch( (*p) ) {
		case 32u: goto tr89;
		case 34u: goto st0;
		case 35u: goto tr91;
		case 37u: goto st61;
		case 59u: goto tr93;
		case 60u: goto st0;
		case 62u: goto st0;
		case 63u: goto tr94;
		case 127u: goto st0;
		default: break;
	}
	if ( (*p) <= 31u )
		goto st0;
	goto st60;
st61:
	if ( ++p == pe )
		goto _test_eof61;
case 61:
	if ( (*p) < 65u ) {
		if ( 48u <= (*p) && (*p) <= 57u )
			goto st62;
	} else if ( (*p) > 70u ) {
		if ( 97u <= (*p) && (*p) <= 102u )
			goto st62;
	} else
		goto st62;
	goto st0;
st62:
	if ( ++p == pe )
		goto _test_eof62;
case 62:
	if ( (*p) < 65u ) {
		if ( 48u <= (*p) && (*p) <= 57u )
			goto st60;
	} else if ( (*p) > 70u ) {
		if ( 97u <= (*p) && (*p) <= 102u )
			goto st60;
	} else
		goto st60;
	goto st0;
tr93:
#line 38 "HttpParser.rl"
	{
    on_request_path(BytePosRange(mark, cast(BytePos)(p - buffer.ptr)));
  }
	goto st63;
st63:
	if ( ++p == pe )
		goto _test_eof63;
case 63:
#line 1735 "HttpParser.d"
	switch( (*p) ) {
		case 32u: goto tr8;
		case 34u: goto st0;
		case 35u: goto tr9;
		case 37u: goto st64;
		case 60u: goto st0;
		case 62u: goto st0;
		case 63u: goto st66;
		case 127u: goto st0;
		default: break;
	}
	if ( (*p) <= 31u )
		goto st0;
	goto st63;
st64:
	if ( ++p == pe )
		goto _test_eof64;
case 64:
	if ( (*p) < 65u ) {
		if ( 48u <= (*p) && (*p) <= 57u )
			goto st65;
	} else if ( (*p) > 70u ) {
		if ( 97u <= (*p) && (*p) <= 102u )
			goto st65;
	} else
		goto st65;
	goto st0;
st65:
	if ( ++p == pe )
		goto _test_eof65;
case 65:
	if ( (*p) < 65u ) {
		if ( 48u <= (*p) && (*p) <= 57u )
			goto st63;
	} else if ( (*p) > 70u ) {
		if ( 97u <= (*p) && (*p) <= 102u )
			goto st63;
	} else
		goto st63;
	goto st0;
tr94:
#line 38 "HttpParser.rl"
	{
    on_request_path(BytePosRange(mark, cast(BytePos)(p - buffer.ptr)));
  }
	goto st66;
st66:
	if ( ++p == pe )
		goto _test_eof66;
case 66:
#line 1786 "HttpParser.d"
	switch( (*p) ) {
		case 32u: goto tr100;
		case 34u: goto st0;
		case 35u: goto tr102;
		case 37u: goto tr103;
		case 60u: goto st0;
		case 62u: goto st0;
		case 127u: goto st0;
		default: break;
	}
	if ( (*p) <= 31u )
		goto st0;
	goto tr101;
tr101:
#line 42 "HttpParser.rl"
	{ 
    mark_query = cast(BytePos)(p - buffer.ptr);
  }
	goto st67;
st67:
	if ( ++p == pe )
		goto _test_eof67;
case 67:
#line 1810 "HttpParser.d"
	switch( (*p) ) {
		case 32u: goto tr104;
		case 34u: goto st0;
		case 35u: goto tr106;
		case 37u: goto st68;
		case 60u: goto st0;
		case 62u: goto st0;
		case 127u: goto st0;
		default: break;
	}
	if ( (*p) <= 31u )
		goto st0;
	goto st67;
tr103:
#line 42 "HttpParser.rl"
	{ 
    mark_query = cast(BytePos)(p - buffer.ptr);
  }
	goto st68;
st68:
	if ( ++p == pe )
		goto _test_eof68;
case 68:
#line 1834 "HttpParser.d"
	if ( (*p) < 65u ) {
		if ( 48u <= (*p) && (*p) <= 57u )
			goto st69;
	} else if ( (*p) > 70u ) {
		if ( 97u <= (*p) && (*p) <= 102u )
			goto st69;
	} else
		goto st69;
	goto st0;
st69:
	if ( ++p == pe )
		goto _test_eof69;
case 69:
	if ( (*p) < 65u ) {
		if ( 48u <= (*p) && (*p) <= 57u )
			goto st67;
	} else if ( (*p) > 70u ) {
		if ( 97u <= (*p) && (*p) <= 102u )
			goto st67;
	} else
		goto st67;
	goto st0;
st70:
	if ( ++p == pe )
		goto _test_eof70;
case 70:
	switch( (*p) ) {
		case 32u: goto tr2;
		case 36u: goto st71;
		case 95u: goto st71;
		default: break;
	}
	if ( (*p) < 48u ) {
		if ( 45u <= (*p) && (*p) <= 46u )
			goto st71;
	} else if ( (*p) > 57u ) {
		if ( 65u <= (*p) && (*p) <= 90u )
			goto st71;
	} else
		goto st71;
	goto st0;
st71:
	if ( ++p == pe )
		goto _test_eof71;
case 71:
	switch( (*p) ) {
		case 32u: goto tr2;
		case 36u: goto st72;
		case 95u: goto st72;
		default: break;
	}
	if ( (*p) < 48u ) {
		if ( 45u <= (*p) && (*p) <= 46u )
			goto st72;
	} else if ( (*p) > 57u ) {
		if ( 65u <= (*p) && (*p) <= 90u )
			goto st72;
	} else
		goto st72;
	goto st0;
st72:
	if ( ++p == pe )
		goto _test_eof72;
case 72:
	switch( (*p) ) {
		case 32u: goto tr2;
		case 36u: goto st73;
		case 95u: goto st73;
		default: break;
	}
	if ( (*p) < 48u ) {
		if ( 45u <= (*p) && (*p) <= 46u )
			goto st73;
	} else if ( (*p) > 57u ) {
		if ( 65u <= (*p) && (*p) <= 90u )
			goto st73;
	} else
		goto st73;
	goto st0;
st73:
	if ( ++p == pe )
		goto _test_eof73;
case 73:
	switch( (*p) ) {
		case 32u: goto tr2;
		case 36u: goto st74;
		case 95u: goto st74;
		default: break;
	}
	if ( (*p) < 48u ) {
		if ( 45u <= (*p) && (*p) <= 46u )
			goto st74;
	} else if ( (*p) > 57u ) {
		if ( 65u <= (*p) && (*p) <= 90u )
			goto st74;
	} else
		goto st74;
	goto st0;
st74:
	if ( ++p == pe )
		goto _test_eof74;
case 74:
	switch( (*p) ) {
		case 32u: goto tr2;
		case 36u: goto st75;
		case 95u: goto st75;
		default: break;
	}
	if ( (*p) < 48u ) {
		if ( 45u <= (*p) && (*p) <= 46u )
			goto st75;
	} else if ( (*p) > 57u ) {
		if ( 65u <= (*p) && (*p) <= 90u )
			goto st75;
	} else
		goto st75;
	goto st0;
st75:
	if ( ++p == pe )
		goto _test_eof75;
case 75:
	switch( (*p) ) {
		case 32u: goto tr2;
		case 36u: goto st76;
		case 95u: goto st76;
		default: break;
	}
	if ( (*p) < 48u ) {
		if ( 45u <= (*p) && (*p) <= 46u )
			goto st76;
	} else if ( (*p) > 57u ) {
		if ( 65u <= (*p) && (*p) <= 90u )
			goto st76;
	} else
		goto st76;
	goto st0;
st76:
	if ( ++p == pe )
		goto _test_eof76;
case 76:
	switch( (*p) ) {
		case 32u: goto tr2;
		case 36u: goto st77;
		case 95u: goto st77;
		default: break;
	}
	if ( (*p) < 48u ) {
		if ( 45u <= (*p) && (*p) <= 46u )
			goto st77;
	} else if ( (*p) > 57u ) {
		if ( 65u <= (*p) && (*p) <= 90u )
			goto st77;
	} else
		goto st77;
	goto st0;
st77:
	if ( ++p == pe )
		goto _test_eof77;
case 77:
	switch( (*p) ) {
		case 32u: goto tr2;
		case 36u: goto st78;
		case 95u: goto st78;
		default: break;
	}
	if ( (*p) < 48u ) {
		if ( 45u <= (*p) && (*p) <= 46u )
			goto st78;
	} else if ( (*p) > 57u ) {
		if ( 65u <= (*p) && (*p) <= 90u )
			goto st78;
	} else
		goto st78;
	goto st0;
st78:
	if ( ++p == pe )
		goto _test_eof78;
case 78:
	switch( (*p) ) {
		case 32u: goto tr2;
		case 36u: goto st79;
		case 95u: goto st79;
		default: break;
	}
	if ( (*p) < 48u ) {
		if ( 45u <= (*p) && (*p) <= 46u )
			goto st79;
	} else if ( (*p) > 57u ) {
		if ( 65u <= (*p) && (*p) <= 90u )
			goto st79;
	} else
		goto st79;
	goto st0;
st79:
	if ( ++p == pe )
		goto _test_eof79;
case 79:
	switch( (*p) ) {
		case 32u: goto tr2;
		case 36u: goto st80;
		case 95u: goto st80;
		default: break;
	}
	if ( (*p) < 48u ) {
		if ( 45u <= (*p) && (*p) <= 46u )
			goto st80;
	} else if ( (*p) > 57u ) {
		if ( 65u <= (*p) && (*p) <= 90u )
			goto st80;
	} else
		goto st80;
	goto st0;
st80:
	if ( ++p == pe )
		goto _test_eof80;
case 80:
	switch( (*p) ) {
		case 32u: goto tr2;
		case 36u: goto st81;
		case 95u: goto st81;
		default: break;
	}
	if ( (*p) < 48u ) {
		if ( 45u <= (*p) && (*p) <= 46u )
			goto st81;
	} else if ( (*p) > 57u ) {
		if ( 65u <= (*p) && (*p) <= 90u )
			goto st81;
	} else
		goto st81;
	goto st0;
st81:
	if ( ++p == pe )
		goto _test_eof81;
case 81:
	switch( (*p) ) {
		case 32u: goto tr2;
		case 36u: goto st82;
		case 95u: goto st82;
		default: break;
	}
	if ( (*p) < 48u ) {
		if ( 45u <= (*p) && (*p) <= 46u )
			goto st82;
	} else if ( (*p) > 57u ) {
		if ( 65u <= (*p) && (*p) <= 90u )
			goto st82;
	} else
		goto st82;
	goto st0;
st82:
	if ( ++p == pe )
		goto _test_eof82;
case 82:
	switch( (*p) ) {
		case 32u: goto tr2;
		case 36u: goto st83;
		case 95u: goto st83;
		default: break;
	}
	if ( (*p) < 48u ) {
		if ( 45u <= (*p) && (*p) <= 46u )
			goto st83;
	} else if ( (*p) > 57u ) {
		if ( 65u <= (*p) && (*p) <= 90u )
			goto st83;
	} else
		goto st83;
	goto st0;
st83:
	if ( ++p == pe )
		goto _test_eof83;
case 83:
	switch( (*p) ) {
		case 32u: goto tr2;
		case 36u: goto st84;
		case 95u: goto st84;
		default: break;
	}
	if ( (*p) < 48u ) {
		if ( 45u <= (*p) && (*p) <= 46u )
			goto st84;
	} else if ( (*p) > 57u ) {
		if ( 65u <= (*p) && (*p) <= 90u )
			goto st84;
	} else
		goto st84;
	goto st0;
st84:
	if ( ++p == pe )
		goto _test_eof84;
case 84:
	switch( (*p) ) {
		case 32u: goto tr2;
		case 36u: goto st85;
		case 95u: goto st85;
		default: break;
	}
	if ( (*p) < 48u ) {
		if ( 45u <= (*p) && (*p) <= 46u )
			goto st85;
	} else if ( (*p) > 57u ) {
		if ( 65u <= (*p) && (*p) <= 90u )
			goto st85;
	} else
		goto st85;
	goto st0;
st85:
	if ( ++p == pe )
		goto _test_eof85;
case 85:
	switch( (*p) ) {
		case 32u: goto tr2;
		case 36u: goto st86;
		case 95u: goto st86;
		default: break;
	}
	if ( (*p) < 48u ) {
		if ( 45u <= (*p) && (*p) <= 46u )
			goto st86;
	} else if ( (*p) > 57u ) {
		if ( 65u <= (*p) && (*p) <= 90u )
			goto st86;
	} else
		goto st86;
	goto st0;
st86:
	if ( ++p == pe )
		goto _test_eof86;
case 86:
	switch( (*p) ) {
		case 32u: goto tr2;
		case 36u: goto st87;
		case 95u: goto st87;
		default: break;
	}
	if ( (*p) < 48u ) {
		if ( 45u <= (*p) && (*p) <= 46u )
			goto st87;
	} else if ( (*p) > 57u ) {
		if ( 65u <= (*p) && (*p) <= 90u )
			goto st87;
	} else
		goto st87;
	goto st0;
st87:
	if ( ++p == pe )
		goto _test_eof87;
case 87:
	switch( (*p) ) {
		case 32u: goto tr2;
		case 36u: goto st88;
		case 95u: goto st88;
		default: break;
	}
	if ( (*p) < 48u ) {
		if ( 45u <= (*p) && (*p) <= 46u )
			goto st88;
	} else if ( (*p) > 57u ) {
		if ( 65u <= (*p) && (*p) <= 90u )
			goto st88;
	} else
		goto st88;
	goto st0;
st88:
	if ( ++p == pe )
		goto _test_eof88;
case 88:
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
	_test_eof89: cs = 89; goto _test_eof; 
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
	_test_eof57: cs = 57; goto _test_eof; 
	_test_eof58: cs = 58; goto _test_eof; 
	_test_eof59: cs = 59; goto _test_eof; 
	_test_eof60: cs = 60; goto _test_eof; 
	_test_eof61: cs = 61; goto _test_eof; 
	_test_eof62: cs = 62; goto _test_eof; 
	_test_eof63: cs = 63; goto _test_eof; 
	_test_eof64: cs = 64; goto _test_eof; 
	_test_eof65: cs = 65; goto _test_eof; 
	_test_eof66: cs = 66; goto _test_eof; 
	_test_eof67: cs = 67; goto _test_eof; 
	_test_eof68: cs = 68; goto _test_eof; 
	_test_eof69: cs = 69; goto _test_eof; 
	_test_eof70: cs = 70; goto _test_eof; 
	_test_eof71: cs = 71; goto _test_eof; 
	_test_eof72: cs = 72; goto _test_eof; 
	_test_eof73: cs = 73; goto _test_eof; 
	_test_eof74: cs = 74; goto _test_eof; 
	_test_eof75: cs = 75; goto _test_eof; 
	_test_eof76: cs = 76; goto _test_eof; 
	_test_eof77: cs = 77; goto _test_eof; 
	_test_eof78: cs = 78; goto _test_eof; 
	_test_eof79: cs = 79; goto _test_eof; 
	_test_eof80: cs = 80; goto _test_eof; 
	_test_eof81: cs = 81; goto _test_eof; 
	_test_eof82: cs = 82; goto _test_eof; 
	_test_eof83: cs = 83; goto _test_eof; 
	_test_eof84: cs = 84; goto _test_eof; 
	_test_eof85: cs = 85; goto _test_eof; 
	_test_eof86: cs = 86; goto _test_eof; 
	_test_eof87: cs = 87; goto _test_eof; 
	_test_eof88: cs = 88; goto _test_eof; 

	_test_eof: {}
	_out: {}
	}

#line 142 "HttpParser.rl"

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
