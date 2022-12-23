#ifndef AVANCE_H
#define AVANCE_H

#include "jardinHandler.hh"
#include <stdexcept>
#include <iostream>

class avance
{
private:
    JardinRendering* J;
public:
    avance(JardinRendering* J);
    ~avance();
    float getX(id _id);
    float getY(id _id);
    void avance(id _id, int nbFois = 1);
    void avanceTout(int nbFois = 1);

};


