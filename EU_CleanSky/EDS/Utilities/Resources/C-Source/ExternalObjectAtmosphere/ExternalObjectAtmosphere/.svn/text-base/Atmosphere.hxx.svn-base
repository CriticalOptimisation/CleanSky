// -*- coding: utf-8-dos; -*-
// (c)1997-1999 Jean-Marc Le Peuvédic
// (c)2015 Jean-Marc Le Peuvédic & Dassault Aviation portage vers VisualC++ 2008
// Tous droits réservés
#ifndef _ATMOSPHERE_HH
#define _ATMOSPHERE_HH
#include <iosfwd>
#include "Physique.hxx"

namespace _yama_metaprog {
  // unité physique pour un gradient de temperature
  typedef UniteTemperature::Ops<UniteLongueur>::Ratio UniteGradientTemperature;
  // unité physique pour une conductivité thermique
  // TODO : raccourcir ces lignes à rallonge peut être avec des macros...
  typedef UnitePuissance::Ops<UniteLongueur>::Ratio::Ops<UniteTemperature>::Ratio UniteConductiviteThermique;
  // unite physique pour une constante des gaz (dimension Joule/Kelvin)
  typedef UniteEnergie::Ops<UniteTemperature>::Ratio UniteConstanteDesGaz;
};

// grandeur physique pour un gradient de temperature
typedef 
GrandeurPhysique<_yama_metaprog::UniteGradientTemperature> 
GradientTemperature;
// grandeur physique pour une conductivité thermique
typedef 
GrandeurPhysique<_yama_metaprog::UniteConductiviteThermique> 
ConductiviteThermique;
// grandeur physique pour une constante des gaz
typedef
GrandeurPhysique<_yama_metaprog::UniteConstanteDesGaz>
ConstanteDesGaz;

// definition de la classe Atmosphere et de l'objet atmStd(atmosphere standard)

class Atmosphere {
private:
  // constantes pour toutes les atmospheres
  static const double  MmolAir;	// kg/mol
  static const double  gammaAir;
  static const double  stdVol;	// volume molaire des gaz à 0°C et 1 atm.
  static const double  stdTsl;	// temp std au niveau de la mer en K
  static const double  rTerre;	// rayon terrestre fictif
  static const double  suthB;  // viscosite dynamique de reference (Sutherland)
  static const double  suthT;	// temperature de reference (Sutherland)
  static const Densite stdRho;	// densite standard utilisee comme reference
  static const double  epsilon;	// recherche de Z à partir de P

  // variables d'etat de chaque atmosphere
  Pression        Psl; // pression au niveau de la mer
  MasseMolaire    Mmol;// masse molaire du gaz
  Adimensionne    gamma; // ratio des capacites calorifiques du gaz
  Acceleration    G;   // gravite applicable a cette atmosphere
  ConstanteDesGaz R;
  Rayon           r;   // rayon planetaire fictif (latitude 45º32'33")
  bool            std; // vrai si cette atmosphere a un profil de T standard
  bool            densityMonotone;  // vrai si la densite est fonction
                                    // monotone de l'altitude
  
  void init(void);

public:
  // types
  class ProfilTemperature {
  protected:
    Rayon      r;	// rayon planetaire fictif
  public:
    typedef
    GrandeurPhysique<_yama_metaprog::UniteGradientTemperature::Inv> InvGradT;

    virtual Temperature T(Altitude iAlt) const =0; // fonction temperature
    // integrale de 1/T du niveau de la mer a iAlt
    virtual InvGradT IntSLtoAltofInvT(Altitude iAlt) const =0;
    virtual Altitude minAltitude(void) const =0;
    virtual Altitude maxAltitude(void) const =0;
    // fonctions permettant de comparer le profil a differents
    // gradients de temperatures pour determiner la stabilite. 
    //   Si iAlt est inferieur a minAltitude et si la condition est
    //   vraie a minAltitude, ces fonctions renverront minAltitude.
    //   Si la condition est fausse a iAlt et le reste jusque a
    //   maxAltitude, ces fonctions renverront maxAltitude.
    virtual Altitude nextGradTInfA(Altitude iAlt, 
				     GradientTemperature iGradT) const;
    virtual Altitude nextGradTSupA(Altitude iAlt,
				     GradientTemperature iGradT) const;
    virtual Altitude nextGradTNonInfA(Altitude iAlt, 
					GradientTemperature iGradT) const;
    virtual Altitude nextGradTNonSupA(Altitude iAlt,
					GradientTemperature iGradT) const;
    // On peut construire une iteration quel que soit le profil en
    // utilisant soit InfA et NonInfA, soit SupA et NonSupA. 
  protected:
    ProfilTemperature(Rayon iR); // Rayon planétaire

  public:
    virtual ~ProfilTemperature() {};
    // conversion vers et depuis l'altitude geopotentielle
    Altitude convertGeopotentialAltitude(Altitude iAlt) const {
      // Calcule l'altitude geopotentielle selon la formule approchée à
      // 0.001% decrite dans la norme ISO2533. Cette precision n'est
      // garantie que pour la planete Terre.
      Altitude h = iAlt;
      Altitude H = (r * h) / (r + h);
      return H;
    }
    Altitude convertAltitude(Altitude iGeopotentialAlt) const {
      // Calcule l'altitude en fonction de l'altitude geopotentielle
      // suivant la formule inverse de la fonction precedente.
      Altitude H = iGeopotentialAlt;
      Altitude h = (r * H) / (r - H);
      return h;
    }
  };

private:
  ProfilTemperature *profilT;
public:
  // constructeurs
  Atmosphere(void);
  Atmosphere(Pression iPsl, Temperature iTsl); // cond. au niveau de la mer
  Atmosphere(Altitude iAlt, Pression iP, Temperature iT); // cond. en altitude
  Atmosphere(Pression iPsl, ProfilTemperature& iTofAlt);
  Atmosphere(Altitude iAlt, Pression iP, ProfilTemperature& iTofAlt);
  ~Atmosphere();

  struct Gaz {
    Vitesse      a;      // vitesse du son
    Densite      rho;    // densite
    Pourcentage  rhoPct; // ratio de la densite a la densite standard.
    Altitude     densAlt;// altitude dans l'atmosphere std ayant la densite rho
    Temperature           T;    // temperature
    Pression              P;    // pression
    MasseMolaire          Mmol; // masse molaire
    ViscositeDynamique    mu;   // viscosite dynamique [kg/m.s]
    ViscositeCinematique  nu;   // viscosite cinematique  [m^2/s]
    ConductiviteThermique therm;// conductibilité thermique [W/m.K]
  };

  // methodes
  Gaz getEnvironment(Altitude iAlt) const; // iAlt est geometrique
  // elements de Gaz isoles (plus efficace pour en calculer un seul)
  Temperature getTemperature(Altitude iAlt) const {
    return profilT->T(iAlt); // Exception: std::range_error si iAlt hors domaine
  };
  Pression getPressure(Altitude iAlt) const;
  Densite getDensity(Altitude iAlt) const;
  MasseMolaire getMmol(void) const {
    return Mmol;
  };
  Distance getRayonPlanetaire(void) const {
    return r;
  };
  Acceleration getGravite(void) const {
    return G;
  };
  Adimensionne getGamma(void) const {
    return gamma;
  };
  
  // solveurs
  Altitude getAltitude(Pression iP) const;   // la pression est monotone
  Altitude getDensAltitude(Adimensionne iRhoPct) const;
  Altitude getDensAltitude(Densite iRho) const;

  // utilitaires
  Densite getRho0(void) const; // densite au niveau de la mer renvoyee en kg/m3
  Altitude convertGeopotentialAltitude(Altitude iAlt) const {
    return profilT->convertGeopotentialAltitude(iAlt);
  };
  Altitude convertAltitude(Altitude iGeopotentialAlt) const {
    return profilT->convertAltitude(iGeopotentialAlt);
  }; 
  inline Altitude getMaxAltitude(void) const { 
    // altitude maxi definie par le profil de T
    return profilT->maxAltitude();
  };
  inline Altitude getMinAltitude(void) const {
    // altitude mini definie par le profil de T
    return profilT->minAltitude();
  };
  inline int densityIsMonotone(void) const { 
    // vrai si la densite est fonction monotone decroissante de l'altitude
    return densityMonotone; 
  };
  // affiche sur ostr un diagnostic de la stabilite de cette atmosphere
  void stabilityDiagnostic(std::ostream& ostr);
};

// Pour utiliser une atmosphere avec un profil de température
// quelconque, il est possible de l'initialiser avec un objet
// ProfilTemperatureFromTable qui lit le profil dans un flux.
// Pour etre compatible de la norme, la table de temperature est
// donnee en fonction des altitudes geopotentielles.
class ProfilTemperatureFromTable : public Atmosphere::ProfilTemperature {
protected:
  typedef Altitude * pAltitude;
  typedef const Altitude * pcAltitude;
  typedef Temperature * pTemperature;
  typedef const Temperature * pcTemperature;
  typedef InvGradT * pInvGradT;
  typedef Unite<_yama_metaprog::UniteLongueur> UniteLongueur;
  typedef Unite<_yama_metaprog::UniteTemperature> UniteTemperature;

private:
  pAltitude     altitude;
  pTemperature  temperature;
  pInvGradT     intSLtoAltofInvT;
  unsigned      n;
  
  // precalcul du profil de 1/T integre
  void init(void);
protected:
  static const double epsilon;
  
  // acces aux donnees
  pcAltitude& ro_altitude;
  const unsigned& ro_n;
  inline Altitude get_altitude(unsigned i) const {
    return altitude[i]; 
  }
  inline Temperature get_temperature(unsigned i) const {
    return temperature[i]; 
  }

public:
  // Le flux est au format suivant :
  // <nombre de paires> <rayon planetaire fictif>
  // <altitude geopotentielle> <temperature>
  // ... toutes les autres paires.
  ProfilTemperatureFromTable(std::istream& istr);
  // On peut aussi utiliser un tableau
  // Pour simplifier l'initialisation statique du tableau dans le
  // code, c'est un tableau de double sans unité, et les unités sont
  // précisées au constructeur. 
  ProfilTemperatureFromTable(Longueur rayon, unsigned int paires, 
			     const double table[][2],
			     const UniteLongueur& ul = _m, 
			     const UniteTemperature& ut = _K);
//		         const typeof(_m)& ul, 
//		         const typeof(_K)& ut)
  // Dans l'interface des methodes iAlt est toujours une altitude geometrique
  virtual Temperature T(Altitude iAlt) const;
  virtual InvGradT IntSLtoAltofInvT(Altitude iAlt) const;
  virtual Altitude maxAltitude(void) const {
    return convertAltitude(altitude[n-1]);
  };
  virtual Altitude minAltitude(void) const {
    return convertAltitude(altitude[0]);
  };
  virtual ~ProfilTemperatureFromTable() {
    delete [] intSLtoAltofInvT;
    delete [] altitude;
    delete [] temperature;
  };
};

extern Atmosphere standardAtmosphere;

#endif // _ATMOSPHERE_HH


// Local Variables: 
// c-basic-offset:2
// End:
