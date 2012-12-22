dhttpd
======

A fast HTTP server for the D language

Design
------

Parsing the HTTP request is very fast by using a Ragel [1] state machine
inherited from the Mongrel Ruby webserver but extended a bit to save more
memory.

Parsing stores positions into the buffer currently being parsed. If parsing
needs more input it returns to the caller. Then the caller has to read more
data and append it at the end of the buffer (or construct a new buffer
containing all the content), so that all currently stored positions into the
buffer stay valid. Then continue parsing with the bigger buffer at the last
position.

We do not copy data, nor modify the buffer itself. Custom HTTP headers can
be allowed, or disabled. If they are disabled, custom HTTP headers are just
ignored. If they are enabled, they will be stored in an array.

[1]: http://www.complang.org/ragel/
