#ifndef DRIVER_H
#define DRIVER_H

#include <map>
#include <string>
#include <QPoint>
#include <QColor>
#include <QSize>
#include "contexte.hh"
enum class direction{
    GAUCHE,
    DROITE
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
    float getX(int id);
    float getY(int id);
    void avance(int x);
    void tourne(direction d);
    void tourneTortues(int d);
};
#endif


