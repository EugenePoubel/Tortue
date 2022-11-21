#include "driver.hh"
#include "jardinHandler.hh"
#include <iostream>

Driver::Driver(JardinHandler * J) {
    monJardin = J;
}

Driver::~Driver() {
	delete monJardin;
}

const Contexte& Driver::getContexte() const {
    return variables;
}

double Driver::getVariable(const std::string & name) const {
    return variables.get(name);
}

void Driver::setVariable(const std::string & name, double value) {
    variables[name] = value;
}

JardinRendering * Driver::getJardin() {
    return monJardin->getJardinRendering();
}
void Driver::deplacement(int x,int y,int id){
    
    getJardin()->changePosition(id,x,y);
}
float Driver::Orientation(int i){
    return getJardin()->getTortues()[i]->getOrientation();
}
float Driver::getX(int id){
   return getJardin()->getTortues()[id]->getX();
}
float Driver::getY(int id){
   return getJardin()->getTortues()[id]->getY();
}
void Driver::avance(int x){
    for (int i = 0; i < getJardin()->nombreTortues(); i++) 
    {
        switch (static_cast<int>(Orientation(i)))
        {
        case 0:
        getJardin()->changePosition(i,getX(i)+x,getY(i));
            break;
        case 90:
        getJardin()->changePosition(i,getX(i)-x,getY(i));
            break;
        case 180:
        getJardin()->changePosition(i,getX(i),getY(i)+x);
            break;
        case 270:
        getJardin()->changePosition(i,getX(i),getY(i)-x);
            break;
        default:
            break;
        }
    }
}
void Driver::tourneTortues(int d){
    for (int i = 0; i < getJardin()->nombreTortues(); i++) 
    {
        getJardin()->getTortues()[i]->setOrientation(Orientation(i)+d);
    }
    
}
void Driver::tourne(direction d){
    switch (d)
    {
    case direction::GAUCHE:
        tourneTortues(-90);
        break;
    case direction::DROITE:
        tourneTortues(+90);
        break;
    default:
        break;
    }
}
/* EXEMPLE
void    Driver::changerPositionTortue0(int x, int y) {
    monJardin->changePosition(0,x,y);
}

float    Driver::obtenirOrientationTortue1() {
    monJardin->orientation(1,o);
}
/*/
