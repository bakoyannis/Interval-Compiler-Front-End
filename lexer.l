%{
   #include "parser.hpp" // Bison parser file
   #define YY_USER_ACTION yylloc.first_line = yylloc.last_line = yylineno;
%}

%option noyywrap

FLOAT             [+-]?([0-9]*[.])?[0-9]+
INTERVAL_S        \[{FLOAT}\]
INTERVAL          (\[([[:space:]]+)?({FLOAT})([[:space:]]+)?,([[:space:]]+)?({FLOAT})([[:space:]]+)?\])

%%

"-"            { return MINUS; }
"+"            { return PLUS; }
"*"            { return MULT; }
"/"            { return DIV; }
"="            { return EQUAL; }
"("            { return L_PAREN; }
")"            { return R_PAREN; }

{INTERVAL_S}   {
                  double x1;  
                  sscanf(yytext, "[%lf]", &x1);    // string -> double
                  yylval.ival = new interval(x1);  // Interval Class Object
                  return INTERVAL;
               }

{INTERVAL}     {
                  double x1, x2;
                  sscanf(yytext, "[%lf,%lf]", &x1, &x2); // string -> double
                  yylval.ival = new interval(x1, x2); // Interval Class Object
                  return INTERVAL;
               }

[ \t]+         { }

"\n"           { return END; }

.              {
                  printf("Error at line %d: unrecognized symbol \"%s\"\n", yylloc.first_line, yytext);
                  exit(0);
               }

%%
