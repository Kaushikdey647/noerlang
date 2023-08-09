%{
#include<stdio.h>
%}

alphabet [a-c]

%%

({alphabet}*"aa"{alphabet}*)|({alphabet}*"bb"{alphabet}*) {
    if( strlen(yytext) == 8 )
        printf("ACCEPTED\n");
    return 0;
}

%%

int yywrap()
{
    return 1;
}

int main()
{
    yylex();
    return 0;
}