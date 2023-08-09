/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    INT_TYPE = 258,
    FLOAT_TYPE = 259,
    CHAR_TYPE = 260,
    STRING_TYPE = 261,
    INTEGER = 262,
    FLOATING = 263,
    STRING = 264,
    IF = 265,
    ELSE = 266,
    WHILE = 267,
    BREAK = 268,
    RETURN = 269,
    ASSIGN = 270,
    IDENTIFIER = 271,
    LOGICAL = 272,
    NEGATION = 273,
    RELATIONAL = 274,
    ADDITIVE = 275,
    MULTIPLICATIVE = 276,
    UNARY = 277,
    TRUE = 278,
    FALSE = 279
  };
#endif
/* Tokens.  */
#define INT_TYPE 258
#define FLOAT_TYPE 259
#define CHAR_TYPE 260
#define STRING_TYPE 261
#define INTEGER 262
#define FLOATING 263
#define STRING 264
#define IF 265
#define ELSE 266
#define WHILE 267
#define BREAK 268
#define RETURN 269
#define ASSIGN 270
#define IDENTIFIER 271
#define LOGICAL 272
#define NEGATION 273
#define RELATIONAL 274
#define ADDITIVE 275
#define MULTIPLICATIVE 276
#define UNARY 277
#define TRUE 278
#define FALSE 279

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
