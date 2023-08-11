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
reassign "+="|"-="|"*="|"/="|"%="
assign "="
additive "+"|"-"
multiplicative "*"|"/"|"%"
lparen "("
rparen ")"
lbrace "{"
rbrace "}"
lbracket "["
rbracket "]"
comma ","
semicolon ";"
colon ":"
question "?"
dot "."
arrow "->"

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

{lparen} {return LPAREN;}
{rparen} {return RPAREN;}
{lbrace} {return LBRACE;}
{rbrace} {return RBRACE;}
{lbracket} {return LBRACKET;}
{rbracket} {return RBRACKET;}
{comma} {return COMMA;}
{semicolon} {return SEMICOLON;}
{colon} {return COLON;}
{question} {return QUESTION;}
{dot} {return DOT;}
{arrow} {return ARROW;}


{unary} {return UNARY;}
{relational} {return RELATIONAL;}
{logical} {return LOGICAL;}
{assign} {return ASSIGN;}
{reassign} {return REASSIGN;}
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