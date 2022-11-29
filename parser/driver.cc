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
void Driver::avance(int x,direction d){
    int Orientation;
    for (int i = 0; i < getJardin()->nombreTortues(); i++) 
    {
        avance(x,d,i);
    }
}
void Driver::avance(int x,direction d,int id){
switch ((static_cast<int>(Orientation(id))+static_cast<int>(d))%360)
{
case 0:
getJardin()->changePosition(i,getX(i),getY(i)+x);
    break;
case 90:
getJardin()->changePosition(i,getX(i)+x,getY(i));
    break;
case 180:
getJardin()->changePosition(i,getX(i),getY(i)-x);
    break;
case 270:
getJardin()->changePosition(i,getX(i)-x,getY(i));
    break;
default:
    break;
}
    }
void Driver::tourne(direction d,int x, int id){
    getJardin()->getTortues()[id]->setOrientation((static_cast<int>(Orientation(id))+static_cast<int>(d)*x)%360)
}
void Driver::tourne(direction d,int id){
    getJardin()->getTortues()[id]->setOrientation((static_cast<int>(Orientation(id))+static_cast<int>(d))%360)
}
void Driver::tourne(direction d){
    for (int i = 0; i < getJardin()->nombreTortues(); i++) 
    {
        tourne(d,i);
    }
}
void Driver::tourne(direction d,int x){
    for (int i = 0; i < getJardin()->nombreTortues(); i++) 
    {
        tourne(d,i,x);
    }
}