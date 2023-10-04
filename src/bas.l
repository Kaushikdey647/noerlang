%{
    
    #include "y.tab.h"

    int sent_count = 0; /*Keeping track of line number*/

%}

%option yylineno
%%

"and"                   { return AND; }
":="                    { return ASSIGN; }
":"                     { return COLON; }
","                     { return COMMA; }
"def"                   { return DEF; }
"/"                     { return DIV; }
"\."                    { return DOT; }
"if"                    { return IF; }
"else"                  { return ELSE; }
"end"                   { return END; }
"="                     { return EQ; }
"exit"                  { return EXITLOOP; }
"float"                 { return FLOAT; }
[0-9]+\.[0-9]+          { yylval.float_val = atof(yytext); return FLOAT_CONST; }
"%d"|"%f"|"%s"          { return FORMAT; }
"from"                  { return FROM; }
"fun"                   { return FUN; }
">="                    { return GE; }
"global"                { return GLOBAL; }
">"                     { return GT; }
[0-9]+                  { yylval.int_val = atoi(yytext); return INT_CONST; }
"("                     { return LEFT_PAREN; }
"["                     { return LEFT_SQ_BKT; }
"<="                    { return LE; }
"<"                     { return LT; }
"-"                     { return MINUS; }
"mod"                   { return MOD; }
"\*"                    { return MULT; }
"<>"                    { return NE; }
"not"                   { return NOT; }
"null"                  { return NUL; }
"or"                    { return OR; }
"\+"                    { return PLUS; }
"print"                 { return PRINT; }
"product"               { return PRODUCT; }
"read"                  { return READ; }
"return"                { return RETURN; }
"->"                    { return RETURNS; }
")"                     { return RIGHT_PAREN; }
"]"                     { return RIGHT_SQ_BKT; }
";"                     { return SEMICOLON; }
"skip"                  { return SKIP; }
"step"                  { return STEP; }
\"([^\\\"]|\\.)*\"      { yylval.str_val = strdup(yytext); return STRING; }
"to"                    { return TO; }
"while"                 { return WHILE; }
[a-zA-Z][a-zA-Z0-9_]*   { yylval.str_val = strdup(yytext); return ID; }
[ \t]*                  { ; }
[\n]                    { sent_count++; }
\/\/.*\n                {} /*Ignore comments*/
.                       { fprintf(stderr, "Error: Unexpected character: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}