%{

    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    

%}

digit [0-9]
digits {digit}+
letter [a-zA-Z]
unary "++"|"--"
relational "<"|">"|"<="|">="|"=="|"!="
logical "&&"|"||"
assignment "="|"+="|"-="|"*="|"/="|"%="
additive "+"|"-"
multiplicative "*"|"/"|"%"

identifier {letter}({letter}|{digit}|"_")*
integer {digit}+
float {digit}+"."{digit}+
exp {digits}("."{digits})?([eE][+-]?{digits})?

%%
"auto" { printf("AUTO\n"); }
"break" { printf("BREAK\n"); }
"case" { printf("CASE\n"); }
"char" { printf("CHAR\n"); }
"const" { printf("CONST\n"); }
"continue" { printf("CONTINUE\n"); }
"default" { printf("DEFAULT\n"); }
"do" { printf("DO\n"); }
"double" { printf("DOUBLE\n"); }
"else" { printf("ELSE\n"); }
"enum" { printf("ENUM\n"); }
"extern" { printf("EXTERN\n"); }
"float" { printf("FLOAT\n"); }
"for" { printf("FOR\n"); }
"goto" { printf("GOTO\n"); }
"if" { printf("IF\n"); }
"int" { printf("INT\n"); }
"long" { printf("LONG\n"); }
"register" { printf("REGISTER\n"); }
"return" { printf("RETURN\n"); }
"short" { printf("SHORT\n"); }
"signed" { printf("SIGNED\n"); }
"sizeof" { printf("SIZEOF\n"); }
"static" { printf("STATIC\n"); }
"struct" { printf("STRUCT\n"); }
"switch" { printf("SWITCH\n"); }
"typedef" { printf("TYPEDEF\n"); }
"union" { printf("UNION\n"); }
"unsigned" { printf("UNSIGNED\n"); }
"void" { printf("VOID\n"); }
"volatile" { printf("VOLATILE\n"); }
"while" { printf("WHILE\n"); }

{identifier} { printf("IDENTIFIER %s\n", yytext); }
{integer} { printf("INTEGER %s\n", yytext); }
{float} { printf("FLOAT %s\n", yytext); }
{exp} { printf("EXP %s\n", yytext); }
{relational} { printf("RELATIONAL %s\n", yytext); }
{logical} { printf("LOGICAL %s\n", yytext); }
{assignment} { printf("ASSIGNMENT %s\n", yytext); }
{unary} { printf("UNARY %s\n", yytext); }
{additive} { printf("ADDITIVE %s\n", yytext); }
{multiplicative} { printf("MULTIPLICATIVE %s\n", yytext); }

"(" { printf("LPAREN\n"); }
")" { printf("RPAREN\n"); }
"[" { printf("LBRACKET\n"); }
"]" { printf("RBRACKET\n"); }
"{" { printf("LBRACE\n"); }
"}" { printf("RBRACE\n"); }
"," { printf("COMMA\n"); }
";" { printf("SEMICOLON\n"); }
"." { printf("DOT\n"); }
"&" { printf("BITAND\n"); }
"|" { printf("BITOR\n"); }
"^" { printf("BITXOR\n"); }
"~" { printf("BITNOT\n"); }
"!" { printf("NOT\n"); }
"?" { printf("QUESTION\n"); }
":" { printf("COLON\n"); }
"..." { printf("ELLIPSIS\n"); }
"//" { /* ignore single-line comments */ }
"/*" { /* ignore multi-line comments */ }
.|\n { /* ignore other characters */ }
%%

int main(int argc, char **argv)
{
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <input file>\n", argv[0]);
        return 1;
    }

    FILE *fp = fopen(argv[1], "r");
    if (fp == NULL) {
        fprintf(stderr, "Error: cannot open file '%s'\n", argv[1]);
        return 1;
    }

    yyin = fp;
    yylex();

    fclose(fp);
    return 0;
}