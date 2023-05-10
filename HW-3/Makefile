furkanyildirim: lex.yy.c furkanyildirim-hw3.tab.c furkanyildirim-hw3.tab.h 
	gcc -o furkanyildirim lex.yy.c furkanyildirim-hw3.tab.c -lfl

lex.yy.c: furkanyildirim-hw3.flx furkanyildirim-hw3.tab.h
	flex furkanyildirim-hw3.flx

furkanyildirim-hw3.tab.c furkanyildirim-hw3.tab.h: furkanyildirim-hw3.y
	bison -d furkanyildirim-hw3.y