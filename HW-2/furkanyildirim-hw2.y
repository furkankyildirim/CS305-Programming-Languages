%{ 

#include <stdio.h>

int yylex();
void yyerror (const char * s) {
	return;
}

%}

%token tSTRING
%token tGET
%token tSET
%token tFUNCTION
%token tPRINT
%token tIF
%token tRETURN
%token tADD
%token tSUB
%token tMUL
%token tDIV
%token tINC
%token tDEC
%token tGT
%token tLT
%token tGEQ
%token tLEQ
%token tEQUALITY
%token tIDENT
%token tNUM

%start program
%%

program : 
          | '['statements']'
          | '['']'
;

statements : statement statements
           | statement
;

statement : SET
          | IF
          | PRINT
          | INC
          | DEC
          | RETURN
          | expression
;

expressions : expression ',' expressions;
            | expression
;

expression : tSTRING
            | tNUM
            | FUNCTION
            | CONDITION
            | OPERATORS
            | GET
;

parameters : tIDENT ',' parameters
           | tIDENT
;

SET : '[' tSET ',' tIDENT ',' expression ']'
;

IF : '[' tIF ',' CONDITION ',' '['statements']' ']'
   | '[' tIF ',' CONDITION ',' '['statements']' ',' '['statements']' ']'
;

PRINT : '[' tPRINT ',' expression ']'
;

INC : '[' tINC ',' tIDENT ']'
;

DEC : '[' tDEC ',' tIDENT ']'
;

CONDITION : '[' tGT ',' expression ',' expression ']'
          | '[' tLT ',' expression ',' expression ']'
          | '[' tGEQ ',' expression ',' expression ']'
          | '[' tLEQ ',' expression ',' expression ']'
          | '[' tEQUALITY ',' expression ',' expression ']'
;

GET : '[' tGET ',' tIDENT ']'
    | '[' tGET ',' tIDENT ',' '[' ']' ']'
    | '[' tGET ',' tIDENT ',' '[' expressions ']' ']'
;

FUNCTION : '[' tFUNCTION ',' '[' ']' ',' '[' ']' ']'
         | '[' tFUNCTION ',' '[' ']' ',' '['statements']' ']'
         | '[' tFUNCTION ',' '[' parameters ']' ',' '[' ']' ']'
         | '[' tFUNCTION ',' '[' parameters ']' ',' '['statements']' ']'
;

OPERATORS : '[' tADD ',' expression ',' expression ']'
          | '[' tSUB ',' expression ',' expression ']'
          | '[' tMUL ',' expression ',' expression ']'
          | '[' tDIV ',' expression ',' expression ']'
;

RETURN : '[' tRETURN ']'
       | '[' tRETURN ',' expression ']'
;

%%
int main () {
   if (yyparse()) {
      // parse error
      printf("ERROR\n");
      return 1;
    } else {
        // successful parsing
        printf("OK\n");
        return 0;
    } 
}