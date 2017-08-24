%{
  int table_point=0,token_place=0; 

  struct table{
	int token_id;
	char type[7];
	char lexeme[12];
	}token_list[50];

	
	int isExists(char *word);
	int add_token(char *lex, char *l_type);
	void show();

%} 

delim [ \t\n]
ws {delim}+

digit [0-9] 
letter [A-Za-z] 

id ({letter}|_)({letter}|{digit}|_)*
int {digit}+(E[+-]?{digit}+)?
float {digit}+(\.({digit})+)(E[+-]?{digit}+)?
string ["].*["]
key "class"|"if"|"while"|"else"|"for"|"new"|"public"|"static"|"void"|"main"|"int"|"char"|"assert"|"return"|"System"|"out"|"println"|"this"|"private"|"true"|"false"|"boolean"

%% 
	{	add_token("if","key");
		add_token("while", "key");
		add_token("else", "key" );
		add_token("new", "key");
		add_token("public","key");
		add_token("static","key");
		add_token("static","key");
		add_token("static","key");
		add_token("static","key");
		add_token("void","key");
		add_token("main","key");
		add_token("int","key");
		add_token("char","key");
		add_token("assert","key");
		add_token("return","key");
		add_token("for","key");
		add_token("class","key");
		add_token("System","key");
		add_token("out","key");
		add_token("println","key");
		add_token("this","key");
		add_token("private","key");
		add_token("true","key");
		add_token("false","key");
		add_token("boolean","key");
	}
exit    			{return 0;}
{ws}				/* nothing */
{key} 				{printf(" <%s> ",yytext);}
{id} 				{token_place=add_token(yytext,"id");printf(" <id,%d> ",token_place);}
{int}				{token_place=add_token(yytext,"int");printf(" <num,%d> ",token_place);}
{float}				{token_place=add_token(yytext,"float");printf(" <num,%d> ",token_place);}
"="					{printf(" <EQ> ");}
"!="				{printf(" <NE> ");}
"<=" 				{printf(" <LE> ");}
"==" 				{printf(" <EE> ");}
">=" 				{printf(" <GE> ");}
"<"[^>=]			{printf(" <LT> ");}
">"[^<=]			{printf(" <GT> ");}
"&&"				{printf(" <AND> ");}
"||"				{printf(" <OR> ");}
"+"|"-"|"*"|"/"		{printf(" <%s> ",yytext);}
"{"|"}"|"("|")"|";"	{printf(" <%s> ",yytext);}
.					{printf(" <.> ");}
{string}			{token_place=add_token(yytext,"str");printf(" <str,%d> ",token_place);}
"/*"([^*]|\*+[^*/])*\*+"/"		/* multi line comment */
"//".*				// single line comment

%% 

int isExists(char *word){
	int i=0;
	//printf("::::%s\n",word);
	while(i<table_point){
		//printf("%d %s\n",i, token_list[i].lexeme);
		if(strcmp(word,token_list[i].lexeme)==0){
			return i+1;//+1 because row 0 stores 1, row 1 stores 2, and so...
		}
		i++;
	}
	return 0;
}

void show(){
	printf("\n");
	int i=0;
	while(i<table_point){
		printf("%d - %s\t%s\n",token_list[i].token_id,token_list[i].lexeme,token_list[i].type);
		i++;
	}
}

int add_token(char *lex, char *l_type){
	int exists=isExists(lex);
	//insert in table
	if(!exists){
		strcpy(token_list[table_point].lexeme,lex);
		strcpy(token_list[table_point].type,l_type);
		token_list[table_point].token_id=table_point+1;
		return ++table_point;
	}
	else{
		return exists;
	}
}

int main(void) { 
    yyin=fopen("input.txt", "r");
    int ret_val=yylex();

    if(!ret_val)
    show();

    fclose(yyin);
    return 0; 
} 
