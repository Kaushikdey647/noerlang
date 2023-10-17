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

%token LPAREN RPAREN PLUS MINUS
MULT DIV MOD NOT AND OR XOR TERM

%union{
    struct ASTNode ast_node;
    int number;
}

%token <number> NUM

%type <ast_node> main calc expr

%left PLUS MINUS
%left MULT DIV MOD
%left AND OR XOR
%right UNARY_MINUS
%right NOT

%%

main: main calc
| calc
;

calc: expr TERM					{
    print_ast($1,0); //print the ast
    printf("\n");
}
;

expr: NUM					    {$$ = create_number_node($1);}
| MINUS expr %prec UNARY_MINUS	{$$ = create_unary_op_node('!', $2);}
| NOT expr %prec NOT			{$$ = create_unary_op_node('!', $2);}
| expr PLUS expr				{$$ = create_binary_op_node('+', $1, $3);}
| expr MINUS expr				{$$ = create_binary_op_node('-', $1, $3);}
| expr MULT expr				{$$ = create_binary_op_node('*', $1, $3);}
| expr DIV expr				    {$$ = create_binary_op_node('/', $1, $3);}
| expr MOD expr					{$$ = create_binary_op_node('%', $1, $3);}
| expr AND expr					{$$ = create_binary_op_node('&', $1, $3);}
| expr OR expr					{$$ = create_binary_op_node('|', $1, $3);}
| expr XOR expr					{$$ = create_binary_op_node('^', $1, $3);}
| LPAREN expr RPAREN			{$$ = create_number_node($2);}
;

%%

int main(){
    yyparse();
}

void yyerror(const char *msg){
    fprintf(stderr, " [ line: %d ] %s at at token [ '%s' ] \n", yylineno, msg, yytext);
}