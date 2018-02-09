// -*- coding: utf-8-dos; -*-
// (c)1997-1999 (c) 2008 Jean-Marc Le Peuvédic
// (c)2015 Jean-Marc Le Peuvédic & Dassault Aviation portage vers VisualC++ 2008
// Tous droits réservés
// v2: avec namespaces et classes STL
#include <cmath>
#include <iostream>
#include <iomanip>
#include "Atmosphere.hxx"

#ifdef _GCC_
#define ISNAN(x) std::isnan(x)
#else
#include <cfloat>
#define ISNAN(x) _isnan(x)
#define rint(x) std::floor((x)+0.5)
#endif

// BUG: le choix effectue pour les profils de temperature decales
// n'a peut etre pas de sens : la stratosphere y est aussi decalee...
// Il serait peut etre plus judicieux d'ajuster le gradient de temperature...
// Voir profils dans sfun_Atmosphere.c
static Temperature stdatmTsl(15,_dC);

// L'atmosphere obeit a l'equation differentielle suivante:
// dP/P = -(g.Mmol/R).dh/T(h)
// ou R=8.31kg.m/K.mol, g=9.8067m/s^2, T(h) est le profil de temperatures
// Dans le cas ou le profil de temperature est standard la classe
// utilise les solutions toutes integrees a cette equation.
const double Atmosphere::MmolAir = 0.028964420;// kg/mol
const double Atmosphere::gammaAir= 1.4;
const double Atmosphere::stdVol  = 22.41358;// litre vol. molaire gaz à 0°C/1atm
const double Atmosphere::rTerre  = 6356766;// rayon terrestre fictif [m]
const double Atmosphere::stdTsl  = 288.15; // temperature std au niv. de la mer
// Constantes de Sutherland pour le calcul de la viscosite dynamique
const double Atmosphere::suthB   = 0.00001789380278077582; // Pa.s
const double Atmosphere::suthT   = 110.4;  // K

const double ProfilTemperatureFromTable::epsilon = 1e-6;

// Unites nouvelles propres à l'implémentation
namespace _yama_metaprog {
  // unite pour les constantes de gaz "R"
  typedef UnitePression::Ops<UniteVolume>::Produit::Ops<UniteTemperature>::Ratio UniteConstanteDesGaz;
};

typedef
GrandeurPhysique<_yama_metaprog::UniteConstanteDesGaz> ConstanteDesGaz;


Atmosphere standardAtmosphere;

Atmosphere::ProfilTemperature::ProfilTemperature(Rayon iR)
  : r(iR)
{}

// versions generiques des recherches de gradients
Altitude
Atmosphere::ProfilTemperature::nextGradTInfA(Altitude iAlt,
					     GradientTemperature iGradT) const
{
  Altitude maxAlt = maxAltitude();
  Temperature prevT;
  Temperature temp;
  Altitude alt;
  const Altitude inc(1.0,_m);

  if(iAlt < minAltitude()) iAlt = minAltitude();

  prevT = T(iAlt);
  for(alt=iAlt+inc; alt<=maxAlt;
      alt+=inc, prevT=temp) {
    temp = T(Altitude(alt));
    GradientTemperature deltaK=(temp-prevT)/inc;
    if(deltaK < iGradT) return alt-inc;
  }
  if( T(maxAltitude()) - prevT < iGradT*(maxAltitude()-alt+inc) )
    return alt-inc;
  return maxAltitude(); // indique la fin de l'itération
}

Altitude
Atmosphere::ProfilTemperature::nextGradTSupA(Altitude iAlt,
					     GradientTemperature iGradT) const
{
  GradientTemperature grad   = iGradT;
  Altitude maxAlt = maxAltitude();
  Temperature prevT;
  Temperature temp;
  Altitude alt;
  const Altitude inc(1.0,_m);

  if(iAlt < minAltitude()) iAlt = minAltitude();

  prevT = T(iAlt);
  for(alt=iAlt+inc; alt<=maxAlt; alt+=inc, prevT=temp) {
    temp = T(Altitude(alt));
    GradientTemperature deltaK=(temp-prevT)/inc;
    if(deltaK>grad) return alt-inc;
  }
  if( T(maxAltitude()) - prevT > grad*(maxAltitude()-alt+inc) )
    return alt-inc;
  return maxAltitude(); // indique la fin de l'itération
}

Altitude
Atmosphere::ProfilTemperature::nextGradTNonInfA(Altitude iAlt,
						GradientTemperature iGrT) const
{
  GradientTemperature grad   = iGrT;
  Altitude maxAlt = maxAltitude();
  Temperature prevT;
  Temperature temp;
  Altitude alt;
  const Altitude inc(1.0,_m);

  if(iAlt < minAltitude()) iAlt = minAltitude();

  prevT = T(iAlt);
  for(alt=iAlt+inc; alt<=maxAlt; alt+=inc, prevT=temp) {
    temp = T(Altitude(alt));
    GradientTemperature deltaK=(temp-prevT)/inc;
    if(deltaK>=grad) return alt-inc;
  }
  if( T(Altitude(maxAltitude())) - prevT >= grad*(maxAltitude()-alt+inc) )
    return alt-inc;
  return maxAltitude(); // indique la fin de l'itération
}

Altitude
Atmosphere::ProfilTemperature::nextGradTNonSupA(Altitude iAlt,
						GradientTemperature iGrT) const
{
  GradientTemperature grad   = iGrT;
  Altitude maxAlt = maxAltitude();
  Temperature prevT;
  Temperature temp;
  Altitude alt;
  const Altitude inc(1.0,_m);

  if(iAlt < minAltitude()) iAlt = minAltitude();

  prevT = T(iAlt);
  for(alt=iAlt+inc; alt<=maxAlt; alt+=inc, prevT=temp) {
    temp = T(Altitude(alt));
    GradientTemperature deltaK=(temp-prevT)/inc;
    if(deltaK<=grad) return alt-inc;
  }
  if( T(maxAltitude()) - prevT <= grad*(maxAltitude()-alt+inc) )
    return alt-inc;
  return maxAltitude(); // indique la fin de l'itération
}

// Exceptions:
// std::invalid_argument si le profil de températures ne définit pas la
// température au niveau de la mer, ou si les températures ne sont pas 
// classées par altitude croissante.
void
ProfilTemperatureFromTable::init(void)
{
  unsigned i;
  
  // Vérifie que les altitudes sont croissantes
  for(i=1; i<n; i++) 
    if(altitude[i-1] >= altitude[i]) 
      throw std::invalid_argument("Profil de température : "
				  "altitudes non croissantes");
  // Vérifie que la température est définie au niveau de la mer
  const Altitude sealevel(0.0,_m);
  if(altitude[0]>sealevel || altitude[n-1]<sealevel)
    throw std::invalid_argument("Profil de température : "
				"température indéfinie au niveau de la mer.");
  // Vérifie que toutes les températures absolues sont positives
  const Temperature zeroAbsolu(0.0,_K);
  for(i=0; i<n; i++) 
    if(temperature[i] < zeroAbsolu) 
      throw std::invalid_argument("Profil de température : "
				  "températures absolues négatives");
  
  intSLtoAltofInvT = new InvGradT[n-1];
  // Précalcul de la table integrale de 1/T
  InvGradT integrale; // initialisé à zéro
  intSLtoAltofInvT[0] = integrale;
  for(i=1; i<n-1; i++) {
    Altitude dz = altitude[i] - altitude[i-1];
    // BUG : will crash if dz == 0, unchecked input
    GradientTemperature a((temperature[i] - temperature[i-1]) / dz);
    Temperature b;
    b = (temperature[i-1]*altitude[i]-temperature[i]*altitude[i-1])/dz;
    if(fabs(a*dz) > fabs(epsilon*b))
#ifdef _GCC_
      integrale += log1p((a*dz)/(a*altitude[i-1]+b))/a;
#else
	  integrale += log(1+(a*dz)/(a*altitude[i-1]+b))/a;
#endif
    else
      integrale += dz/b;
    intSLtoAltofInvT[i] = integrale;
  }
  // On veut les intégrales à partir du niveau de la mer,
  // pas à partir de la première altitude tabulée
  integrale = IntSLtoAltofInvT(sealevel); // Jamais d'exception ici
  for(i=0; i<n-1; i++) intSLtoAltofInvT[i] -= integrale;
}

ProfilTemperatureFromTable::ProfilTemperatureFromTable(std::istream& istr)
  : ProfilTemperature(Rayon(0.0,_m)), 
    ro_altitude(*const_cast<pcAltitude*>(&altitude)), 
    ro_n(n)
{
  Rayon rFichier;
  // Lecture du nombre de paires altitude-temperature
  istr >> n >> rFichier;
  r = rFichier; // mise à jour du rayon dans la classe de base

  if(n < 2) throw std::range_error("Profil de température : "
				   "donner au minimum 2 points");
  altitude = new Altitude[n];
  temperature = new Temperature[n];
  // Lecture des données
  unsigned i;
  for(i=0; i<n; i++) {
    if(istr.eof()) break;
    istr >> altitude[i] >> temperature[i];
  }
  if(i<n) {
    n = i;
    throw std::range_error("Profil de température : pas assez de données");
  }
  init();
}

ProfilTemperatureFromTable::ProfilTemperatureFromTable(Longueur rayon,
						       unsigned paires,
						       const double table[][2],
						       const UniteLongueur& ul, 
							   const UniteTemperature& ut)
  : ProfilTemperature(rayon),
    ro_altitude(*const_cast<pcAltitude*>(&altitude)), 
    ro_n(n)
{
  n = paires;
  if(n < 2) throw std::range_error("Profil de température : "
				   "donner au minimum 2 points");
  altitude = new Altitude[n];
  temperature = new Temperature[n];
  // Lecture des données
  unsigned i;
  for(i=0; i<n; i++) {
    altitude[i]    = Altitude(table[i][0],ul);
    temperature[i] = Temperature(table[i][1],ut);
  }
  init();
}

// Versions spécialisée de la recherche dichotomique
// Envoie une exception si la cle est hors de la gamme couverte, ou NaN.
static unsigned
bsearchdouble(const Altitude cle, const Altitude *base, unsigned nmemb)
{
  unsigned i=nmemb, bot=0;
  if(nmemb==0) throw std::invalid_argument("Recherche dichtomique :"
					   " table vide");
  if(ISNAN(cle.conv_SI())) 
    throw std::invalid_argument("Recherche dichotomique :"
				"la cle de recherche est un NaN");
  if(cle < base[bot]) throw std::range_error("Recherche dichotomique "
					     "en deça de la table");
  // invariants: base[bot] <= cle < base[i] ; bot < i
  // on suppose que base[nmemb] = +INF
  do {
    if(bot+1 == i) {
      if(i<nmemb || base[bot]==cle) break; // base[bot] <= cle < base[bot+1]
      else throw std::range_error("Recherche dichotomique "
				  "au delà de la table");
    }
    unsigned di = (i-bot)/2;  // invariant di >= 1
    Altitude val = base[bot+di];

    static const unsigned BOTTOM=0;
    static const unsigned TOP=1;
    unsigned half = (cle < val) ? BOTTOM : TOP;
    if(half == BOTTOM) {
      i = bot+di; // cle < base[i]
    } else {
      bot += di;  // base[bot] < cle
    }
  } while(1);
  return bot;
}

// Exceptions: std::range_error si iAlt est hors domaine
Temperature
ProfilTemperatureFromTable::T(Altitude iAlt) const
{
  Altitude gAlt = convertGeopotentialAltitude(iAlt);
  // Entre deux points de la table, la température est interpolée.
  unsigned i=bsearchdouble(gAlt, altitude, n); // Exception: std::range_error
  if(altitude[i] == gAlt) return temperature[i];
  // Interpolation lineaire
  Adimensionne p = (altitude[i+1]-gAlt)/(altitude[i+1]-altitude[i]);
  return p*temperature[i] + (1.0-p)*temperature[i+1];
}

// Exceptions: std::range_error si iAlt est hors domaine
Atmosphere::ProfilTemperature::InvGradT
ProfilTemperatureFromTable::IntSLtoAltofInvT(Altitude iAlt) const
{
  Altitude gAlt = convertGeopotentialAltitude(iAlt);
  // altitude[i] <= gAlt < altitude[i+1]
  unsigned i=bsearchdouble(gAlt, altitude, n); // Exception: std::range_error
  // Calculer l'integrale dans l'intervalle courant
  Altitude dz = altitude[i+1] - altitude[i];
  GradientTemperature a = (temperature[i+1] - temperature[i]) / dz;
  Temperature b;
  b = (temperature[i]*altitude[i+1]-temperature[i+1]*altitude[i])/dz;
  InvGradT integrale;
  if(fabs(a*dz) > fabs(epsilon*b))
#ifdef _GCC_
    integrale = log1p((a*(gAlt-altitude[i]))/(a*altitude[i]+b))/a;
#else
	integrale = log(1+(a*(gAlt-altitude[i]))/(a*altitude[i]+b))/a;
#endif
  else
    integrale = (gAlt-altitude[i])/b;
  // Pour intervalles supérieurs à [0;1], ajouter le morceau précalculé
  integrale += intSLtoAltofInvT[i];
  return integrale;
}

// Versions optimisées de nextGradTxx lorsque le profil de
// température est tabulé.
// TODO apres avoir teste les versions generiques
//  double 
//  ProfilTemperatureFromTable::nextGradTInfA(Altitude iAlt, 
//  					      GradientTemperature iGradT);
//  double 
//  ProfilTemperatureFromTable::nextGradTSupA(Altitude iAlt,
//  					      GradientTemperature iGradT);
//  double 
//  ProfilTemperatureFromTable::nextGradTNonInfA(Altitude iAlt,
//  						 GradientTemperature iGradT);
//  double
//  ProfilTemperatureFromTable::nextGradTNonSupA(Altitude iAlt,
//  						 GradientTemperature iGradT);

// ce profil est le profil standard decale d'une constante.
class ProfilTemperatureDecale : public ProfilTemperatureFromTable {
private:
  static const Longueur rTerre;	// rayon terrestre fictif
  static double iso2533[9][2];
    
  InvGradT  * intSLtoAltofInvT;
  Temperature offset;

  // Exceptions: std::invalid_argument si le profil décalé a l'un des 
  // problèmes suivants:
  // - ne définit pas la température au niveau de la mer
  // - les températures n'y sont pas classées par altitude croissante
  // - la température absolue est négative après décalage
  void init(void) {
    unsigned i;
  
    const Altitude sealevel(0.0,_m);
    // les vérifications du profil de base ont été faites par la
    // classe parente, à l'exception des températures négatives, qui
    // peuvent être affectées par l'offset.
    const Temperature zeroAbsolu(0.0,_K);
    for(i=0; i<ro_n; i++) 
      if(get_temperature(i) + offset < zeroAbsolu) 
	throw std::invalid_argument("Profil de température : "
				    "températures absolues négatives");
   
    intSLtoAltofInvT = new InvGradT[ro_n-1];
    // Précalcul de la table integrale de 1/T
    InvGradT integrale;
    intSLtoAltofInvT[0] = integrale;
    for(i=1; i<ro_n-1; i++) {
      Altitude dz = get_altitude(i) - get_altitude(i-1);
      GradientTemperature a = (get_temperature(i) - get_temperature(i-1)) / dz;
      Temperature b = (get_temperature(i-1)*get_altitude(i)-
		       get_temperature(i)*get_altitude(i-1))/dz + offset;
      if(fabs(a*dz) > fabs(epsilon*b))
#ifdef _GCC_
	integrale += log1p((a*dz)/(a*get_altitude(i-1)+b))/a;
#else
    integrale += log(1+(a*dz)/(a*get_altitude(i-1)+b))/a;
#endif
      else
	integrale += dz/b;
      intSLtoAltofInvT[i] = integrale;
    }
    // On veut les intégrales à partir du niveau de la mer,
    // pas à partir de la première altitude tabulée
    integrale = IntSLtoAltofInvT(sealevel); // Jamais d'exception ici
    for(i=0; i<ro_n-1; i++) intSLtoAltofInvT[i] -= integrale;
  };
  
public:
  ProfilTemperatureDecale(Temperature iTsl):
    ProfilTemperatureFromTable(rTerre, sizeof(iso2533)/sizeof(iso2533[0]),
			       iso2533)
  { 
    offset = iTsl-ProfilTemperatureFromTable::T(Altitude(0.0,_m)); 
    init();
  };
  // Exception si iAlt sort du domaine de iso2533
  ProfilTemperatureDecale(Altitude iAlt, Temperature iT):
    ProfilTemperatureFromTable(rTerre, sizeof(iso2533)/sizeof(iso2533[0]),
			       iso2533)
  { 
    offset = iT-ProfilTemperatureFromTable::T(iAlt); // Exception 
    init();
  };
  // Exception si iAlt sort du domaine de iso2533
  virtual Temperature T(Altitude iAlt) const { 
    return ProfilTemperatureFromTable::T(iAlt)+offset; // Exception 
  };
  // Exceptions: std::range_error si iAlt est hors domaine
  virtual InvGradT IntSLtoAltofInvT(Altitude iAlt) const {
    Altitude gAlt = convertGeopotentialAltitude(iAlt);
    // altitude[i] <= gAlt < altitude[i+1]
    unsigned i=bsearchdouble(gAlt, ro_altitude, ro_n); // Exception: range_error
    // Calculer l'integrale dans l'intervalle courant
    // corr 20090428: si iAlt est l'altitude max de l'atmosphere, i vaut ro_n-1
    // et les lignes ci-dessous vont chercher au delà de la fin du tableau.
    if(i+1 == ro_n) i--;
    // corr 20090428 fin
    Altitude dz = get_altitude(i+1) - get_altitude(i);
    GradientTemperature a = (get_temperature(i+1) - get_temperature(i)) / dz;
    Temperature b = (get_temperature(i)*get_altitude(i+1)-
		       get_temperature(i+1)*get_altitude(i))/dz + offset;
    InvGradT integrale; // initialisé à zéro, au cas où iAlt == max
    if(fabs(a*dz) > fabs(epsilon*b))
#ifdef _GCC_
      integrale = log1p((a*(gAlt-get_altitude(i)))/(a*get_altitude(i)+b))/a;
#else
	  integrale = log(1+(a*(gAlt-get_altitude(i)))/(a*get_altitude(i)+b))/a;
#endif
    else
      integrale = (gAlt-get_altitude(i))/b;
    // Pour intervalles supérieurs à [0;1], ajouter le morceau précalculé
    // si iAlt == max, il n'y a que le morceau précalculé
    integrale += intSLtoAltofInvT[i];
    return integrale;
  }
};

// Données statiques du profil standard. Doivent être initialisées
// avant lui.
const Longueur ProfilTemperatureDecale::rTerre(6356766,_m);
double ProfilTemperatureDecale::iso2533[9][2] = {
  {-2000.0, 301.15},
  {    0.0, 288.15},
  {11000.0, 216.65},
  {20000.0, 216.65},
  {32000.0, 228.65},
  {47000.0, 270.65},
  {51000.0, 270.65},
  {71000.0, 214.65},
  {80000.0, 196.65}
};

// le profil de temperature standard
// selon la norme ISO2533-1975 :
// altitude geopotentielle	temperature
class ProfilTemperatureStandard : public ProfilTemperatureDecale {
public:
  ProfilTemperatureStandard(void):
    ProfilTemperatureDecale(stdatmTsl)
  {};
};
// Attention: cet initialiseur doit venir après l'athmosphere standard
// le profil standard ci-dessous dépend de rTerre, _m et _K au travers
// du constructeur de ProfilTemperatureDecale.
ProfilTemperatureStandard profilTemperatureStandard;

const Densite Atmosphere::stdRho = standardAtmosphere.getRho0();

void
Atmosphere::init(void)
{
  Psl  = Pression(1,_atm);
  // Le nombre d'Avogadro fois l'unité de masse atomique pèse 0.001 kg (S.I.)
  Mmol = MasseMolaire(MmolAir,_kg/_mol);// convertit des UMA en kg/mol.
  gamma= Adimensionne(gammaAir);
  G    = Acceleration(1.0,_G);
  R    = Pression(1,_atm)*Volume(stdVol,_l)/       // R en SI (très petit), 
    (Temperature(0.0,_dC)*Adimensionne(1.0,_mol)); // la mole n'est pas SI
  r    = Rayon(rTerre,_m); // les constructeurs ne permettent pas d'autre valeur
  std  = true;		   // profil de temperature externe ou standard
  densityMonotone = false;
  profilT = &profilTemperatureStandard;
}

Atmosphere::Atmosphere(void)
{
  init();
}

Atmosphere::Atmosphere(Pression iPsl, Temperature iTsl)
{
  init();
  Psl  = iPsl;
  std  = false;
  profilT = new ProfilTemperatureDecale(iTsl);
}

// Exceptions:
// - 
Atmosphere::Atmosphere(Altitude iAlt, Pression iP, Temperature iT)
{
  init();
  // il faut recalculer les conditions equivalentes au niveau de la mer
  std  = false;
  Altitude gAlt = convertGeopotentialAltitude(iAlt);
  profilT = new ProfilTemperatureDecale(gAlt,iT); // Exception
  // Exception
  Psl = iP * exp(G * Mmol * profilT->IntSLtoAltofInvT(gAlt) / R);
}

Atmosphere::Atmosphere(Pression iPsl, ProfilTemperature& iTofAlt)
{
  init();
  Psl = iPsl;
  profilT = &iTofAlt;
}

Atmosphere::Atmosphere(Altitude iAlt, Pression iP, ProfilTemperature& iTofAlt)
{
  init();
  // il faut recalculer la pression au niveau de la mer
  profilT = &iTofAlt;
  Psl = iP * exp(G * Mmol * profilT->IntSLtoAltofInvT(iAlt) / R);
}

Atmosphere::~Atmosphere()
{
  if(!std) delete profilT;
  std = 1;
  profilT = &profilTemperatureStandard;
}

// Exceptions : 
//     std::range_error (pour des altitudes hors domaine)
//     std::domain_error (altitude ok, mais altitude densité hors du
//                        domaine très large défini pour l'atmosphere std)
Atmosphere::Gaz
Atmosphere::getEnvironment(Altitude iAlt) const
{
  Gaz gaz;

  gaz.Mmol= Mmol;
  gaz.T   = profilT->T(iAlt); // Exception std::range_error
  gaz.a   = sqrt(gamma * R * gaz.T / Mmol);
  gaz.P   = Psl * exp(-G * Mmol * profilT->IntSLtoAltofInvT(iAlt) / R);
  gaz.rho = gaz.P * gaz.Mmol / (gaz.T * R);
  gaz.rhoPct = gaz.rho / stdRho;

  // attention : la validite de valeurs ci-dessous n'est pas garantie si
  // l'atmosphere n'est pas composee d'air.
  const Temperature tsealevel(stdTsl,_K);
  const ViscositeDynamique viscRef(suthB,_P); // en Poise (kg/m.s = Pa.s)
  const Temperature tempRef(suthB,_K);        // température Sutherland de réf.
  const double coef = pow(gaz.T/tsealevel, 1.5);    // coef fonction de T/stdTsl
  gaz.mu = viscRef * coef * (tsealevel+tempRef) / (gaz.T+tempRef);
  gaz.nu = gaz.mu / gaz.rho;

  // 0.002648151*pow(gaz.T,1.5) = 11,9 * coef
  const ConductiviteThermique ctRef(11.9548616,_W/_m/_K);
  double tkelvin = gaz.T.conv(_K);
  gaz.therm = ctRef * coef / (tkelvin + 245.4 * pow(10.0,-12.0/tkelvin));
  gaz.densAlt = getDensAltitude(gaz.rho); // Exception std::domain_error
  return gaz;
}

// Exceptions: std::range_error is iAlt est hors domaine du profilT
Pression 
Atmosphere::getPressure(Altitude iAlt) const
{
  return Psl * exp(-G * Mmol * profilT->IntSLtoAltofInvT(iAlt) / R); // Excp
}

// Exceptions: std::range_error si iAlt est hors domaine
Densite
Atmosphere::getDensity(Altitude iAlt) const
{
  const Temperature t = profilT->T(iAlt); // Exception std::range_error
  const Pression p = Psl * exp(-G * Mmol * profilT->IntSLtoAltofInvT(iAlt) / R);
  return p * Mmol / (t * R);
}

const double Atmosphere::epsilon = 1e-6;

// Exceptions:
// - std::domain_error si la pression est trop faible ou trop forte
//   et hors des limites de la partie de l'atmosphere où le profil de
//   température est défini.
// - std::invalid_argument si la pression est un nan.
Altitude
Atmosphere::getAltitude(Pression iP) const
{
  Altitude Z;
  Altitude min = getMinAltitude();
  Altitude max = getMaxAltitude();
  Pression P;
  const Altitude threshold(100000*epsilon,_m);
  // Avoid infinite loop if the target altitude is above max or below min.
  P = getPressure(min); // TODO cache maxPressure
  if(iP > P) throw std::domain_error("Pression trop forte");
  P = getPressure(max); // TODO cache minPressure
  if(iP < P) throw std::domain_error("Pression trop faible");
  // Avoid infinite loop if the target altitude is a nan: propagate NaN
  if(ISNAN(iP.conv_SI())) 
    return Altitude(iP.conv_SI(),_m); // keep same NaN tag
  // résoudre l'altitude à laquelle la pression égale iP
  // dichotomie
  // invariant min <= Z <= max
  do {
    Z = (min + max) / 2.0;
    Pression gazP(getPressure(Z));
#if 0
    if(iP < gazP * (1.0 - epsilon)) {
      min = Z;
      continue;
    }
    if(iP > gazP * (1.0 + epsilon)) {
      max = Z;
      continue;
    }
    break;
  } while(1);
#else
    // BUG alternate code iterates until full precision is obtained on Z,
    // instead of pressure. Instead of breaking, iterations go on
    // until max-min is less than a predetermined threshold. 100000_m
    // times epsilon seems to be an acceptable threshold.
    if(iP < gazP) {
      min = Z;
      continue;
    }
    if(iP > gazP) {
      max = Z;
      continue;
    }
  } while(max-min > threshold);
#endif
  return Z;
}

Densite
Atmosphere::getRho0(void) const
{
  const Altitude sealevel(0.0,_m);
  if( std ) {
    return Psl * Mmol / (profilT->T(sealevel) * R);
  }
  return stdRho;
}

// Propage un NaN en entrée.
Altitude
Atmosphere::getDensAltitude(Densite iRho) const
{
  // Calcule l'altitude correspondant à une certaine densité d'air
  // dans l'atmosphère standard (par définition de l'altitude densité).
  // Avoid returning bogus value if iRho is nan().
  if(ISNAN(iRho.conv_SI())) 
    return Altitude(iRho.conv_SI(),_m); // keep nan tag
  Altitude Z;
  //double relDensity;
  Densite Density;
  Altitude min = getMinAltitude();
  Altitude max = getMaxAltitude();
  //double rhoPct = iRhoPct;
  //double stdRho = getRho0();
  int outOfBounds = 0;
  // résoudre l'altitude à laquelle la densite relative égale iRho
  // dichotomie
  // invariant min <= Z <= max
  do {
    Z = (min + max) / 2.0;
    Density = standardAtmosphere.getDensity(Z);
    if(iRho < Density * (1.0 - epsilon)) {
      min = Z;
      outOfBounds--;
      if(outOfBounds <-100) 
	throw std::domain_error("altitude densité trop élevée");
      continue;
    }
    if(iRho > Density * (1.0 + epsilon)) {
      max = Z;
      outOfBounds++;
      if(outOfBounds > 100) 
	throw std::domain_error("altitude densité trop basse");
      continue;
    }
    break; // BUG voir getAltitude
  } while(1);
  return Z;
}

Altitude
Atmosphere::getDensAltitude(Adimensionne iRhoPct) const
{
  // Calcule l'altitude correspondant à une certaine densité d'air
  // dans l'atmosphère standard (par définition de l'altitude densité).
  Densite stdRho = getRho0();
  return getDensAltitude(iRhoPct * stdRho);
}

// Cette methode verifie le gradient de temperature par rapport a
// > 0.00000 K/m inversion de temperature, ultra-stable
// -0.00492 K/m gradient adiabatique atmosphere humide sature (nuage)
//     instable dans les nuages, stable ailleurs, propice aux cumulus
//     et cumulonimbus.
// -0.00984 K/m gradient adiabatique air sec
//     atmosphere completement instable et turbulente (apres-midi d'ete)
// -0.03416 K/m gradient en dessous duquel la densite augmente avec Z
//     grands mouvements d'air verticaux (trou d'air localise)
// Elle positionne aussi correctement le booleen densityMonotone.
void
Atmosphere::stabilityDiagnostic(std::ostream& ostr)
{
  using std::endl;
  using std::setiosflags;
  using std::setprecision;
  using std::setw;

  GradientTemperature gradRho(-0.03416,_K/_m); // -G M / R
  GradientTemperature gradZero(0.0,_K/_m); // inversions are ultra-stable
  // gradient de température stable maximum dans les nuages
  GradientTemperature gradMoistStabLimit(-0.00492,_K/_m);
  // gradient de température stable maximum en air sec
  GradientTemperature gradDryStabLimit(-0.00984,_K/_m);
  densityMonotone = true;
  
  ostr << "Analyse de l'atmosphere" << endl << endl 
       << setiosflags(std::ios::fixed) << setprecision(0);
  Altitude alt    = getMinAltitude();
  Altitude maxAlt = getMaxAltitude();
  for(Altitude fin = alt; fin < maxAlt;) {
    // recherche des inversions de temperature
    Altitude debut = profilT->nextGradTSupA(Altitude(alt), gradZero);
    //if(debut > maxAlt) debut = maxAlt;
    
    if(debut > fin) {
      // il y a une zone sans inversion de temperature avant
      // l'inversion ou entre deux inversions. 
      // Dans cette zone on va chercher des zones instables
      for(Altitude finIns = fin; finIns < debut;) { 
	// recherche de zones instables dans les nuages entre fin et debut
	Altitude debIns = 
	  profilT->nextGradTInfA(Altitude(finIns), gradMoistStabLimit);
	if(debIns > debut) debIns = debut; // tronquer
	if(debIns > finIns) {
	  // il y a une zone stable avant la zone instable dans les nuages
	  ostr << setw(6) << alt << "-" << setw(5) << debIns
	       << "  Couche stable" << endl;
	}
	if(debIns < debut) {
	  // il y a une zone instable (au moins)
	  finIns = 
	    profilT->nextGradTNonInfA(Altitude(debIns), gradMoistStabLimit);
	  // recherche de zones instables entre debIns et finIns
	  for(Altitude finIns2 = debIns; finIns2 < finIns;) {
	    Altitude debIns2 =
	      profilT->nextGradTInfA(Altitude(finIns2),gradDryStabLimit);
	    if(debIns2 > finIns) debIns2 = finIns;
	    if(debIns2 > finIns2) {
	      // il y a une zone stable en air sec mais instable dans
	      // les nuages
	      ostr << setw(6) << finIns2 << "-" << setw(5) << debIns2
		   << "  instabilité dans les nuages (turbulence et Cb)" 
		   << endl;
	    }
	    if(debIns2 < finIns) {
	      // il y a une zone instable
	      finIns2 = 
		profilT->nextGradTNonInfA(Altitude(debIns2), gradDryStabLimit);
	      // recherche de zones a densite croissante entre
	      // debIns2 et finIns2
	      for(Altitude finRho = debIns2; finRho < finIns2;) {
		Altitude debRho =
		  profilT->nextGradTInfA(Altitude(finRho), gradRho);
		if(debRho > finIns2) debRho = finIns2;
		if(debRho > finRho) {
		  // il y a une zone instable avant la zone a densite
		  // croissante ou entre deux zones a rho croissant
		  ostr << setw(6) << finRho << "-" << setw(5) << debRho
		       << "  Couche instable" << endl;
		}
		if(debRho < finIns2) {
		  // il y a une zone tres instable a densite croissante
		  finRho =
		    profilT->nextGradTNonInfA(Altitude(debRho), gradRho);

		  densityMonotone = false; // la densite n'est pas monotone

		  ostr << setw(6) << debRho << "-" << setw(5) << finRho
		       << "  Couche tres instable **augmentation de densite**" 
		       << endl;
		} else break;
	      }
	      // fin de recherche de zones a densite croissante
	    } else break;
	  } // fin de recherche de zones instables en air sec
	} else break;
      } // fin de recherche de zones instables
    }
    if(debut < maxAlt) {
      // il y a une couche d'inversion thermique. Cette couche est
      // ultra stable.
      Altitude fin = profilT->nextGradTNonSupA(Altitude(debut), gradZero);
      ostr << setw(6) << debut << "-" << setw(5) << fin
	   << "  Inversion de temperature" << endl;
    } else break;
  } // fin de recherche d'inversions thermiques
}

#if 0 //def __GNUG__
// BUG in GNU Iostreams : when displaying floating point numbers the
// field is padded with   if it is wider than necessary.
// Recode the function for long doubles and fixed format.
// Scientific format is not a problem because the length of the
// strings is known and constant : do not specify a field width.
#include <stringstream>
ostream& ostream::operator<<(long double n) 
{
  ostream& s = (*this);
  int  prec = s.precision();
  int  wid  = s.width();
  // always right justified.
  double f = 1.0;
  for(int i=0; i<prec; i++) f*=10.0;
  long long int v  = (long long int)rint(n*f);
  long long int fi = (long long int)rint(f);
  long long int frac = v % fi;
  long long int intp = v / fi;
  ios::fmtflags flags = s.flags();
  char scratch[25];
  {
    ostrstream ss(scratch,sizeof(scratch));
    ss.setf(flags); // recover as many flags as possible
    ss.unsetf(~flags | ios::showpoint);
    if(n<0.0 && n>-1.0) {
      ss.unsetf(ios::showpos);
      if(flags && ios::showpos) ss << '-';
    }
    ss << intp << ends;
    ss.flush();
  }
  int newwid = wid - prec - ( prec>0 ? 1 : 0 );
  s.width(newwid);
  s.precision(0);
  s << scratch;
  s.unsetf(ios::showpoint|ios::showpos);
  if(frac<0) frac = -frac;
  s << '.';
  fi /= 10;
  while(frac<fi) {
    fi /= 10;
    s << '0';
  }
  if(frac>0) s << frac;
  s.setf(flags);
  s.unsetf(~flags);
  s.precision(prec);
  return s;
}
#endif //__GNUG__ bug workaround  

void 
displayTable(Atmosphere &atm)
{
  using std::cout;
  using std::cerr;
  using std::endl;
  using std::ios;
  using std::setiosflags;
  using std::resetiosflags;
  using std::setw;
  using std::setprecision;

  Altitude alt; // initialisée à zéro
  Atmosphere::Gaz gaz;

  cout << "  Alt   dAlt    rho/rho0      rho         mu    "
       << "     nu        T       P"
       << endl 
       << "   m     ft        %         kg/m3       Pa.s   "
       << "    m2/s      dC      mbar"
       << endl;
  //alt = ceil(atm.getMinAltitude()/_ft.std(500.0)) * _ft.std(500.0);
  const Altitude step(50.0,_m);
  alt = ceil(atm.getMinAltitude()/step) * step;
  for(;;){
    if(!cout){
      cerr << "Probleme sur cout!" << endl;
      break;
    }
    // BUG in GNU Iostreams : fields wider than the number displayed
    // are filled with   (zeroes) instead of the fill character if
    // the data type is float or double.
    // Workaround : explicit rounding and conversion to int where
    // feasible.
    // Conversion to long double and overloaded subroutine in other cases
    cout << setiosflags(ios::fixed|ios::right);
    cout << setw(6) << (int)rint(alt.conv(_m)) << " ";

    try {
      gaz = atm.getEnvironment(Altitude(alt));

      cout << setw(6) << (int)rint(gaz.densAlt.conv(_m)) << " ";
      
      cout << resetiosflags(ios::fixed);
      cout << setiosflags(ios::scientific);
      cout << setprecision(5) << gaz.rhoPct.conv(_pourcent) << " ";// 11 chars
      
      cout << setprecision(5) << gaz.rho.conv(_kg_m3) << " "; // 11 chars wide
      
      cout << setiosflags(ios::scientific);
      cout << resetiosflags(ios::fixed);
      cout << setprecision(4);
      cout << setw(9) << gaz.mu.conv(_P) << " ";
      
      cout << setw(9) << gaz.nu.conv(_St) << " ";
      
      cout << resetiosflags(ios::scientific);
      cout << setiosflags(ios::fixed|ios::showpos);
      cout << setprecision(3);
      cout << setw(7) << (long double)gaz.T.conv(_dC) << " ";

      cout << resetiosflags(ios::fixed|ios::showpos);
      cout << setiosflags(ios::scientific);
      cout << setprecision(5) << gaz.P.conv(_mbar);
    }
    catch(const std::exception& e) {
      cout << "erreur de domaine: " << e.what(); 
    }
    cout << endl;
    
    //alt += Altitude(500.0, _ft);
    // incrementation de alt pour produire les tableaux de la norme
    if(alt < Altitude(32000.0,_m)) alt += step;
    else if(alt < Altitude(51000.0,_m)) alt += 2*step;
    else alt += 4*step;
    
    if(alt > atm.getMaxAltitude()) break;
  }
  cout << resetiosflags(ios::scientific|ios::showpoint);
  cout << resetiosflags(ios::fixed);
  cout << endl << endl;
}

#ifdef __Atmosphere
#include <fstream>

int
main(void)
{
  using std::cout;
  using std::setprecision;
  using std::endl;

  Atmosphere *atm=0;

  cout << setprecision(5);
  
  cout << "Programme de test de la classe Atmosphere" << endl << endl;
  cout << "densite standard : " << standardAtmosphere.getRho0() << endl;
  displayTable(standardAtmosphere);
  /*
  atm = new Atmosphere();
  displayTable(*atm);
  delete atm;
  atm = new Atmosphere(Pression(1.0,_atm), Temperature(288.16,_K));
  displayTable(*atm);
  delete atm;
  atm = new Atmosphere(Altitude(5000.0,_m), Pression(540.22,_hPa), 255.66);
  displayTable(*atm);
  delete atm;
  atm = new Atmosphere(Altitude(14000.0,_m), Pression(141.03,_hPa), 216.66);
  displayTable(*atm);
  delete atm;
  */
  std::ifstream TprofileStream("data/TemperatureArgenton.dat");
  if(TprofileStream.good()) {
    ProfilTemperatureFromTable Tprofile(TprofileStream);
    atm = new Atmosphere(Pression(1024.0,_hPa), Tprofile);
    displayTable(*atm);
    delete atm;
  }
  atm = new Atmosphere(Altitude(0.0,_m), Pression(1024,_hPa), 
		       Temperature(26.31, _dC));
  displayTable(*atm);
  delete atm;
  atm = new Atmosphere(Altitude(426.0,_ft), Pression(1.0100,_bar), 
		       Temperature(15.0,_dC));
  Atmosphere::Gaz gaz = atm->getEnvironment(Altitude(1426.0,_ft));
  
  cout << "Altitude densit" "\xe9" " " "\xe0" " 1000ft QFE = " << gaz.densAlt.conv(_ft) << endl;
  cout << "Ratio de densit" "\xe9" "s d'air " "\xe0" " 1000ft QFE = " << gaz.rhoPct << endl;

  gaz = atm->getEnvironment(Altitude(426.0,_ft));
  cout << "Altitude densit" "\xe9" " " "\xe0" " 426ft QNH = " << gaz.densAlt.conv(_ft) << endl;

  // Test d'une altitude densité hors domaine de définition de l'atmosphere
  try {
    gaz = atm->getEnvironment(atm->getMinAltitude());
    cout << "Altitude densit" "\xe9" " " "\xe0" " " << atm->getMinAltitude()
	 << " = " << gaz.densAlt.conv(_m) << endl;
  }
  catch(std::domain_error& e) {
    cout << "Erreur domaine : " << e.what() << endl;
  }

  delete atm;

  try {
    // Domain error (altitude too high)
    Altitude alt = standardAtmosphere.getAltitude(Pression(0.0,_Pa));
  }
  catch(std::domain_error& e) {
    cout << "Erreur domaine : " << e.what() << endl;
  }
  return 0;
}

#endif // __Atmosphere


// Local Variables: 
// c-basic-offset:2
// End:
