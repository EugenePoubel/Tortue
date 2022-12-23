#include "tourneclass.hh"

tourneClass::tourneClass(JardinRendering* J)
{
    J=J;
}

float tourneClass::Orientation(int i)
{
    return J.getJardin()->getTortues()[i]->getOrientation();
}