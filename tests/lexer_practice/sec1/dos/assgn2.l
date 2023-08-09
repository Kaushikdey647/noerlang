%{
#include<stdio.h>
%}

%%
(1*01*0)* {printf("ACCEPTED\n");}
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