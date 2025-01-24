CC = g++
OPT = -O3 -std=c++20
erg1: lexer.cpp parser.cpp interval.cpp
	$(CC) $(OPT) $^ -o $@

lexer.hpp lexer.cpp: lexer.l
	flex -d --header-file=lexer.hpp -o lexer.cpp lexer.l 

parser.hpp parser.cpp: parser.y
	bison -d -v -o parser.cpp parser.y

clean:
	cmd /C del .\parser.cpp .\parser.hpp .\lexer.hpp .\lexer.cpp .\parser.output .\erg1.exe
