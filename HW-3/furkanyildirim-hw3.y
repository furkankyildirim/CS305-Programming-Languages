%{
#include <stdio.h>
#include <string.h>
#include "furkanyildirim-hw3.h"

int yylex(void);
void yyerror (const char *s){

}

char ans[10000];
char temp[1000];
extern int line;

%}

%union {
	int ivalue;
	double value;
	char *strvalue;

	ExprNode exprNode;
	OprNode oprNode;
}

%token <value> tADD
%token <value> tSUB 
%token <value> tMUL  
%token <value> tDIV
%token <ivalue> tINT
%token <value> tFLOAT
%token <strvalue> tSTRING 
%token tPRINT 
%token tGET 
%token tSET 
%token tFUNCTION 
%token tIDENT 
%token tEQUALITY 
%token tIF 
%token tGT 
%token tLT 
%token tGEQ 
%token tLEQ 
%token tINC 
%token tDEC 
%token tRETURN

%type <exprNode> expr
%type <oprNode> operation
%type <exprNode> condition
%type <exprNode> if
%type <exprNode> getExpr
%type <exprNode> setStmt
%type <exprNode> returnStmt


%start prog

%%
prog:		'[' stmtlst ']'
;

stmtlst:	stmtlst stmt |
;

stmt:		setStmt {
				if ($1.isGet == 1) {

				} else if($1.isStr == 1 && $1.isNum == 0 && $1.isFloat == 0) {
					strcat(ans, "Result of expression on ");
					snprintf(temp, sizeof temp, "%i", line);
					strcat(ans, temp);
					strcat(ans, " is (" );
					strcat(ans, $1.str);
					strcat(ans, ")\n" );
				} else if ($1.isStr == 0 && $1.isNum == 1 && $1.isFloat == 0) {
					strcat(ans, "Result of expression on ");
					snprintf(temp, sizeof ans, "%i", line);
					strcat(ans, temp);
					strcat(ans, " is (" );
					snprintf(temp, sizeof ans, "%i", $1.inum);
					strcat(ans, temp);
					strcat(ans, ")\n" );
				} else if ($1.isStr == 0 && $1.isNum == 0 && $1.isFloat == 1) {
					strcat(ans, "Result of expression on ");
					snprintf(temp, sizeof ans, "%i", line);
					strcat(ans, temp);
					strcat(ans, " is (" );
					snprintf(temp, sizeof ans, "%.1f", $1.db);
					strcat(ans, temp);
					strcat(ans, ")\n" );
				}
			}
			| if {	
				if ($1.isGet == 1) {

				} else if($1.isStr == 1 && $1.isNum == 0 && $1.isFloat == 0) {
					strcat(ans, "Result of expression on ");
					snprintf(temp, sizeof ans, "%i", line);
					strcat(ans, temp);
					strcat(ans, " is (" );
					strcat(ans, $1.str);
					strcat(ans, ")\n" );
				} else if ($1.isStr == 0 && $1.isNum == 1 && $1.isFloat == 0) {
					strcat(ans, "Result of expression on ");
					snprintf(temp, sizeof ans, "%i", line);
					strcat(ans, temp);
					strcat(ans, " is (" );
					snprintf(temp, sizeof ans, "%i", $1.inum);
					strcat(ans, temp);
					strcat(ans, ")\n" );
				} else if ($1.isStr == 0 && $1.isNum == 0 && $1.isFloat == 1) {			
					strcat(ans, "Result of expression on ");
					snprintf(temp, sizeof ans, "%i", line);
					strcat(ans, temp);
					strcat(ans, " is (" );
					snprintf(temp, sizeof ans, "%.1f", $1.db);
					strcat(ans, temp);
					strcat(ans, ")\n" );
				}	
			}
			| print
			| unaryOperation
			| expr  {
				if ($1.isGet == 1) {

				} else if($1.isStr == 1 && $1.isNum == 0 && $1.isFloat == 0) {
					strcat(ans, "Result of expression on ");
					snprintf(temp, sizeof ans, "%i", $1.LineNo);
					strcat(ans, temp);
					strcat(ans, " is (" );
					strcat(ans, $1.str);
					strcat(ans, ")\n" );
				} else if ($1.isStr == 0 && $1.isNum == 1 && $1.isFloat == 0) {
					strcat(ans, "Result of expression on ");
					snprintf(temp, sizeof ans, "%i", $1.LineNo);
					strcat(ans, temp);
					strcat(ans, " is (" );
					snprintf(temp, sizeof ans, "%i", $1.inum);
					strcat(ans, temp);
					strcat(ans, ")\n" );
				} else if ($1.isStr == 0 && $1.isNum == 0 && $1.isFloat == 1) {
					strcat(ans, "Result of expression on ");
					snprintf(temp, sizeof ans, "%i", $1.LineNo);
					strcat(ans, temp);
					strcat(ans, " is (" );
					snprintf(temp, sizeof ans, "%.1f", $1.db);
					strcat(ans, temp);
					strcat(ans, ")\n" );
				}
			}
			| returnStmt {
				if ($1.isGet == 1) {

				} else if($1.isStr == 1 && $1.isNum == 0 && $1.isFloat == 0) {
					strcat(ans, "Result of expression on ");
					snprintf(temp, sizeof ans, "%i", line);
					strcat(ans, temp);
					strcat(ans, " is (" );
					strcat(ans, $1.str);
					strcat(ans, ")\n" );
				} else if ($1.isStr == 0 && $1.isNum == 1 && $1.isFloat == 0) {
						strcat(ans, "Result of expression on ");
						snprintf(temp, sizeof ans, "%i", line);
						strcat(ans, temp);
						strcat(ans, " is (" );
						snprintf(temp, sizeof ans, "%i", $1.inum);
						strcat(ans, temp);
						strcat(ans, ")\n" );
				} else if ($1.isStr == 0 && $1.isNum == 0 && $1.isFloat == 1) {
						strcat(ans, "Result of expression on ");
						snprintf(temp, sizeof ans, "%i", line);
						strcat(ans, temp);
						strcat(ans, " is (" );
						snprintf(temp, sizeof ans, "%.1f", $1.db);
						strcat(ans, temp);
						strcat(ans, ")\n" );
				}
			}
;

getExpr:	'[' tGET ',' tIDENT ',' '[' exprList ']' ']'
			| '[' tGET ',' tIDENT ',' '[' ']' ']'
			| '[' tGET ',' tIDENT ']'
;

setStmt:	'[' tSET ',' tIDENT ',' expr ']' { 
				if ($6.isStr == 1) {
					$$.isStr = 1;
					$$.isNum = 0;
					$$.isFloat = 0;
					$$.str = $6.str;
				} else if ($6.isNum == 1) {
					$$.isNum = 1;
					$$.isStr = 0;
					$$.isFloat = 0;
					$$.inum = $6.inum;
				} else if ($6.isFloat == 1) {
					$$.isFloat = 1;
					$$.isStr = 0;
					$$.isNum = 0;
					$$.db = $6.db;
				}
			}
;

if:			'[' tIF ',' condition ',' '[' stmtlst ']' ']'
			| '[' tIF ',' condition ',' '[' stmtlst ']' '[' stmtlst ']' ']'
;

print:		'[' tPRINT ',' expr ']' 
;

operation:	'[' tADD ',' expr ',' expr ']' {
				$$.lineNo = $2;
				if ($4.isGet == 1 || $6.isGet == 1) {
					$$.isGet = 1;
				} else if ($4.isStr == 1 && $6.isStr == 1) {
					$$.literal = "str";			
					int size = strlen($4.str) + strlen($6.str);
					$$.strResult = (char*)malloc(size * sizeof(char));
					strcpy($$.strResult, $4.str);
					strcat($$.strResult, $6.str);
		   		} else if ($4.isStr == 0 && $6.isStr == 1) {
		   			strcat(ans, "Type mismatch on ");
					snprintf(temp, sizeof ans, "%i", line);
					strcat(ans, temp);
					strcat(ans, "\n" );
		   		} else if ($4.isStr == 1 && $6.isStr == 0) {
		   			strcat(ans, "Type mismatch on ");
					snprintf(temp, sizeof ans, "%i", line);
					strcat(ans, temp);
					strcat(ans, "\n" );
				} else if ($4.isNum == 1 && $6.isNum == 1) {
					$$.literal = "int";
					$$.intResult = $4.inum + $6.inum;
		   		} else if ($4.isFloat == 1 && $6.isFloat == 1) {
	                $$.literal = "db";        
					$$.dbResult = $4.db + $6.db;
                } else if ($4.isNum == 1 && $6.isFloat == 1) {
                    $$.literal = "db";
					$$.dbResult = $4.inum + $6.db;
                } else if ($4.isFloat == 1 && $6.isNum == 1) {
                    $$.literal = "db";
					$$.dbResult = $4.db + $6.inum;
				} 
			}
			| '[' tSUB ',' expr ',' expr ']' {
				$$.lineNo = line;
				if ($6.isGet == 1 || $4.isGet == 1) {
                    $$.isGet = 1;
                } else if ($4.isNum == 1 && $6.isNum == 1) {
                    $$.literal = "int";
					$$.intResult = $4.inum - $6.inum;
                } else if ($4.isFloat == 1 && $6.isFloat == 1) {
					$$.literal = "db";
					$$.dbResult = $4.db - $6.db;
                } else if ($4.isNum == 1 && $6.isFloat == 1) {
					$$.literal = "db";
					$$.dbResult = $4.inum - $6.db;
                } else if ($4.isFloat == 1 && $6.isNum == 1) {
					$$.literal = "db";
					$$.dbResult = $4.db - $6.inum;
                } else {
                    strcat(ans, "Type mismatch on ");
					snprintf(temp, sizeof ans, "%i", line);
					strcat(ans, temp);
					strcat(ans, "\n" );
                }
			}
			| '[' tMUL ',' expr ',' expr ']' {
				$$.lineNo = line;
				if ($4.isGet == 1 || $6.isGet == 1) {
                    $$.isGet = 1;
                } else if ($4.isNum == 1 && $6.isNum == 1) {
                    $$.literal = "int";
					$$.intResult = $4.inum * $6.inum;
                } else if ($4.isFloat == 1 && $6.isFloat == 1) {
					$$.literal = "db";
					$$.dbResult = $4.db * $6.db;
				} else if ($4.isNum == 1 && $6.isFloat == 1) {
					$$.literal = "db";
					$$.dbResult = $4.db * $6.inum;
				} else if ($4.isFloat == 1 && $6.isNum == 1) {
					$$.literal = "db";
					$$.dbResult = $4.inum * $6.db;
				} else if ($4.isNum == 1 && $6.isStr == 1){
					int i;
					$$.literal = "str";
					int size = $4.inum;
					$$.strResult = (char*)malloc(size * sizeof(char));
                    strcpy($$.strResult, $6.str);
                    for (i = 0; i < $4.inum-1; i++) {
                        strcat($$.strResult, $6.str);
                    }
			    } else if ($4.isStr == 1 && $6.isNum == 1){
					int i;
					$$.literal = "str";
					int size = $6.inum;
					$$.strResult = (char*)malloc(size * sizeof(char));
					strcpy($$.strResult, $4.str);
					for (i = 0; i < (($6.inum)-1); i++) {
						strcat($$.strResult, $4.str);
					}
                } else {
					strcat(ans, "Type mismatch on ");
					snprintf(temp, sizeof ans, "%i", line);
					strcat(ans, temp);
					strcat(ans, "\n" );
				}
			}
			| '[' tDIV ',' expr ',' expr ']' {
				$$.lineNo = line;
				if ($4.isGet == 1 || $6.isGet == 1) {
                    $$.isGet = 1;
                } else if ($4.isNum == 1 && $6.isNum == 1) {
                    $$.literal = "int";
					$$.intResult = $4.inum / $6.inum;
                } else if ($4.isFloat == 1 && $6.isFloat == 1) {
					$$.literal = "db";
					$$.dbResult = $4.db / $6.db;
                } else if ($4.isFloat == 1 && $6.isNum == 1) {
					$$.literal = "db";
					$$.dbResult = $4.db / $6.inum;
                } else if ($4.isNum == 1 && $6.isFloat == 1) {
					$$.literal = "db";
					$$.dbResult = $4.inum / $6.db;
                } else {
                    strcat(ans, "Type mismatch on ");
					snprintf(temp, sizeof ans, "%i", line);
					strcat(ans, temp);
					strcat(ans, "\n" );
                }
			}
;	

unaryOperation: '[' tINC ',' tIDENT ']'
			  | '[' tDEC ',' tIDENT ']'
;

expr:		tINT {
				$$.isNum = 1; 
				$$.isStr = 0; 
				$$.isFloat = 0; 
				$$.inum = $1;
			}
			| tFLOAT {
				$$.isNum = 0; 
				$$.isStr = 0; 
				$$.isFloat = 1; 
 				$$.db = $1;
			}
			| tSTRING {
				$$.isNum = 0; 
				$$.isStr = 1; 
				$$.isFloat = 0; 
				$$.str = $1;
			}
			| getExpr {
				$$.isNum = 0; 
				$$.isStr = 0; 
				$$.isFloat = 0; 
				$$.isGet = $1.isGet;
			}
			| function {
				$$.isNum = 0; 
				$$.isStr = 0; 
				$$.isFloat = 0; 
			}
			| operation {
				if ($1.isGet == 1) {
					$$.LineNo = $1.lineNo;
                    $$.isGet = 1;
                } else if ($1.literal == "int") {
					$$.LineNo = $1.lineNo;
			        $$.isNum = 1;
					$$.isFloat = 0;
					$$.isStr = 0;
					$$.inum = $1.intResult;
			    } else if ($1.literal == "db") {
					$$.LineNo = $1.lineNo;
					$$.isNum = 0;
					$$.isStr = 0;
					$$.isFloat = 1;
					$$.db = $1.dbResult;
			    } else if ($1.literal == "str") {
					$$.LineNo = $1.lineNo;
					$$.isNum = 0;
					$$.isStr = 1;
					$$.isFloat = 0;
					$$.str = $1.strResult;
			    }
			}
			| condition {
				$$.isNum = 0; 
				$$.isStr = 0; 
				$$.isFloat = 0;
			}
;

function:	 '[' tFUNCTION ',' '[' parametersList ']' ',' '[' stmtlst ']' ']'
			| '[' tFUNCTION ',' '[' ']' ',' '[' stmtlst ']' ']'
;

condition:	'[' tEQUALITY ',' expr ',' expr ']' {
				if ($6.isGet == 1) {

				} else if ($6.isNum == 1) {
                    strcat(ans, "Result of expression on ");
                    snprintf(temp, sizeof ans, "%i", $6.LineNo);
                    strcat(ans, temp);
                    strcat(ans, " is (" );
                    snprintf(temp, sizeof ans, "%i", $6.inum);
                    strcat(ans, temp);
                    strcat(ans, ")\n" );
				} else if ($6.isFloat == 1) {
					strcat(ans, "Result of expression on ");
					snprintf(temp, sizeof ans, "%i", $6.LineNo);
					strcat(ans, temp);
					strcat(ans, " is (" );
					snprintf(temp, sizeof ans, "%f", $6.db);
					strcat(ans, temp);
					strcat(ans, ")\n" );
				} else if ($6.isStr == 1) {
					strcat(ans, "Result of expression on ");
					snprintf(temp, sizeof ans, "%i", $6.LineNo);
					strcat(ans, temp);
					strcat(ans, " is (" );
					strcat(ans, $6.str);
					strcat(ans, ")\n" );
				}	

				if ($4.isGet == 1) {

				}  else if ($4.isNum == 1) {
                    strcat(ans, "Result of expression on ");
                    snprintf(temp, sizeof ans, "%i", $4.LineNo);
                    strcat(ans, temp);
                    strcat(ans, " is (" );
                    snprintf(temp, sizeof ans, "%i", $4.inum);
                    strcat(ans, temp);
                    strcat(ans, ")\n" );
				} else if ($4.isFloat == 1) {
					strcat(ans, "Result of expression on ");
					snprintf(temp, sizeof ans, "%i", $4.LineNo);
					strcat(ans, temp);
					strcat(ans, " is (" );
					snprintf(temp, sizeof ans, "%f", $4.db);
					strcat(ans, temp);
					strcat(ans, ")\n" );
				} else if ($4.isStr == 1) {
					strcat(ans, "Result of expression on ");
					snprintf(temp, sizeof ans, "%i", $4.LineNo);
					strcat(ans, temp);
					strcat(ans, " is (" );
					strcat(ans, $4.str);
					strcat(ans, ")\n" );
				}			
			}
			| '[' tGT ',' expr ',' expr ']' {
				if ($6.isGet == 1) {

				} else if ($6.isNum == 1) {
					strcat(ans, "Result of expression on ");
					snprintf(temp, sizeof ans, "%i", $6.LineNo);
					strcat(ans, temp);
					strcat(ans, " is (" );
					snprintf(temp, sizeof ans, "%i", $6.inum);
					strcat(ans, temp);
					strcat(ans, ")\n" );
				} else if ($6.isFloat == 1) {
					strcat(ans, "Result of expression on ");
					snprintf(temp, sizeof ans, "%i", $6.LineNo);
					strcat(ans, temp);
					strcat(ans, " is (" );
					snprintf(temp, sizeof ans, "%f", $6.db);
					strcat(ans, temp);
					strcat(ans, ")\n" );
				} else if ($6.isStr == 1) {
					strcat(ans, "Result of expression on ");
					snprintf(temp, sizeof ans, "%i", $6.LineNo);
					strcat(ans, temp);
					strcat(ans, " is (" );
					strcat(ans, $6.str);
					strcat(ans, ")\n" );
				}

				if ($4.isGet == 1) {

				}  else if ($4.isNum == 1) {
					strcat(ans, "Result of expression on ");
					snprintf(temp, sizeof ans, "%i", $4.LineNo);
					strcat(ans, temp);
					strcat(ans, " is (" );
					snprintf(temp, sizeof ans, "%i", $4.inum);
					strcat(ans, temp);
					strcat(ans, ")\n" );
				} else if ($4.isFloat == 1) {
					strcat(ans, "Result of expression on ");
					snprintf(temp, sizeof ans, "%i", $4.LineNo);
					strcat(ans, temp);
					strcat(ans, " is (" );
					snprintf(temp, sizeof ans, "%f", $4.db);
					strcat(ans, temp);
					strcat(ans, ")\n" );
				} else if ($4.isStr == 1) {
					strcat(ans, "Result of expression on ");
					snprintf(temp, sizeof ans, "%i", $4.LineNo);
					strcat(ans, temp);
					strcat(ans, " is (" );
					strcat(ans, $4.str);
					strcat(ans, ")\n" );
				}
			}
			| '[' tLT ',' expr ',' expr ']' {
				if ($6.isGet == 1) {

				} else if ($6.isNum == 1) {
					strcat(ans, "Result of expression on ");
					snprintf(temp, sizeof ans, "%i", $6.LineNo);
					strcat(ans, temp);
					strcat(ans, " is (" );
					snprintf(temp, sizeof ans, "%i", $6.inum);
					strcat(ans, temp);
					strcat(ans, ")\n" );
				} else if ($6.isFloat == 1) {
					strcat(ans, "Result of expression on ");
					snprintf(temp, sizeof ans, "%i", $6.LineNo);
					strcat(ans, temp);
					strcat(ans, " is (" );
					snprintf(temp, sizeof ans, "%f", $6.db);
					strcat(ans, temp);
					strcat(ans, ")\n" );
				} else if ($6.isStr == 1) {
					strcat(ans, "Result of expression on ");
					snprintf(temp, sizeof ans, "%i", $6.LineNo);
					strcat(ans, temp);
					strcat(ans, " is (" );
					strcat(ans, $6.str);
					strcat(ans, ")\n" );
				}

				if ($4.isGet == 1) {

				}  else if ($4.isNum == 1) {
					strcat(ans, "Result of expression on ");
					snprintf(temp, sizeof ans, "%i", $4.LineNo);
					strcat(ans, temp);
					strcat(ans, " is (" );
					snprintf(temp, sizeof ans, "%i", $4.inum);
					strcat(ans, temp);
					strcat(ans, ")\n" );
				} else if ($4.isFloat == 1) {
					strcat(ans, "Result of expression on ");
					snprintf(temp, sizeof ans, "%i", $4.LineNo);
					strcat(ans, temp);
					strcat(ans, " is (" );
					snprintf(temp, sizeof ans, "%f", $4.db);
					strcat(ans, temp);
					strcat(ans, ")\n" );
				} else if ($4.isStr == 1) {
					strcat(ans, "Result of expression on ");
					snprintf(temp, sizeof ans, "%i", $4.LineNo);
					strcat(ans, temp);
					strcat(ans, " is (" );
					strcat(ans, $4.str);
					strcat(ans, ")\n" );
				}
			}
			| '[' tGEQ ',' expr ',' expr ']' {
				if ($6.isGet == 1) {

				} else if ($6.isNum == 1) {
					strcat(ans, "Result of expression on ");
					snprintf(temp, sizeof ans, "%i", $6.LineNo);
					strcat(ans, temp);
					strcat(ans, " is (" );
					snprintf(temp, sizeof ans, "%i", $6.inum);
					strcat(ans, temp);
					strcat(ans, ")\n" );
				} else if ($6.isFloat == 1) {
					strcat(ans, "Result of expression on ");
					snprintf(temp, sizeof ans, "%i", $6.LineNo);
					strcat(ans, temp);
					strcat(ans, " is (" );
					snprintf(temp, sizeof ans, "%f", $6.db);
					strcat(ans, temp);
					strcat(ans, ")\n" );
				} else if ($6.isStr == 1) {
					strcat(ans, "Result of expression on ");
					snprintf(temp, sizeof ans, "%i", $6.LineNo);
					strcat(ans, temp);
					strcat(ans, " is (" );
					strcat(ans, $6.str);
					strcat(ans, ")\n" );
				}

				if ($4.isGet == 1) {

				}  else if ($4.isNum == 1) {
					strcat(ans, "Result of expression on ");
					snprintf(temp, sizeof ans, "%i", $4.LineNo);
					strcat(ans, temp);
					strcat(ans, " is (" );
					snprintf(temp, sizeof ans, "%i", $4.inum);
					strcat(ans, temp);
					strcat(ans, ")\n" );
				} else if ($4.isFloat == 1) {
					strcat(ans, "Result of expression on ");
					snprintf(temp, sizeof ans, "%i", $4.LineNo);
					strcat(ans, temp);
					strcat(ans, " is (" );
					snprintf(temp, sizeof ans, "%f", $4.db);
					strcat(ans, temp);
					strcat(ans, ")\n" );
				} else if ($4.isStr == 1) {
					strcat(ans, "Result of expression on ");
					snprintf(temp, sizeof ans, "%i", $4.LineNo);
					strcat(ans, temp);
					strcat(ans, " is (" );
					strcat(ans, $4.str);
					strcat(ans, ")\n" );
				}
			}
			| '[' tLEQ ',' expr ',' expr ']' {
				if ($6.isGet == 1) {

				} else if ($6.isNum == 1) {
					strcat(ans, "Result of expression on ");
					snprintf(temp, sizeof ans, "%i", $6.LineNo);
					strcat(ans, temp);
					strcat(ans, " is (" );
					snprintf(temp, sizeof ans, "%i", $6.inum);
					strcat(ans, temp);
					strcat(ans, ")\n" );
				} else if ($6.isFloat == 1) {
					strcat(ans, "Result of expression on ");
					snprintf(temp, sizeof ans, "%i", $6.LineNo);
					strcat(ans, temp);
					strcat(ans, " is (" );
					snprintf(temp, sizeof ans, "%f", $6.db);
					strcat(ans, temp);
					strcat(ans, ")\n" );
				} else if ($6.isStr == 1) {
					strcat(ans, "Result of expression on ");
					snprintf(temp, sizeof ans, "%i", $6.LineNo);
					strcat(ans, temp);
					strcat(ans, " is (" );
					strcat(ans, $6.str);
					strcat(ans, ")\n" );
				}

				if ($4.isGet == 1) {

				}  else if ($4.isNum == 1) {
					strcat(ans, "Result of expression on ");
					snprintf(temp, sizeof ans, "%i", $4.LineNo);
					strcat(ans, temp);
					strcat(ans, " is (" );
					snprintf(temp, sizeof ans, "%i", $4.inum);
					strcat(ans, temp);
					strcat(ans, ")\n" );
				} else if ($4.isFloat == 1) {
					strcat(ans, "Result of expression on ");
					snprintf(temp, sizeof ans, "%i", $4.LineNo);
					strcat(ans, temp);
					strcat(ans, " is (" );
					snprintf(temp, sizeof ans, "%f", $4.db);
					strcat(ans, temp);
					strcat(ans, ")\n" );
				} else if ($4.isStr == 1) {
					strcat(ans, "Result of expression on ");
					snprintf(temp, sizeof ans, "%i", $4.LineNo);
					strcat(ans, temp);
					strcat(ans, " is (" );
					strcat(ans, $4.str);
					strcat(ans, ")\n" );
				}
			}
;

returnStmt:	'[' tRETURN ',' expr ']' { 
			    if ($4.isNum == 1) {
                    $$.isNum = 1;
					$$.isStr = 0;
					$$.isFloat = 0;
                    $$.inum = $4.inum;
                } else if ($4.isFloat == 1) {
                    $$.isNum = 0;
					$$.isStr = 0;
					$$.isFloat = 1;
    	            $$.db = $4.db;
                } else if ($4.isStr == 1) {
                    $$.isNum = 0;
					$$.isStr = 1;
					$$.isFloat = 0;
                    $$.str = $4.str;
                } 
			}			
			| '[' tRETURN ']'
;

parametersList: parametersList ',' tIDENT 
				| tIDENT
;

exprList:	exprList ',' expr 
			| expr
;

%%
int main () {
	if (yyparse()) {
		printf("ERROR\n");
		return 1;
	} else {
		printf(ans);
		return 0;
	}
}
