%skeleton "lalr1.cc"
%require "3.0"

%defines
%define parser_class_name { Parser }
%define api.value.type variant
%define parse.assert

%locations

%code requires{
    #include "contexte.hh"
    #include "expressionBinaire.hh"
    #include "expressionUnaire.hh"
    #include "constante.hh"
    #include "variable.hh"
    
    class Scanner;
    class Driver;
}

%parse-param { Scanner &scanner }
%parse-param { Driver &driver }

%code{
    #include <iostream>
    #include <string>
    
    #include "scanner.hh"
    #include "driver.hh"

    #undef  yylex
    #define yylex scanner.yylex
}

%token                  NL
%token                  END
%token <int>            NUMBER
%token                  RECULE
%token                  AVANCE
%token                  GAUCHE
%token                  DROITE
%token                  FOIS
%type <int>             exp

%left '+'
%left '*'
%precedence NEG


%%

programme:
    NUMBER NL {
        std::cout << "nombre : " << $1 << std::endl;
        driver.setVariable("a",$1);
        std::cout <<driver.getVariable("a") << std::endl;
    } 
    
    
    programme
    | RECULE NL{
        std::cout << "recule " <<std::endl;

    }  programme
    | AVANCE NL{
        std::cout << "avance " <<std::endl;

    }  programme
    | DROITE NL{
        std::cout << "droite " <<std::endl;

    }  programme
    | GAUCHE NL{
        std::cout << "gauche " <<std::endl;

    }  
    
    
    programme
    | GAUCHE  exp NL{
        std::cout << "gauche avec nombre" <<$2 <<std::endl;
       
    } programme
    | DROITE NUMBER NL{
        std::cout << "droite nombre : " <<$2<<std::endl;

    }  programme
    | RECULE exp NL{
        std::cout << "reculer avec nombre "<<$2 <<std::endl;

    }  programme
    | AVANCE exp NL{
        std::cout << "avance avec nombre "<<$2 <<std::endl;

    }  
    
    
    
    
    programme
    | GAUCHE  exp  FOIS NL{
        std::cout << "gauche avec nombre" <<$2 <<" fois"<<std::endl;
       
    } programme
    | DROITE NUMBER FOIS NL{
        std::cout << "droite nombre : " <<$2<<" fois"<<std::endl;

    }  programme
    | RECULE exp FOIS NL{
        std::cout << "reculer avec nombre "<<$2 <<" fois"<<std::endl;

    }  programme
    | AVANCE exp FOIS NL{
        std::cout << "avance avec nombre "<<$2 <<" fois"<<std::endl;

    }  
    
    
    
    programme
    | END NL {
        YYACCEPT;
    }
    

    
exp:
        NUMBER
    |   exp '+' exp {
        $$ = $1 + $3;
    }
    |   exp '*' exp {
        $$ = $1 * $3;
    }
    |   '(' exp ')' {
        $$ = $2;
    }
    |   '-' exp  %prec  NEG  {
        $$ = -$2;
    }
    |   exp '/' exp {
        $$ = $1 / $3;
    }
    
%%

void yy::Parser::error( const location_type &l, const std::string & err_msg) {
    std::cerr << "Erreur : " << l << ", " << err_msg << std::endl;
}
