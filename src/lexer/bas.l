%{

#include "y.tab.h"

int sent_count = 0; /*Keeping track of line number*/

%}

%option yylineno

alpha [a-zA-Z]
digit [0-9]
unary "++"|"--"
relational "<"|">"|"<="|">="|"=="|"!="
logical "&&"|"||"
negation "~"|"!"
assign "="|"+="|"-="|"*="|"/="|"%="
additive "+"|"-"
multiplicative "*"|"/"|"%"
punctuator ";"|"{"|"}"|"("|")"|"["|"]"|","

identifier {alpha}({alpha}|{digit}|"_")*
integer {digit}+
float {digit}+"."{digit}+
string \"([^\\\n]|(\\.))*?\"

%%

"int" {return INT_TYPE;}
"float" {return FLOAT_TYPE;}
"char" {return CHAR_TYPE;}
"string" {return STRING_TYPE;}
"if" {return IF;}
"then" {return THEN;}
"else" {return ELSE;}
"while" {return WHILE;}
"break" {return BREAK;}
"continue" {return CONTINUE;}
"return" {return RETURN;}
"null" {return NULL;}
"true" {return TRUE;}
"false" {return FALSE;}
"static" {return STATIC;}
comment|block_comment {;}
{unary} {return UNARY;}
{relational} {return RELATIONAL;}
{logical} {return LOGICAL;}
{assign} {return ASSIGN;}
{additive} {return ADDITIVE;}
{multiplicative} {return MULTIPLICATIVE;}
{punctuator} {return PUNCTUATOR;}
{negation} {return NEGATION;}
{identifier} {return IDENTIFIER;}
{integer} {return INTEGER;}
{float} {return FLOATING;}
{string} {return STRING;}
[ \t]* {;}
"\n" {sent_count++;}
. {return *yytext;}

%%

int yywrap(void) {
    return 1;
}

int main(int argc, char **argv) {
    yyin = fopen(argv[1], "r");
    yylex();
    printf("Total number of lines: %d\n", sent_count);
    return 0;
}

