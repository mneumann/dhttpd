import HttpParser;
import std.stdio;
import std.socket;
import std.socketstream;
import std.conv;

class MyHttpParser : HttpParser
{
  public string[string] headers;

  void on_http_field(const char field[], const char value[])
  {
    headers["HTTP_" ~ field.idup] = value.idup;
  }

  void on_request_method(const char str[])
  {
    headers["REQUEST_METHOD"] = str.idup;
  }

  void on_request_path(const char str[])
  {
    headers["REQUEST_PATH"] = str.idup; 
  }

  void on_request_uri(const char str[])
  {
    headers["REQUEST_URI"] = str.idup;
  }

  void on_query_string(const char str[])
  {
    headers["QUERY_STRING"] = str.idup;
  }

  void on_fragment(const char str[])
  {
    headers["FRAGMENT"] = str.idup;
  }

  void on_http_version(const char str[])
  {
    headers["HTTP_VERSION"] = str.idup;
  }

  void on_header_done(const char str[])
  {
  }
}

void handle_connection(Socket s, char buffer[])
{
  auto parser = new MyHttpParser();

  auto ss = new SocketStream(s);

  auto sz = ss.readBlock(buffer.ptr, buffer.length);

  //writeln("got ", sz, " bytes");
  //writeln("buffer: ", buffer);

  auto r = parser.execute(buffer[0..sz], 0); 

  if (parser.is_finished())
  {
    //writeln("finished");
    //writeln("headers: ", parser.headers);
  }
  else
  {
    return;
  }


  string html = "<html><body>Hey Leute</body></html>";
  string response = "HTTP/1.0 200 OK\r\n"
              "Content-Type: text/html\r\n" 
              "Content-Length: " ~ to!string(html.length) ~ "\r\n" 
              "Connection: close\r\n\r\n" ~ html;

  // XXX: check send exactly all bytes.
  s.send(response);
  //ss.writeBlock(response.ptr, response.length);
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

  auto r = p.execute(buffer, 0); 

  string html = "<html><body>Hey Leute</body></html>";
  string response = "HTTP/1.0 200 OK\r\n"
              "Content-Type: text/html\r\n" 
              "Content-Length: " ~ to!string(html.length) ~ "\r\n" 
              "Connection: close\r\n\r\n" ~ html;

  return response;
}


void main(string[] args)
{
  for (int i=0; i < 1_000_000; ++i)
  {
    test();
  }
  return;

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

  for(int i=3; !p.is_finished(); i+=3)
  {
    writeln("---");
    sz = p.execute(str[0..i], sz);
    writeln("sz: ", sz);
  }

  writeln("rest: ", str[sz..$]);

  //writeln(p.headers);

  auto server = new TcpSocket();

  ushort port = to!ushort(args[1]);
  server.bind(parseAddress("127.0.0.1", port));
  server.listen(5);
  writeln("ready to accept on port ", port);

  auto buffer = new char[1024];
  for (;;) {
    auto conn = server.accept();
    //conn.setOption(SocketOptionLevel.SOCKET, SocketOption.TCP_NODELAY, 0);
    //writeln("got connection");
    handle_connection(conn, buffer);

    conn.shutdown(SocketShutdown.BOTH);
    conn.close();
  }

  server.shutdown(SocketShutdown.BOTH);
  server.close();
}
