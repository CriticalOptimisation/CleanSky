/* -*- coding: utf-8-dos; -*- */
/* (c)2008 Jean-Marc Le Peuvédic
   Tous droits réservés */
#ifndef _ATMOSPHERE_H
#define _ATMOSPHERE_H

/* Ce fichier déclare une interface C pour les fonctionnalités
   de la classe Atmosphere. Il peut être compilé par un compilateur
   C. */
#ifdef __cplusplus
extern "C" { // use the C fcn-call standard for all functions  
#endif       /* defined within this scope                     */

  typedef void * pAtmosphere;
  typedef void * pProfilTemperature;
  typedef struct {
    double a;    /* vitesse du son */
    double rho;  /* densite */
    double rhoPct; /* ratio de la densité à la densité standard. */
    double densAlt;/* altitude dans l'atmosphère std ayant la densité rho */
    double T;    /* temperature */
    double P;    /* pression */
    double mu;   /* viscosité dynamique kg/m.s */
    double nu;   /* viscosité cinématique m^2/s */
    double therm;/* conductibilité thermique W/m.K */
  } Atmosphere_Gaz;

  /* Constructeurs */
  EXPORT pAtmosphere newStdAtmosphere(void); /* atmosphere standard */
  EXPORT pAtmosphere newAtmosphere(double iPression, pProfilTemperature);
  EXPORT pProfilTemperature newProfilTemperatureFromTable(double rayon, 
						   unsigned paires,
						   double table[][2]);
  /* Destructeurs */
  EXPORT void deleteAtmosphere(pAtmosphere);
  EXPORT void deleteProfilTemperature(pProfilTemperature);

  /* Fonctions - le strict minimum pour le moment */
  EXPORT double getRayonPlanetaire(pAtmosphere);
  EXPORT double getPressure(pAtmosphere, double iAlt);
  EXPORT double getAltitude(pAtmosphere, double iPs);
  EXPORT Atmosphere_Gaz getEnvironment(pAtmosphere, double iAlt);
  
#endif /* _ATMOSPHERE_H */

#ifdef __cplusplus
} // end of extern "C" scope
#endif
