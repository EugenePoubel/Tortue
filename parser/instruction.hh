#ifndef INSTRUCTION_H
#define INSTRUCTION_H
#include "jardinRendering.hh"
#include <stdexcept>
#include <iostream>

enum class direction{
    GAUCHE   = -90,
    DERRIERE = 180,
    DEVANT   = 0,
    DROITE   = 90
};

using id = short;
using coord = float; /*Les coordonnées sont des flottant Nous aurions aussi pu avoir un unsigned int ou un
                    short unsigned int*/

class instruction {
private:
    JardinRendering* J;
public:
    instruction(JardinRendering* J);
    ~instruction();
    float Orientation(int i);
    direction Direction(id _id);
    void tourneTout(direction d, int nbFois = 1);
    void tourne(direction d, id _id, int nbFois = 1);
    float getX(id _id);
    float getY(id _id);
    void avancer(id _id, int nbFois = 1);
    void avanceTout(int nbFois = 1);

};

#endif