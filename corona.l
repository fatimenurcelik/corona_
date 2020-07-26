%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
%}
%option nounput yylineno

%%

DOGRU		 	  {return DOGRULUK IBARESI;}
YANLIS			  {return DOGRULUK IBARESI;}
"("			  {return AC PARANTEZ;}
")" 			  {return KAPA PARANTEZ;}
ISE			  {return ISE \n;}
NOKTA 			  {return . \n;}
EGER 			  {return EGER;}
YADA			  {return YA DA;}
YOKSA			  {return YOKSA;}
YORUM			  {return YORUM:;}
YORUM_AC		  {return YORUM BASI;}
YORUM_KAPA		  {return YORUM SONU;}
ESITTIR			  {return ESITTIR;}
ANCAKVEANCAK	 	  {return ANCAKVEANCAK;}
"<=>"			  {return ANCAKVEANCAK;}
VE|"&&"			  {return VE;}
VEYA|"|"		  {return VEYA;}
DEGIL|"^"	 	  {return DEGIL;}
DEMEK|"=>"	  	  {return DEMEK;}
KUCUKESIT|"<="		  {return KUCUKESIT;}
KUCUK|"<"		  {return KUCUKTUR;}
BUYUKESIT|">="		  {return BUYUKESIT;\
BUYUK|">"		  {return BUYUKTUR;}
ESIT|"=="		  {return ESIT;}
EKRANAYAZ		  {return ŞUNU EKRANAYAZ:;}
TARA			  {return ŞUNU OKU:;}
DONGU			  {return DONGU:;}
ARTI|"+"		  {return ARTI;}
EKSI|"-"		  {return EKSI;}
BOLU|"/"		  {return BOLU;}
CARPI|"*"		  {return CARPI;}
KALAN|"%"		  {return KALAN;}
CALISTIR		  {return CALISTIR;}
BOLUM			  {return BOLUM ;}
[a-zA-Z]+		  {yyval.id=atoi(yytext);return YAZIDIZISI;}
[0-9]+			  {yyval.num=atoi(yytext);return SAYI;}
[a-zA-Z][a-zA-Z]*[0-9]*	  {yyval.var=atoi(yytext);return DEGISKEN;}
[ \t\n]  		  {;}
.		          {return ANLASILMAYAN KARAKTER;}
%%

int yywrap(void){return 1;}
