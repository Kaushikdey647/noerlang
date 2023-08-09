%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define IF 1
#define THEN 2
#define ELSE 3
#define RELOP 4
#define ID 5
#define NUMBER 6
#define ASSIGN 7

%}

digit [0-9]
letter [a-zA-Z]
if "if"
then "then"
else "else"
assign ":="
relop "<"|">"|"=="|"<="|">="|"!="
digits {digit}+
id {letter}({letter}|{digit})*
number {digits}("."{digits})?([eE][+-]?{digits})?

%%

{if} {printf("IF\n");return IF;}
{then} {printf("THEN\n");return THEN;}
{else} {printf("ELSE\n");return ELSE;}
{relop} {printf("RELOP\n");return RELOP;}
{assign} {printf("ASSIGN\n");return ASSIGN;}
{id} {printf("ID: %s\n", yytext);return ID;}
{number} {printf("NUMBER: %s\n", yytext);return NUMBER;}
[ \t\n] ;

%%

int yywrap(void) {
    return 1;
}

int main(int argc, char **argv) {

    if (argc < 2) {
        printf("Usage: %s <input file>\n", argv[0]);
        return 1;
    }

    FILE *fp = fopen(argv[1], "r");

    if (fp == NULL) {
        printf("Error opening file %s\n", argv[1]);
        return 1;
    }

    yyin = fp;

    while (yylex() != 0);

    fclose(fp);

    return 0;
}