#ifndef DRIVER_H
#define DRIVER_H

#include <map>
#include <string>
#include <QPoint>
#include <QColor>
#include <QSize>
#include "contexte.hh"

class JardinHandler;
class JardinRendering;

class Driver {
private:      
    JardinHandler * monJardin;
    Contexte variables;       
public:
    Driver(JardinHandler * J);
    ~Driver();
    const   Contexte& getContexte() const;
    double  getVariable(const std::string& name) const;
    void    setVariable(const std::string& name, double value);
    JardinRendering* getJardin();
    float Orientation(int i);
    direction Direction(id _id);
    float getX(id _id);
    float getY(id _id);
    void avanceTout(int nbFois);
    void avance(id _id, int nbFois);
    void tourneTout(direction d,int nbFois);
    void tourne(direction d,id _id, int nbFois);
    bool Mur(direction d, id _id);
    bool Vide(direction d, id _id);
};
#endif


