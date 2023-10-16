%{
    
    #include "y.tab.h"

    int sent_count = 0; /*Keeping track of line number*/

%}

%option yylineno

digit [0-9]
char [a-zA-Z]
valid_name [a-zA-Z][a-zA-Z0-9_]*
int {digit}+
float {digit}+"."{digit}+
scientific_notation {digit}+"."{digit}+"e"{digit}+
string \"([^\\\n]|(\\.))*?\"

%%

"return" {
    return RETURN;
}
"if" {
    return IF;
}
"else" {
    return ELSE;
}
"while" {
    return WHILE;
}
"for" {
    return FOR;
}
"break" {
    return BREAK;
}
"continue" {
    return CONTINUE;
}
"fun" {
    return FUNCTION;
}
"class" {
    return CLASS;
}

"int8" {
    return INT8_T;
}
"int16" {
    return INT16_T;
}
"int32" {
    return INT32_T;
}
"int64" {
    return INT64_T;
}
"int128" {
    return INT128_T;
}
"char" {
    return CHAR_T;
}
"float16" {
    return FLOAT16_T;
}
"float32" {
    return FLOAT32_T;
}
"float64" {
    return FLOAT64_T;
}
"float128" {
    return FLOAT128_T;
}
"bool" {
    return BOOL_T;
}
"void" {
    return VOID_T;
}

"=" {
    return ASSIGN;
}

"==" {
    return EQ;
}

"!=" {
    return NEQ;
}

"<" {
    return LT;
}

"<=" {
    return LE;
}

">" {
    return GT;
}

">=" {
    return GE;
}

"and" {
    return AND;
}

"or" {
    return OR;
}

"not" {
    return NOT;
}

"&" {
    return BWAND;
}

"|" {
    return BWOR;
}

"^" {
    return BWXOR;
}

"~" {
    return BWNOT;
}

">>" {
    return BWSHR;
}

"<<" {
    return BWSHL;
}

"+" {
    return PLUS;
}

"-" {
    return MINUS;
}

"*" {
    return MUL;
}

"/" {
    return DIV;
}

"%" {
    return MOD;
}

"++" {
    return INC;
}

"--" {
    return DEC;
}

"(" {
    return LPAREN;
}

")" {
    return RPAREN;
}

"{" {
    return LBRACE;
}

"}" {
    return RBRACE;
}

"[" {
    return LBRACKET;
}

"]" {
    return RBRACKET;
}

";" {
    return SEMICOLON;
}

"," {
    return COMMA;
}

"." {
    return DOT;
}

":" {
    return COLON;
}

"?" {
    return QUESTION;
}

{valid_name} {
    return IDENTIFIER;
}

{int} {
    return INTEGER_LITERAL;
}

{float} {
    return FLOAT_LITERAL;
}

{scientific_notation} {
    return SCIENTIFIC_NOTATION;
}

{char} {
    return CHAR_LITERAL;
}

{string} {
    return STRING_LITERAL;
}

"//"(.)*"\n" {
    /*Do nothing*/
}

"/*"(.)*"*/" {
    /*Do nothing*/
}

[ \t\n] {
    /*Do nothing*/
}

. {
    printf("Line %d: Unrecognized character: %s\n", yylineno, yytext);
    exit(1);
}


%%

int yywrap() {
    return 1;
}