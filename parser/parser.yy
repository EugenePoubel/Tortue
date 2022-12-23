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
    #include "tourneclass.hh"
    #include "constante.hh"
    #include "variable.hh"
    #include "avance.hh"
    #include "tourneclass.hh"
    
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
%token                  TOURNE
%token                  AT
%type <int>             mouvement
%type <int>             exp
%type <std::shared_ptr<tourneClass>> instruction

%left '+'
%left '*'
%precedence NEG


%%

programme:
    instruction NL programme
    | END NL {
        YYACCEPT;
    }

    //déplacement 

instruction:    

    //deplacement sur toutes les tortues
    TOURNE GAUCHE mouvement {
        std::cout << "tourne à gauche "<<$3<<" fois"<<std::endl;
        $$ = std::shared_ptr<tourneClass>(new tourneClass(driver.getJardin()));
        $$->tournerTout(direction::GAUCHE,$3);
    }
    | TOURNE DROITE mouvement {
        std::cout << "tourne à droite "<<$3<<" fois"<<std::endl;
        $$ = std::shared_ptr<tourneClass>(new tourneClass(driver.getJardin()));
        $$->tournerTout(direction::DROITE,$3);

    }  
    | RECULE mouvement {
        std::cout << "reculer de "<<$2 <<std::endl;
        $$ = std::shared_ptr<avance>(new avance(driver.getJardin()));
        $$->avanceTout(-$2);

    }  
    | AVANCE mouvement{
        std::cout << "avance de "<<$2 <<std::endl;
        $$ = std::shared_ptr<avance>(new avance(driver.getJardin()));
        $$->avanceTout($2);

    }

    //deplacement sur une tortue

    | TOURNE GAUCHE mouvement AT NUMBER {
        std::cout <<"tortue numéro "<<$5<<" tourne à gauche "<<$3<<" fois"<<std::endl;
        $$ = std::shared_ptr<tourneClass>(new tourneClass(driver.getJardin()));
        $$->tourner(direction::GAUCHE,$5,$3);
    } 
    | TOURNE DROITE mouvement AT NUMBER {
        std::cout <<"tortue numéro "<<$5<< " tourne à droite "<<$3<<" fois"<<std::endl;
        $$ = std::shared_ptr<tourneClass>(new tourneClass(driver.getJardin()));
        $$->tourner(direction::GAUCHE,$5,$3);
    } 
    | RECULE mouvement AT NUMBER {
        std::cout <<"tortue numéro "<<$4<< " reculer de "<<$2<<std::endl;
        $$ = std::shared_ptr<avance>(new avance(driver.getJardin()));
        $$->avance($4,-$2);
    }  
    | AVANCE mouvement AT NUMBER {
        std::cout <<"tortue numéro "<<$4<< " avance de "<<$2<<std::endl;
        $$ = std::shared_ptr<avance>(new avance(driver.getJardin()));
        $$->avance($4,$2);

    }

    //deplacement sur toutes les tortues
/*
     TOURNE GAUCHE mouvement {
        std::cout << "tourne à gauche "<<$3<<" fois"<<std::endl;
        driver.tourneTout(direction::GAUCHE,$3);
       
    } 
    | TOURNE DROITE mouvement {
        std::cout << "tourne à droite "<<$3<<" fois"<<std::endl;
        driver.tourneTout(direction::DROITE,$3);

    }  
    | RECULE mouvement {
        std::cout << "reculer de "<<$2 <<std::endl;
        driver.avanceTout(-$2);

    }  
    | AVANCE mouvement{
        std::cout << "avance de "<<$2 <<std::endl;
        driver.avanceTout($2);

    }

    //deplacement sur une tortue

    | TOURNE GAUCHE mouvement AT NUMBER {
        std::cout <<"tortue numéro "<<$5<<" tourne à gauche "<<$3<<" fois"<<std::endl;
       driver.tourne(direction::GAUCHE,$5,$3);
    } 
    | TOURNE DROITE mouvement AT NUMBER {
        std::cout <<"tortue numéro "<<$5<< " tourne à droite "<<$3<<" fois"<<std::endl;
        driver.tourne(direction::DROITE,$5,$3);
    } 
    | RECULE mouvement AT NUMBER {
        std::cout <<"tortue numéro "<<$4<< " reculer de "<<$2<<std::endl;
        driver.avance($4,-$2);
    }  
    | AVANCE mouvement AT NUMBER {
        std::cout <<"tortue numéro "<<$4<< " avance de "<<$2<<std::endl;
        driver.avance($4,-$2);

    } */
   
    //mise en forme d'un mouvement 

mouvement:

    {
        $$=1;
    }
    |
    exp {
        $$=$1;
    }
    |
    exp FOIS {
        $$=$1;
    }

    //recuperation d'un calcul

exp :
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
