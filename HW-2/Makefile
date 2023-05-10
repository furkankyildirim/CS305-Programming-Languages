furkanyildirim: lex.yy.c furkanyildirim-hw2.tab.c furkanyildirim-hw2.tab.h 
	gcc -o furkanyildirim lex.yy.c furkanyildirim-hw2.tab.c -lfl

lex.yy.c: furkanyildirim-hw2.flx furkanyildirim-hw2.tab.h
	flex furkanyildirim-hw2.flx

furkanyildirim-hw2.tab.c furkanyildirim-hw2.tab.h: furkanyildirim-hw2.y
	bison -d furkanyildirim-hw2.y