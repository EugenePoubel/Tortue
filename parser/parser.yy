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
    #incliude "condition.hh"
    
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
%token                  VIDE
%token                  MUR
%token                  IF
%token                  DEVANT
%token                  DERRIERE
%token                  FIN
%token                  ELSE
%type <int>             mouvement
%type <int>             exp
%type <std::shared_ptr<tourneClass>> instruction
%type <std::shared_ptr<tourneClass>> tourner
%type <std::shared_ptr<avance>> avancer
%type <direction>       dir

%left '+'
%left '*'
%precedence NEG


%%

programme:
      instruction NL programme
    | cond NL programme
    | END NL 
    {
        YYACCEPT;
    }

    //mise en forme d'une condition

cond:
    //dans chaque bloc normalement création d'un objet condition 
    //avec le jardin et la condition en paramètre
    //pour calculer ensuite si la condition et réalisale ou non 
    IF MUR dir ':' NL instruction NL FIN{
        
    } 
    |
    IF MUR dir ':' NL instruction NL ELSE ':' NL FIN{

    } 
    |
    IF VIDE dir ':' NL instruction NL FIN{
        
    }
    |
    IF VIDE dir ':' NL instruction NL ELSE ':' NL FIN{
        
    }


instruction:    
    //Instruction aurait du servir à séparer avancer et tourner
    //pour le calcul dans condition 
    tourner {
        $$=$1;
    }
    | avancer{
        $$=$1;
    }


tourner:

    //deplacement sur toutes les tortues
    TOURNE dir mouvement {
        std::cout << "tourne à gauche/droite "<<$3<<" fois"<<std::endl;
        $$ = std::shared_ptr<tourneClass>(new tourneClass(driver.getJardin()));
        $$->tournerTout($2,$3);
    }
        //deplacement sur une tortue

    | TOURNE dir mouvement AT NUMBER {
        std::cout <<"tortue numéro "<<$5<<" tourne à gauche/droite "<<$3<<" fois"<<std::endl;
        $$ = std::shared_ptr<tourneClass>(new tourneClass(driver.getJardin()));
        $$->tourner($2,$5,$3);
    } 

avancer:

        //deplacement sur toutes les tortues

    RECULE mouvement {
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

    | RECULE mouvement AT NUMBER {
        std::cout <<"tortue numéro "<<$4<< " reculer de "<<$2<<std::endl;
        $$ = std::shared_ptr<avance>(new avance(driver.getJardin()));
        $$->avancer($4,-$2);
    }  
    | AVANCE mouvement AT NUMBER {
        std::cout <<"tortue numéro "<<$4<< " avance de "<<$2<<std::endl;
        $$ = std::shared_ptr<avance>(new avance(driver.getJardin()));
        $$->avancer($4,$2);

    }

   //choix de la direction

dir:
    GAUCHE {
        $$=direction::GAUCHE;
    }
    |
    DROITE {
        $$=direction::DROITE;
    }
    |
    DEVANT {
        $$=direction::DEVANT;
    }
    |
    DERRIERE{
        $$=direcetion::DERRIERE;
    }

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
