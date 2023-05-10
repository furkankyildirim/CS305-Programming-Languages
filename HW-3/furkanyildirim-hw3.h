#ifndef __FURKANYILDIRIM_HW3_H
#define __FURKANYILDIRIM_HW3_H

typedef struct ExprNode {
    int isStr;
    int isNum;
    int isFloat;
    int isGet;
    int LineNo;
    int literal;
    double db;
    int inum;
    char *str;
} ExprNode;

typedef struct OprNode {
    char *literal;
    char *strResult;
    double dbResult;
    int intResult;
	int isGet;
	int lineNo;
} OprNode;

#endif