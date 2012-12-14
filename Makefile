all: main

main: main.d HttpParser.d
	dmd main.d HttpParser.d

HttpParser.d: HttpParser.rl HttpParserCommon.rl Makefile
	ragel -G2 -D HttpParser.rl

clean:
	rm -f HttpParser.d main *.o
