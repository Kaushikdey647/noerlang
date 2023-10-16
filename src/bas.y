%{
    #include<stdio.h>
    #include<string.h>
    #include<stdlib.h>
    #include<ctype.h>
    #include "lex.yy.c"
    #include "ast.h"
    void yyerror(const char *s);
    int yylex();
    int yywrap();
    
%}

%union {
    int int_val;
}


%token LPAREN RPAREN PLUS MINUS
MULT DIV MOD NOT AND OR XOR TERM

%token <int_val> NUM

%type <int_val> expr

%left PLUS MINUS
%left MULT DIV MOD
%left AND OR XOR
%right UNARY_MINUS
%right NOT

%%

main: main calc
| calc
;

calc: expr TERM					{printf("%d\n", $1);}
;

expr: NUM					    {$$ = $1;}
| MINUS expr %prec UNARY_MINUS	{$$ = -$2;}
| NOT expr %prec NOT			{$$ = !$2;}
| expr PLUS expr				{$$ = $1 + $3;}
| expr MINUS expr				{$$ = $1 - $3;}
| expr MULT expr				{$$ = $1 * $3;}
| expr DIV expr				    {$$ = $1 / $3;}
| expr MOD expr					{$$ = $1 % $3;}
| expr AND expr					{$$ = $1 & $3;}
| expr OR expr					{$$ = $1 | $3;}
| expr XOR expr					{$$ = $1 ^ $3;}
| LPAREN expr RPAREN			{$$ = $2;}
;

%%

int main(){
    yyparse();
}

void yyerror(const char *msg){
    fprintf(stderr, " [ line: %d ] %s at at token [ '%s' ] \n", yylineno, msg, yytext);
}