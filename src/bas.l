%{
    #include "y.tab.h"
%}

%option yylineno

digit [0-9]
int {digit}+
float {digit}+"."{digit}+

%%

"(" {return LPAREN;}
")" {return RPAREN;}
"+" {return PLUS;}
"-" {return MINUS;}
"*" {return MULT;}
"/" {return DIV;}
"//" {return DIV_FLOOR;}
"%" {return MOD;}
"!" {return NOT;}
"&" {return AND;}
"|" {return OR;}
"^" {return XOR;}
{float} {
    yylval.float_val = atof(yytext);
    return FLOAT_CONST;
}
{int} {
    yylval.int_val = atoi(yytext);
    return INT_CONST;
}
"\n" {return TERM;}

%%

int yywrap() {
    return 1;
}