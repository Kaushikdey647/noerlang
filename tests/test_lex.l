%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int sent_count = 0;

#define INT_TYPE 1
#define FLOAT_TYPE 2
#define CHAR_TYPE 3
#define STRING_TYPE 4
#define IF 5
#define THEN 6
#define ELSE 7
#define WHILE 8
#define BREAK 9
#define RETURN 10
#define VOID 11
#define TRUE 12
#define FALSE 13
#define STATIC 14
#define UNARY 15
#define RELATIONAL 16
#define LOGICAL 17
#define ASSIGN 18
#define ADDITIVE 19
#define MULTIPLICATIVE 20
#define NEGATION 21
#define IDENTIFIER 22
#define INTEGER 23
#define FLOATING 24
#define STRING 25
#define LPAREN 26
#define RPAREN 27
#define LBRACKET 28
#define RBRACKET 29
#define LBRACE 30
#define RBRACE 31
#define COMMA 32
#define SEMICOLON 33
#define COLON 34
#define DOT 35

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
lparen "("
rparen ")"
lbracket "["
rbracket "]"
lbrace "{"
rbrace "}"
comma ","
semicolon ";"
colon ":"
dot "."

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
{lparen} {return LPAREN;}
{rparen} {return RPAREN;}
{lbracket} {return LBRACKET;}
{rbracket} {return RBRACKET;}
{lbrace} {return LBRACE;}
{rbrace} {return RBRACE;}
{comma} {return COMMA;}
{semicolon} {return SEMICOLON;}
{colon} {return COLON;}
{dot} {return DOT;}

[ \t]+ {;}
"\n" {sent_count++;}
. {return *yytext;}

%%

int main(int argc, char **argv)
{
    if(argc != 2)
    {
        printf("Usage: ./a.out <filename>\n");
        exit(1);
    }

    FILE *fp = fopen(argv[1], "r");
    if(fp == NULL)
    {
        printf("Error: File not found\n");
        exit(1);
    }

    yyin = fp;
    yylex();
    printf("Total number of lines: %d\n", sent_count);

    fclose(fp);
    return 0;
}