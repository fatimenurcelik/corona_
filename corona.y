%{
 void yyerror(char *s);
 int yylex();
 #include <stdio.h>
 #include <stdlib.h>
 #include <ctype.h>
 int symbols[52];
 int symbolVal(char symbol);
 void updateSymbolVal(char symbol, int val);
%}

%union {int num,char id}
%start line 
%token  <num> integer_value
%token  <char> char_value 
%token DOGRULUK
%token PARANTEZ_AC
%token PARANTEZ_KAPA
%token ISE
%token NOKTA
%token EGER
%token YADA
%token YOKSA
%token YORUM
%token YORUM_AC
%token YORUM_KAPA
%token ESITTIR
%token VEYA
%token DEGIL
%token DEMEK
%token ANCAKVEANCAK
%token VE
%token KUCUKESIT
%token KUCUKTUR
%token BUYUKESIT
%token BUYUKTUR
%token ESITTIR
%token EKRANAYAZ
%token TARA
%token DONGU
%token ARTI
%token EKSI
%token BOLU
%token CARPI
%token KALAN
%token CALISTIR
%token BOLUM
%token <var> SAYI DEGISKEN YAZIDIZISI
%token <id> identifier

%left 'ARTI' 'EKSI'
%left 'CARPI' 'BOLU'
%right ESITTIR BUYUKTUR KUCUKTUR BUYUKESIT KUCUKESIT
%nonassoc ANCAKVEANCAK VE VEYA DEGIL DEMEK

%type <id> identifier
%type <num> expression

%%

type : YAZIDIZISI |
		SAYI
constant : SAYI 

constant expression : expression

expression: assignment_expression ';' {$$ = $1;}
          | relational_expression ';' {$$ = $1;};

relational_expression: expression  ESITTIR expression  ';'      { $$ = $1 == $3;}
                      |expression  KUCUKTUR expression  ';'     { $$ = $1 < $3;}
                      |expression  KUCUKESIT expression  ';'    { $$ = $1 <= $3;}
                      |expression  BUYUKTUR expression  ';'     { $$ = $1 > $3;}
                      |expression  BUYUKESIT expression ';'     { $$ = $1 => $3;}
                      |expression  ANCAKVEANCAK expression ';'  { $$ = $1 <=> $3;}
                      |expression  DEMEK expression     ';'     { $$ = $1 => $3;}
                      |expression  VE expression    ';'         { $$ = $1 && $3;}
                      |expression  VEYA expression   ';'        { $$ = $1 || $3;}
                      |expression  DEGIL expression  ';'        { $$ = $1 != $3;};

assignment_expression: conditional_expression ';' {$$ = $1;}
                      |assignment           ';'   {$$ = $1;};


assignment: left_hand_side  ESITTIR assignment_expression ';'{$$ = $1 = $3};

conditional_expression:  EGER + expression + ISE + statement + YADA + expression + ISE + statement + YOKSA + statement + ';' ;

exception handling: DENE + '[' + expression + ']' + CALISTIR CATCH (BOLUM Exception  exe) + '['  + expression + ']' 

assignment operator : ESITTIR

DONGU : DONGU + '[' + expression + ']' 

CALISTIR : CALISTIR + '(' + TYPE + ')' + '[' + expression + ']'


%%
/* C Code*/

int computeSymbolIndex(char token)
{
	int idx = -1;
	if(islower(token)) {
		idx = token - 'a' + 26;
	} else if(isupper(token)) {
		idx = token - 'A';
	}
	return idx;
} 

int symbolVal(char symbol)
{
	int bucket = computeSymbolIndex(symbol);
	return symbols[bucket];
}

void updateSymbolVal(char symbol, int val)
{
	int bucket = computeSymbolIndex(symbol);
	symbols[bucket] = val;
}

int main (void) {
	int i;
	for(i=0; i<52; i++) {
		symbols[i] = 0;
	}

	return yyparse ( );
}

void yyerror(char *s) {
 fprintf(stderr, "%s\n", s);
 return 0;
}
int main(void) {
 yyparse();
 return 0;
} 
