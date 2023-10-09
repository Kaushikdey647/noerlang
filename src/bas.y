%{
    #include<stdio.h>
    #include<string.h>
    #include<stdlib.h>
    #include<ctype.h>
    #include "lex.yy.c"

    void yyerror(const char *s);
    int yylex();
    int yywrap();
%}

%union {
    int int_val;
    float float_val;
}


%token LPAREN RPAREN PLUS MINUS
MULT DIV DIV_FLOOR MOD NOT AND OR XOR TERM

%token <int_val> INT_CONST
%token <float_val> FLOAT_CONST

%type <int_val> int_expr
%type <float_val> float_expr

%left PLUS MINUS
%left MULT DIV DIV_FLOOR MOD
%left AND OR XOR
%right UNARY_MINUS
%right NOT

%%

main: main calc
| calc
;

calc: float_expr TERM					{ printf("%f\n", $1); }
| int_expr TERM							{ printf("%d\n", $1); }
;

float_expr: FLOAT_CONST					{$$ = $1;}
| MINUS float_expr %prec UNARY_MINUS	{$$ = -$2;}
| NOT float_expr %prec NOT				{$$ = !$2;}
| float_expr PLUS float_expr			{$$ = $1 + $3;}
| float_expr PLUS int_expr				{$$ = $1 + $3;}
| int_expr PLUS float_expr				{$$ = $1 + $3;}
| float_expr MINUS float_expr			{$$ = $1 - $3;}
| float_expr MINUS int_expr				{$$ = $1 - $3;}
| int_expr MINUS float_expr				{$$ = $1 - $3;}
| float_expr MULT float_expr			{$$ = $1 * $3;}
| float_expr MULT int_expr				{$$ = $1 * $3;}
| int_expr MULT float_expr				{$$ = $1 * $3;}
| float_expr DIV float_expr				{$$ = (float)$1 / (float)$3;}
| int_expr DIV int_expr					{$$ = (float)$1 / (float)$3;}
| float_expr DIV int_expr				{$$ = (float)$1 / (float)$3;}
| int_expr DIV float_expr				{$$ = (float)$1 / (float)$3;}
| LPAREN float_expr RPAREN				{$$ = $2;}
;

int_expr: INT_CONST						{$$ = $1;}
| MINUS int_expr %prec UNARY_MINUS		{$$ = -$2;}
| NOT int_expr %prec NOT				{$$ = !$2;}
| int_expr PLUS int_expr				{$$ = $1 + $3;}
| int_expr MINUS int_expr				{$$ = $1 + $3;}
| int_expr MULT int_expr				{$$ = $1 + $3;}
| int_expr MOD int_expr					{$$ = $1 + $3;}
| int_expr DIV_FLOOR int_expr			{$$ = (int)($1 / $3);}
| int_expr DIV_FLOOR float_expr			{$$ = (int)($1 / $3);}
| float_expr DIV_FLOOR int_expr			{$$ = (int)($1 / $3);}
| float_expr DIV_FLOOR float_expr		{$$ = (int)($1 / $3);}
| int_expr AND int_expr					{$$ = $1 & $3;}
| int_expr OR int_expr					{$$ = $1 | $3;}
| int_expr XOR int_expr					{$$ = $1 ^ $3;}
| LPAREN int_expr RPAREN				{$$ = $2;}
;

%%

int main(){
    yyparse();
}

void yyerror(const char *msg){
    fprintf(stderr, " [ line: %d ] %s at at token [ '%s' ] \n", yylineno, msg, yytext);
}