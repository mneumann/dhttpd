interface IHttpParserVisitor
{
  void on_http_version(const char v[]);
  void on_http_field(const char field[], const char value[]);
  void on_request_method(const char v[]);
  void on_request_uri(const char v[]);
  void on_request_path(const char v[]);
  void on_query_string(const char v[]);
  void on_fragment(const char v[]);
  void on_header_done(const char v[]);
  void on_body(const char v[]);
};
