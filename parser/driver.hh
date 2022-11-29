#ifndef DRIVER_H
#define DRIVER_H

#include <map>
#include <string>
#include <QPoint>
#include <QColor>
#include <QSize>
#include "contexte.hh"
enum class direction{
    GAUCHE   = -90,
    DERRIERE = 180,
    DEVANT   = 0,
    DROITE   = 90
};
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
    void deplacement(int x,int y,int idTortue);
    float Orientation(int i);
    direction Direction(int id);
    float getX(int id);
    float getY(int id);
    void avance(int x);
    void avance(int x,int id);
    void avance(int x,direction d);
    void avance(int x,direction d,int id);
    void tourne(direction d);
    void tourne(direction d,int x);
    void tourne(direction d,int x,int id);
    void tourne(direction d,int d);
};
#endif


