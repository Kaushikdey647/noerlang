%{
#include<stdio.h>
%}

%%
(0|1)*1(0|1)*1(0|1)*1(0|1)*1(0|1)* {printf("ACCEPTED\n");}
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