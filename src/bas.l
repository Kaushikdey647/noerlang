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

identifier {alpha}({alpha}|{digit}|"_")*
integer {digit}+
float {digit}+"."{digit}+
char ['].[']
string ["]([^\\\n]|(\\.))*?["]

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
"return" {return RETURN;}
"void" {return VOID;}
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
{negation} {return NEGATION;}
{identifier} {return IDENTIFIER;}
{integer} {return INTEGER;}
{float} {return FLOATING;}
{string} {return STRING;}
{char} {return CHAR;}
\/\/.* { ; }
\/\*(.*\n)*.*\*\/ { ; } 
[ \t]* { ; }
[\n] { sent_count++; }
. { return *yytext; }

%%

int yywrap() {
    return 1;
}