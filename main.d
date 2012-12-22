import HttpParser;
import std.stdio;
import std.socket;
import std.conv;
import std.concurrency;

class MyHttpParser : HttpParser.HttpParser
{
  char buffer[];

  int num_fields = 0; 
  BytePosRange2 _fields[10];

  BytePosRange _request_uri;
  BytePosRange _fragment;
  BytePosRange _request_method;
  BytePosRange _http_version;
  BytePosRange _request_path;
  BytePosRange _query;
  BytePosRange _body_part;

  BytePosRange _field_accept;
  BytePosRange _field_accept_charset;
  BytePosRange _field_cookie;
  BytePosRange _field_date;

  void on_request_uri(BytePosRange r) { _request_uri = r; }
  void on_fragment(BytePosRange r) { _fragment = r; }
  void on_request_method(BytePosRange r) { _request_method = r; }
  void on_http_version(BytePosRange r) { _http_version = r; }
  void on_request_path(BytePosRange r) { _request_path = r; }
  void on_query(BytePosRange r) { _query = r; }
  void on_header_done(BytePosRange r) { _body_part = r; }

  void on_field_accept(BytePosRange r) { _field_accept = r; }
  void on_field_accept_charset(BytePosRange r) { _field_accept_charset = r; }
  void on_field_cookie(BytePosRange r) { _field_cookie = r; }
  void on_field_date(BytePosRange r) { _field_date = r; }

  void on_field(BytePosRange2 name_value)
  {
    assert(num_fields < _fields.length);
    _fields[num_fields++] = name_value;
  }

  @property char[] request_uri() {
    return buffer[_request_uri.from .. _request_uri.to];
  }

  @property char[] fragment() {
    return buffer[_fragment.from .. _fragment.to];
  }

  @property char[] request_method() {
    return buffer[_request_method.from .. _request_method.to];
  }

  @property char[] http_version() {
    return buffer[_http_version.from .. _http_version.to];
  }

  @property char[] request_path() {
    return buffer[_request_path.from .. _request_path.to];
  }

  @property char[] query() {
    return buffer[_query.from .. _query.to];
  }

  @property char[] body_part() {
    return buffer[_body_part.from .. _body_part.to];
  }

  @property char[] field_accept() {
    return buffer[_field_accept.from .. _field_accept.to];
  }

  @property char[] field_accept_charset() {
    return buffer[_field_accept_charset.from .. _field_accept_charset.to];
  }

  @property char[] field_cookie() {
    return buffer[_field_cookie.from .. _field_cookie.to];
  }

  @property char[] field_date() {
    return buffer[_field_date.from .. _field_date.to];
  }

}

void handle_connection(Socket s, char [] buffer)
{
  scope(exit) s.shutdown(SocketShutdown.BOTH);
  scope(exit) s.close();

  auto parser = new MyHttpParser();

  for (;;)
  {
    ptrdiff_t sz = 0;

    for (;;) {
      sz = s.receive(cast(void[])buffer);
      if (sz == 0)
      {
        writeln("remote socket has closed connection");
        return;
      }
      if (sz == Socket.ERROR)
      {
        writeln("Socket receive failed");
        return;
      }
      if (sz > 0) break;
    }

    //writeln("got ", sz, " bytes");
    //writeln("buffer: ", buffer);
    auto r = parser.execute(buffer[0..sz]);
    //writeln(r);
    if (parser.is_finished())
    {
      //writeln("finished");
      //writeln("headers: ", parser.headers);
      break;
    }
  }

  string html = "<html><body>Hey Leute</body></html>";
  string response = "HTTP/1.0 200 OK\r\n"
              "Content-Type: text/html\r\n" 
              "Content-Length: " ~ to!string(html.length) ~ "\r\n" 
              "Connection: close\r\n\r\n" ~ html;

  // XXX: check send exactly all bytes.
  s.send(response);
}

string test()
{
  auto p = new MyHttpParser();

  string req = "GET /hallo?abc=123&def=123%20456 HTTP/1.1\r\n" ~
             "Header1: Hallo Leute\r\n" ~
             "Date: 123-123-123-123\r\n" ~
             "Connection: Close\r\n" ~
             "Content-Length: 3\r\n" ~
             "\r\n" ~
             "123";
 
  auto buffer = req.dup;

  auto r = p.execute(buffer); 

  p.buffer = buffer;
  writeln(p.request_uri);
  writeln(p.fragment);
  writeln(p.query);
  writeln(p.field_date);
  writeln(p.body_part);

  //writeln(p.headers);

  string html = "<html><body>Hey Leute</body></html>";
  string response = "HTTP/1.0 200 OK\r\n"
              "Content-Type: text/html\r\n" 
              "Content-Length: " ~ to!string(html.length) ~ "\r\n" 
              "Connection: close\r\n\r\n" ~ html;

  return response;
}

void s(Socket conn)
{
  auto buffer = new char[2048];
  handle_connection(conn, buffer);
}

void main(string[] args)
{
  test();
  return;
/*
  for (int i=0; i < 1; ++i)
  {
    test();
  }
  return;
*/
/*
  auto p = new MyHttpParser();

  auto str1 = "GET /hallo?abc=123&def=123%20456 HTTP/1.1\r\n" ~
             "Header1: Hallo Leute\r\n" ~
             "Date: 123-123-123-123\r\n" ~
             "Connection: Close\r\n" ~
             "Content-Length: 3\r\n" ~
             "\r\n" ~
             "123";
  auto str = str1.dup;
  size_t sz=0;

  p.execute(str[0..3]);
  p.execute(str[3..$]);

  writeln("rest: ", str[sz..$]);

  writeln(p.headers);
*/
  TcpSocket server = new TcpSocket();

  ushort port = to!ushort(args[1]);
  server.bind(parseAddress("127.0.0.1", port));
  server.listen(10);
  scope(exit) server.shutdown(SocketShutdown.BOTH);
  scope(exit) server.close();
  writeln("ready to accept on port ", port);

  for (;;) {
    Socket conn = server.accept();
    s(conn);
  }
}
