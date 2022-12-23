#ifndef TOURNECLASS_H
#define TOURNECLASS_H
#include "jardinHandler.hh"
#include <stdexcept>
#include <iostream>

class tourneClass {
private:
    JardinRendering* J;
    int o;
    int _num;
public:
    tourneClass(JardinRendering* J);
    ~tourneClass();
    void tourner(int x);
    int getO() const { return o; }
    int getNum() const { return _num ;}
    void tournerTortue(int x,int num);
    float Orientation(int i);
};

#endif