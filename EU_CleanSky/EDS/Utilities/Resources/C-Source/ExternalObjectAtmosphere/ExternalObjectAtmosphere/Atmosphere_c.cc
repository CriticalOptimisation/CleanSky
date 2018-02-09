/* -*- coding: utf-8-dos; -*- */
/* (c)2008 Jean-Marc Le Peuvédic
   Tous droits réservés */

/* Ce fichier C++ implémente une interface C aux classes de la librarie
   Atmosphere. L'implémentation est simpliste car les handle d'objets
   sont les pointeurs eux-mêmes, transtypés en void *. */
// VC++ Exports
#ifdef WIN32
#define EXPORT __declspec(dllexport)
#else
#define EXPORT
#endif

#include "Atmosphere.h"   // interface C à implémenter
#include "Atmosphere.hxx"  // interface C++ disponible

#ifdef _GCC_
#define NAN(x) nan(x)
#else
#include <limits>
#define NAN(x) std::numeric_limits<double>::quiet_NaN()
#endif
#define UNREFERENCED_VARIABLE(x) ((void)(x))

/* Constructeurs */

/* atmosphere standard */
EXPORT pAtmosphere newStdAtmosphere(void) {
  try {
    return static_cast<pAtmosphere>(new Atmosphere());
  }
  catch(std::exception& e) {
    // out of memory
    UNREFERENCED_VARIABLE(e);
    return 0;
  }
};

EXPORT pAtmosphere newAtmosphere(double iPression, 
			  pProfilTemperature iProfilT) {
  typedef Atmosphere::ProfilTemperature ProfilTemperature;
  ProfilTemperature * profilT(NULL);
  profilT = static_cast<ProfilTemperatureFromTable *>(iProfilT);
  Atmosphere * atm(NULL);
  try {
    atm = new Atmosphere(Pression(iPression,_Pa), *profilT);
  }
  catch(std::exception& e) {
    // out of memory
    UNREFERENCED_VARIABLE(e);
    return NULL;
  }
  return static_cast<pAtmosphere>(atm);
};

EXPORT pProfilTemperature newProfilTemperatureFromTable(double iRayon, 
						 unsigned iPaires,
						 double iTable[][2]) {
  Atmosphere::ProfilTemperature * profilT(NULL);
  try {
    profilT = new ProfilTemperatureFromTable(Rayon(iRayon,_m), iPaires, iTable);
  }
  catch(std::exception& e) {
    // out of memory
    UNREFERENCED_VARIABLE(e);
    return NULL;
  }
  return static_cast<pProfilTemperature>(profilT);
};

/* Destructeurs */
EXPORT void deleteAtmosphere(pAtmosphere atm) {
  if(atm != NULL) delete static_cast<Atmosphere*>(atm);
};

EXPORT void deleteProfilTemperature(pProfilTemperature profilT) {
  if(profilT != NULL) 
    delete static_cast<ProfilTemperatureFromTable*>(profilT);
};

/* Fonctions - le strict minimum pour le moment */
EXPORT double getRayonPlanetaire(pAtmosphere iAtm) {
  Atmosphere * atm = static_cast<Atmosphere*>(iAtm);
  return atm->getRayonPlanetaire().conv(_m);
};

EXPORT double getPressure(pAtmosphere iAtm, double iAlt) {
  Atmosphere * atm = static_cast<Atmosphere*>(iAtm);
  double pressure;
  try {
    pressure = atm->getPressure(Altitude(iAlt,_m)).conv(_Pa);
  } catch(std::exception& e) {
    // will return a nan.
    pressure = NAN("DOMAIN");
	UNREFERENCED_VARIABLE(e);
  }
  return pressure;
};

EXPORT double getAltitude(pAtmosphere iAtm, double iPs) {
  Atmosphere * atm = static_cast<Atmosphere*>(iAtm);
  double altitude;
  try {
    altitude = atm->getAltitude(Pression(iPs,_Pa)).conv(_m);
  } catch(std::exception& e) {
    // will return a nan.
    altitude = NAN("DOMAIN");
	UNREFERENCED_VARIABLE(e);
  }
  return altitude;
};

EXPORT Atmosphere_Gaz getEnvironment(pAtmosphere iAtm, double iAlt) {
  Atmosphere * atm = static_cast<Atmosphere*>(iAtm);
  Atmosphere::Gaz ag;
  Atmosphere_Gaz g;
  try {
    ag = atm->getEnvironment(Altitude(iAlt,_m)); // Exception
    g.a   = ag.a.conv(_m_s);
    g.rho = ag.rho.conv(_kg/_m3);
    g.T   = ag.T.conv(_K);
    g.P   = ag.P.conv(_Pa);
  }
  catch(std::exception& e) {
    // altitude is out of bounds
    g.a   = NAN("DOMAIN");
    g.rho = NAN("DOMAIN");
    g.T   = NAN("DOMAIN");
    g.P   = NAN("DOMAIN");
	UNREFERENCED_VARIABLE(e);
  }
  return g;
};
