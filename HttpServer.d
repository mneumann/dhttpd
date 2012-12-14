import std.socket;

class HttpServer
{
  private TcpSocket server;

  this(string addr, ushort port, int backlog=5)
  {
    server = new TcpSocket();
    server.bind(parseAddress(addr, port));
    server.listen(backlog);
  }

  void start()
  {
    for (;;) 
    {
      auto s = server.accept();
      handle_connection(s);
    }

    server.shutdown(SocketShutdown.BOTH);
    server.close();
  }

  void handle_connection(Socket s)
  {
    close_connection(s);
  }

  void close_connection(Socket s)
  {
    s.shutdown(SocketShutdown.BOTH);
    s.close();
  }
};

