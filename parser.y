%code requires {
    #include "interval.hpp"
}

%{
#include <iostream>
#include "lexer.hpp"

void yyerror(const char *msg);
%}

%union {
    double dval;
    interval* ival;
}

%locations

%token <ival> INTERVAL
%token PLUS MINUS MULT DIV EQUAL L_PAREN R_PAREN END
%type <ival> exp
%start line

%left PLUS MINUS
%left MULT DIV

%%

line:
    exp EQUAL END { std::cout << *$1 << std::endl; delete $1; }
    | error END { yyerror("Invalid input, skipping to the next line."); yyclearin; }
    ;

exp:
    INTERVAL        { $$ = $1; }
    | exp PLUS exp  { $$ = new interval(*$1 + *$3); delete $1; delete $3; }
    | exp MINUS exp { $$ = new interval(*$1 - *$3); delete $1; delete $3; }
    | exp MULT exp  { $$ = new interval(*$1 * *$3); delete $1; delete $3; }
    | exp DIV exp   { $$ = new interval(*$1 / *$3); delete $1; delete $3; }
    | L_PAREN exp R_PAREN { $$ = $2; }
    ;

%%

int main(int argc, char **argv) {
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (yyin == NULL)
            printf("syntax: %s filename\n", argv[0]);
    }
    std::cout << "Parsing started..." << std::endl;
    yyparse();
    return 0;
}

void yyerror(const char *msg) {
   printf("** Line %d: %s\n", yylloc.first_line, msg);
}
