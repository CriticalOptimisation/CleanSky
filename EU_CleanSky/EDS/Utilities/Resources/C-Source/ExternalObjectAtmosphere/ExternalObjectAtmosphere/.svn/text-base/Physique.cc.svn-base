// -*- coding: utf-8-dos; -*-
// (c)1997-1998 Jean-Marc Le Peuvédic
// (c)2009 Jean-Marc Le Peuvédic & Dassault Aviation _yama::UniteInfo class
// (c)2015 Jean-Marc Le Peuvédic & Dassault Aviation portage vers VisualC++ 2008
// Tous droits réservés
#include "Physique.hxx" // doit compiler de façon autonome

#include <cstdlib>
#include <cstring>
#include <locale>
#include <cassert>
#include <iostream>
#include <iomanip>
// Pour constuire des chaînes de caractères formatées (i18n).
#include <vector>
#include <cstdio>
#if defined(_MSC_VER) // VC++ 8.0 and below
#define SNPRINTF(fmt,sz, ...) sprintf((fmt),__VA_ARGS__)
#else
#define SNPRINTF(fmt,sz, ...) std::snprintf((fmt),(sz),__VA_ARGS__)
#endif

#include "libintl.h"  // GNU gettext()
#include "direct.h"   // windows _getcwd()
// put global magic to initialise i18n before all the other global variables calling gettext()
namespace _yama {

#define GETTEXT_DOMAIN EU_CleanSky_Physique
#define CPPSTR(x) #x
#define XCPPSTR(x) CPPSTR(x)
#define _(String) dgettext ( XCPPSTR(GETTEXT_DOMAIN) , String )

	class I18nInit {
	public:
		// constructeur
		I18nInit(void) {
			// Idéalement je dois trouver argv[0] et reconstruire son répertoire absolu.
			// BUG: Le programme a pu être lancé depuis un autre dossier...
			char buffer[2048];
			char * retval = _getcwd(buffer,sizeof(buffer));
			assert( retval != 0 );
			bindtextdomain( XCPPSTR(GETTEXT_DOMAIN) , buffer); // les messages du domaine "EU_CleanSky_Physique" sont dans le répertoire courant
			bind_textdomain_codeset( XCPPSTR(GETTEXT_DOMAIN) , "UTF-8"); // translation of messages to UTF-8 by gettext() 
			// textdomain(XCPPSTR(GETTEXT_DOMAIN)); // on est dans ce domaine, mais inutile avec dgettext
		};
		friend class DoI18nInit;
	};
	I18nInit i18nInit;
}; // end namespace _yama

// Création du template de messages
// L:\WRK\dev\Gettext\bin\xgettext.exe -L C++ -d EU_CleanSky_Physique --from-code=UTF-8 --keyword=_ Physique.cc Physique.hxx
// Initialisation d'un fichier de traduction dans la locale de l'utilisateur
// L:\WRK\dev\Gettext\bin\msginit.exe -i EU_CleanSky_Physique.po
// Création du catalogue .mo
// L:\WRK\dev\Gettext\bin\msgfmt.exe -v --check fr.po 

// Nouvelle version en template metaprogrammé, pour permettre au
// compilateur C++ de distinguer deux unités par leur type. C'est
// utile dans le cas où la même fonction est surchargée avec comme
// seule différence l'unité de l'argument.

// Faire des variables statiques déclarées dans ce fichier des fortes priorités
// pour l'initialisation: la technique consistant à déclarer ces variables statiques
// dans des fonctions est exploitée. Cette approche garantit l'initialisation avant
// la première exécution de la fonction. L'accès se fait par un appel de fonction qui
// retourne une référence à l'objet statique interne. La durée de vie est celle du
// programme (ou de l'overlay si la fonction fait partie d'une librairie dynamique
// susceptible d'être déchargée).

// 2015 Implémentation correcte des locales. L'utilisateur doit configurer les flux
// dans la locale souhaitée, selon qu'il veuille produire un fichier portable ou faire
// des entrées sorties destinées aux utilisateurs. L'exemple dans main travaille dans
// la locale courante en sortie, mais en locale "C" en entrée à partir de chaînes
// codées dans le code source en unicode UTF-8.

//======================================================================
// Désactive les warnings causés par l'utilisation d'init_seg(lib).
#pragma warning( disable : 4073 )
#pragma init_seg(lib)
// disable warning for explicit throw(x) declaration
#pragma warning(disable : 4290)

// Très haute priorité car nécessaires pour les calculs sur les unités, et
// donc l'initialisation des unités globales.
// Définir les variables globales uniquement ici.
#define UNITE_SI(dim,nom,abbrev) \
  template<>								\
  const Unite<_yama_metaprog::Unite ## dim> Unite<_yama_metaprog::Unite ## dim>::unite_si PRIORITY (nom,abbrev)

// If 'extern template' is not supported by the compiler, some template instanciations
// have already been made in the header file.
#ifndef SKIP_HXX_TEMPLATES
  UNITE_SI(Adimensionnee,_("nondimensional"),""  );
  UNITE_SI(Masse,        _("kilogram"),  _("kg")); 
  UNITE_SI(Longueur,     _("meter"),       _("m") );
  UNITE_SI(Temps,        _("second"),     _("s") );
  UNITE_SI(Intensite,    _("Ampere"),      _("A") );
  UNITE_SI(Temperature,  _("Kelvin"),      _("K") );
  UNITE_SI(Luminosite,   _("candela"),     _("cd"));
  // UNITE_SI(Angle,        _("radian"),      _("r") ); // la ratio du périmetre [m] d'un cercle à son rayon [m] est 2.pi radians [m/m=1]
  // UNITE_SI(AngleSolide,  _("steradian"),   _("sr")); // idem, adimensionné dans les équations
  UNITE_SI(Monetaire,    _("US dollar"),   _("$") );
  UNITE_SI(Homme,        _("person"),       _("p") );
#endif
#undef UNITE_SI

namespace _yama_metaprog {

  // Liste des unités
  // Les unités créées temporairement lors de calculs ne sont pas
  // insérées dans la liste. Seul les constructeurs d'unités nommées
  // enregistrent les unités dans la liste. Le constructeur de copie,
  // qui crée des "unités sans nom", ne le fait pas. Lors de calculs,
  // toutes les unités sont créées par copie ce qui fait que la gestion
  // de cette liste n'a pas d'impact sur les performances.
  // et les unités nommées 
  Unite_info * Unite_info::liste=0;
  Unite_info * Unite_info::parse=0;
  Unite_info * Unite_info::oldliste=0;

  unsigned Unite_info::longueurMax(0);

  // i18n: même si ces préfixes sont universels, le jeu de caractères peut varier.
  // Par exemple gigaoctet devient гигабайт en russe.
  const Unite_info::Prefixe Unite_info::prefixes[] = {
    {"Y", _("yotta"), 24},
    {"Z", _("zetta"), 21},  
    {"E", _("exa"),   18},  
    {"P", _("peta"),  15},  
    {"T", _("tera"),  12},  
    {"G", _("giga"),  9},   
    {"M", _("mega"),  6},   
    {"k", _("kilo"),  3},   
    {"h", _("hecto"), 2},   
    {"da",_("deca"),  1},   // doit être devant deci
    {"d", _("deci"), -1},   
    {"c", _("centi"),-2},   
    {"m", _("milli"),-3},   
    {"u", _("micro"),-6},   
    {"µ", _("micro"),-6},   
    {"n", _("nano"), -9},   
    {"p", _("pico"), -12},
    {"f", _("femto"),-15},
    {"a", _("atto"), -18},
    {"z", _("zepto"),-21},
    {"y", _("yocto"),-24},
  };

  void Unite_info::creeListeParseur(void) 
  {
	  // Extrait de la liste "liste" les unités qui ne sont pas préfixées
	  // pour utilisation ultérieure par le parseur.
	  // Une unité préfixée est une unité qui commence par l'un
	  // des préfixes connus, et dont le suffixe est identique à une unité
	  // de même dimension. La majuscule sur les noms propres saute sur
	  // les noms d'unités préfixés. 
	  // Le test est fait sur le nom et sur l'abbréviation.
	  // Les combinaisons (ex. m/s) sont eliminées d'emblée.

	  const std::locale locale(""); // travailler dans la locale utilisateur

	  // Détruire la liste parse existante, qui contient des copies des unités
	  Unite_info * l = liste; //TODO THREAD SAFETY GLOBAL liste
	  parse = NULL;
	  for(; l!=NULL; l = l->suivante) {
		  l->suivparse = NULL;
	  };

	  l = liste;
	  Unite_info ** p = &parse;
	  for(; l!=NULL; l = l->suivante) {
		  // saute les adimensionnés sans abbréviation
		  if(l->abbrev.empty()) continue; // adimensionné ou indéfini.
		  // regarde si l->abbrev est une combinaison
		  // présence d'un / , d'un . ou d'un chiffre
		  // Translators: Be careful translating the following message. Most
		  // computer users around the world can, and prefer to use latin numbers.
		  // The most prevalent exception is arabic numbers. In most non-ASCII
		  // translations some of the standard unicode exponent characters exist.
		  // They should be accepted when they exist in the locale. They are :
		  // \x2070	⁰	\x0660	\x06F0	۰
		  // \xB9	¹	\x0661	\x06F1	۱
		  // \xB2	²	\x0662	\x06F2	۲
		  // \xB3	³	\x0663	\x06F3	۳
		  // \x2074	⁴	\x0664	\x06F4	۴
		  // \x2075	⁵	\x0665	\x06F5	۵
		  // \x2076	⁶	\x0666	\x06F6	۶
		  // \x2077	⁷	\x0667	\x06F7	۷
		  // \x2078	⁸	\x0668	\x06F8	۸
		  // \x2079	⁹	\x0669	\x06F9	۹
		  // \x207A ⁺	\x066A	٪ (percent sign)
		  // \x207B ⁻	\x066B	٫ (decimal separator) \x066C	٬ (thousands separator)
		  // \x2212 − (minus sign)
		  if(l->abbrev.find_first_of(_("/.0123456789")) != std::string::npos) continue;
		  // regarde si l->nom commence par un prefixe connu
		  // NOTE: il ne peut pas y avoir plusieurs solutions car les
		  // préfixes sont tous différents, à l'exception de 'deci' et
		  // 'deca', mais dans ce cas le nom lève l'ambiguïté des abbreviations.
		  unsigned i;
		  for(i=0; i<sizeof(prefixes)/sizeof(Prefixe); i++) 
			  if(l->nom.compare(0, strlen(prefixes[i].nom), prefixes[i].nom)==0
				  && l->abbrev.compare(0,strlen(prefixes[i].abbrev), 
				  prefixes[i].abbrev)==0) break;// trouvé préfixe
		  const char * nprefixe = "";
		  const char * aprefixe = "";
		  if(i < sizeof(prefixes)/sizeof(Prefixe)) {
			  nprefixe = prefixes[i].nom;
			  aprefixe = prefixes[i].abbrev;
		  }
		  // tester si le nom est plus long que le préfixe
		  // eliminer le préfixe
		  const std::string nbuffer(l->nom,strlen(nprefixe));
		  const std::string abuffer(l->abbrev,strlen(aprefixe));
		  // rechercher dans liste une unité dont le nom correspond à l sans
		  // le prefixe
		  const Unite_info * base = liste;
		  for(; base != NULL; base = base->suivante) {
			  if( base == l ) continue; // sauter l
			  if(nbuffer.compare(1,std::string::npos, 
				  base->nom, 1, std::string::npos) != 0
				  || abuffer.compare(base->abbrev) != 0
				  || std::tolower(base->nom[0],locale) != std::tolower(nbuffer[0],locale)) continue;
			  // vérifier les dimensions
			  if(!l->isCompat(*base)) continue;
			  // on a trouvé
			  break;
		  }
		  if(base != NULL) continue; // l est rejetée

		  // on n'a pas trouvé : insérer l dans parse, en queue de liste
		  *p = l;
		  p = &l->suivparse;
		  *p = NULL;
	  } // boucle extérieure sur les unités (variable l)
  }

  const Unite_info*
	  Unite_info::rechercher(const Unite_info& u) const
  {
	  Unite_info * l = liste;
	  for(;l!=NULL;l=l->suivante)
		  if(l->facteur == facteur && l->biais == biais && 
			  l->getVecteur() == getVecteur())
			  return l;
	  return 0;
  }

  void
	  Unite_info::enregistrer(void) 
  {
	  // N'enregistre que les unités nommées
	  if(nom.empty()) {
		  suivante = NULL;
		  suivparse = NULL;
		  return;
	  }
	  // Recherche une unité identique dans les listes
	  // L'abbrev doit être identique
	  Unite_info * u = liste;
	  for(;u!=NULL;u=u->suivante)
		  if(u->facteur == facteur && u->biais == biais && 
			  u->abbrev == abbrev && u->getVecteur() == getVecteur() )
			  return;
	  // insère l'unité dans les listes
	  suivante = liste;
	  liste = this;
	  // ajuster longueurMax le cas échéant
	  unsigned l = nom.length();
	  if(l > longueurMax) longueurMax = l;
	  suivparse = NULL;
  }

  // Destructeur virtuel
  Unite_info::~Unite_info(void)
  {
	  // pas de recherche si l'unité est anonyme
	  if(nom.empty()) return;
	  // sinon l'extraire de la liste du parseur
	  Unite_info **l = &parse; // ref to pointer
	  for(;*l!=NULL;l=&((*l)->suivparse)) {
		  if(*l == this) {
			  *l = suivparse;
			  suivparse = NULL;
			  break;
		  }
	  }
	  assert(suivparse == NULL);
	  // et l'extraire de la liste générale
	  l = &liste;
	  for(;*l!=NULL;l=&((*l)->suivante)) {
		  if(*l == this) {
			  *l = suivante;
			  suivante = NULL;
			  break;
		  }
	  }
	  assert(suivante == NULL);
  }

  // constructeur par défaut rendu privé et désactivé
  Unite_info::Unite_info(void)
	  : facteur(1.0), biais(0.0), 
	  biais_fois_facteur(0.0), invFacteur(1.0), oppBiais(0.0)
  {
	  std::cerr << _("Attempt to use defaut constructor of class Unite") << std::endl;
	  throw std::logic_error(_("bug"));
  }
  // constructeur de copie désactivé
  Unite_info::Unite_info(const Unite_info& b)
	  : facteur(1.0), biais(0.0), 
	  biais_fois_facteur(0.0), invFacteur(1.0), oppBiais(0.0)
  {
	  std::cerr << _("Attempt to use defaut constructor of class Unite") << std::endl;
	  throw std::logic_error(_("bug"));
  }
  // constructeur général (iFacteur et iBiais sont optionnels)
  Unite_info::Unite_info(const char * iNom, const char * iAbbrev, 
	  double iFacteur, double iBiais)
	  throw(std::invalid_argument)
	  : nom(iNom), abbrev(iAbbrev), facteur(iFacteur), biais(iBiais),
	  biais_fois_facteur(facteur*biais),
	  invFacteur((facteur!=0) ? (1.0/facteur) : 1.0),
	  oppBiais(-biais)
  {
	  if(facteur == 0) 
		  throw std::invalid_argument(_("The proportionality factor of a unit shall never be zero"));
	  //enregistrer();
  }
  // variante du ctor général avec des std::string
  Unite_info::Unite_info(const string iNom, const string iAbbrev, 
	  double iFacteur, double iBiais)
	  throw(std::invalid_argument)
	  : nom(iNom), abbrev(iAbbrev), facteur(iFacteur), biais(iBiais),
	  biais_fois_facteur(facteur*biais),
	  invFacteur((facteur!=0) ? (1.0/facteur) : 1.0),
	  oppBiais(-biais)
  {
	  if(facteur == 0) 
		  throw std::invalid_argument(_("The proportionality factor of a unit shall never be zero"));
	  //enregistrer();
  }

  Unite_info::Unite_info(const char * iNom, const char * iAbbrev,
	  double val, const Unite_info& u, double iBiais)
	  throw(std::invalid_argument)
	  : nom(iNom), abbrev(iAbbrev), facteur(val*u.facteur), 
	  biais((facteur != 0) ? (u.std(iBiais)/facteur) : 0.0),
	  biais_fois_facteur(facteur*biais),
	  invFacteur((facteur!=0) ? (1.0/facteur) : 1.0),
	  oppBiais(-biais)
  {
	  // Dans un cas particulier qui se rencontre à la construction des unités,
	  // facteur peut être nul à ce stade. Cela est corrigé dans le constructeur
	  // de Unite<>.
	  // Ce cas apparaît quand le code évalue un produit ou un quotient d'unités
	  // qui donne pour la première fois une nouvelle dimension.
	  if(val == 0)
		  throw std::invalid_argument(_("Multiplication factor 'val' shall not be zero"));
	  //enregistrer();
  }
  // variante du ctor général avec des std::string
  Unite_info::Unite_info(const std::string iNom, const std::string iAbbrev,
	  double val, const Unite_info& u, double iBiais)
	  throw(std::invalid_argument)
	  : nom(iNom), abbrev(iAbbrev), facteur(val*u.facteur), 
	  biais((facteur != 0) ? (u.std(iBiais)/facteur) : 0.0),
	  biais_fois_facteur(facteur*biais),
	  invFacteur((facteur!=0) ? (1.0/facteur) : 1.0),
	  oppBiais(-biais)
  {
	  // Dans un cas particulier qui se rencontre à la construction des unités,
	  // facteur peut être nul à ce stade. Cela est corrigé dans le constructeur
	  // de Unite<>.
	  // Ce cas apparaît quand le code évalue un produit ou un quotient d'unités
	  // qui donne pour la première fois une nouvelle dimension.
	  if(val == 0)
		  throw std::invalid_argument(_("Multiplication factor 'val' shall not be zero"));
	  //enregistrer();
  }

  Unite_info::Unite_info(const char * iNom, const char * iAbbrev,
	  const Unite_info& u)
	  throw()
	  : nom(iNom), abbrev(iAbbrev), 
	  facteur(u.facteur), biais(u.biais),
	  biais_fois_facteur(u.biais_fois_facteur),
	  invFacteur(u.invFacteur),
	  oppBiais(u.oppBiais)
  {
	  //enregistrer();
  }

  Unite_info::Unite_info(const std::string iNom, const std::string iAbbrev,
	  const Unite_info& u)
	  throw()
	  : nom(iNom), abbrev(iAbbrev), 
	  facteur(u.facteur), biais(u.biais),
	  biais_fois_facteur(u.biais_fois_facteur),
	  invFacteur(u.invFacteur),
	  oppBiais(u.oppBiais)
  {
	  //enregistrer();
  }

  // Liste de toutes les unités connues du parseur
  // Si elem est vrai, ne lister que les unités élémentaires en
  // éliminant les unités composées et les changements de puissance de dix.
  void
	  Unite_info::lister(std::wostream& out, bool elem)
  {
	  const Unite_info * l;
	  if(elem) {
		  if(oldliste != liste) {
			  // recréer la liste parse
			  creeListeParseur();
			  oldliste = liste;
		  }
		  l = parse;
	  } else l = liste;

	  while(l != NULL) {
		  double val = l->std(1.0);
		  std::wostringstream buffer;
		  buffer << L'(' << l->getNomw() << L')';
		  out << std::setiosflags(std::ios::left) << std::setw(7) << l->getAbbrevw();
		  out << std::setiosflags(std::ios::left) << std::setw(longueurMax+3) 
			  << buffer.str();
		  out << std::setprecision(8) << val << "_" << l->base().getNomStandardw() 
			  << std::endl;
		  if(elem)
			  l = l->suivparse;
		  else
			  l = l->suivante;
	  }
  }

}; // fin du namespace _yama_metaprog


// Lecture d'un flux
// Le flux ne peut pas contenir une unité dont la dimension soit
// inconnue de l'application, mais il peut utiliser pour l'exprimer
// une combinaison d'unités élémentaires différente de toutes les
// expressions utilisées dans l'application. On ne peut donc pas
// espérer calculer le produit ou le quotient d'unités tel quel.
//
// Le seul moyen restant consiste à compter les exposants. Pour ce
// faire, on utilise une méthode virtuelle capable de renvoyer les
// dimensions sous forme de vecteur.
//
// Utilisation interdite dans un constructeur de classe dérivée d'Unite_info,
// car utilise des méthodes virtuelles.
//
// Les unités ne sont pas toutes compatibles ASCII, par exemple ° a un
// code supérieur à 127, et il s'exprime même 0xC2 0xA0 en UTF-8. En
// lisant un istream on récupère les octets un à un et ce ne sont pas
// toujours des caractères valides. Typiquement isalpha(0xC2) déclenche 
// un "assert" en locale "C". Il est donc important de bien interpréter
// le flux en utilisant sa locale.
std::istream& operator>>(std::istream& in, _yama_metaprog::Unite_info& u)
{
	using _yama_metaprog::Unite_info;
	const std::locale& locale = in.getloc(); // locale du flux

	// Etat initial de l'unité décodée
	Unite_info::Vecteur dimension;
	// initialisé à zéro par constructeur

	u.facteur = 1.0;
	u.biais   = 0.0;
	u.nom.resize(0);
	u.abbrev.resize(0);
	// y a-t-il une unité ?
	if(in.bad()) goto error;
	int sep = in.peek(); // renvoie un char_type selon la définition de in, ici un 'char'.
	if(in.bad()) goto error;
	if(std::string(_(" _")).find(static_cast<char>(sep)) == std::string::npos) return in; // suppose SI, déjà initialisé

	if(u.oldliste != u.liste) {
		// recréer la liste parse
		u.creeListeParseur();
		u.oldliste = u.liste;
	}

	bool vufrac = false;
	bool uniteIni = false;

	if(in.good()) {
		char c;
		in.get(c); // TODO : les caractères d'espace multibyte comme \xC2\xA0 l'espace insécable
		// si c n'est pas un blanc ou _ , le remettre dans le flux.
		// Translator: Beware! This short string may need to be translated
		// to include locale specific relevant white space characters like \xA0.
		if(std::string(_(" _")).find(c) == std::string::npos) {
			in.putback(c);
			return in;
		}
	}
#if 0
	if(in.good()) {
		char c;
		in.get(c);
		in.putback(c);
		// une unité doit commencer par une lettre, %,‰,₥,٪ un symbole 
		// monétaire $,¢,€,¥,£,₡,₢,₣,₦,₧,₨,₩,₪,₫,₭,₮,₱,₲,₳,₴,₵,﷼ ou le symbole °,Ω,℃,℉
		// permet de lire des tableaux de chiffres sans unités (présumées SI)
		// BUG: ne lit pas correctement un caractère multibyte comme \xC2\xB0 °
		if(!std::isalpha(c,locale)) {
			return in;
		}
	}
#endif
	if(in.good()) {
		char c;
		in.get(c);
		in.putback(c);
		// une unité ne doit pas commencer par un chiffre
		if(std::isdigit(c,locale)) {
			return in;
		}
	}
	do {
		std::string buffer;
		buffer.reserve(250); // pré-allocation pour qu'append aille vite.
		// ensuite on lit 
		while(in.good()) {
			char c;
			in.get(c);
			if(in.eof()) break; // good est vrai avec eof tant qu'on ne lit pas.
			// Translator beware ! The string below might need translation in some
			// locales which define interesting unicode code points:
			// \x2215 (∕)	\xF7 (÷)	\xD7 (×)	\x22C5 (⋅)
			if(std::string(_("./ \t\n")).find(c) != std::string::npos) {
				in.putback(c);
				break;
			}
			buffer+=c; // ajoute le caractère à la fin.
		}
		u.abbrev.append(buffer); // stocke l'abbreviation
		int l=buffer.length() - 1; 
		while(l>0) {
			int exposant;
			if(vufrac) exposant = -1;
			else exposant = 1;
			//cerr << ">" << buffer << "< " << l;
			if(std::isdigit(buffer[l],locale)) {
				// extraire un exposant en partant de la fin
				// NOTE: boucle inutile car -8 <= exposants <= 7, donc un seul chiffre
				std::istringstream(buffer.substr(l,buffer.length()-l)) >> exposant;
				buffer.resize(l); // truncate string.
				if(vufrac) exposant = -exposant;
			} else l++;
			//cerr << " : exposant " << exposant ;
			// extraire une abbreviation d'unité
			const Unite_info * n = NULL; // n parcourt la liste d'analyse
			const Unite_info *n1 = NULL, *n2 = NULL;
			unsigned i1, l1 = 0;
			for(n = u.parse; n != NULL; n = n->suivparse) {
				int nl = n->getAbbrev().length();
				if(nl > l) continue; // longueur d'unité > longueur de buffer
				// l'unité correspond à la fin de buffer
				if(buffer.compare(l-nl,nl,n->abbrev)==0) {
					// vérifier le prefixe d'unité
					unsigned i;
					const Unite_info::Prefixe * p = u.prefixes; // p parcourt les préfixes
					for(i = 0; 
						i < sizeof(Unite_info::prefixes)/sizeof(Unite_info::Prefixe);
						i++, p++) {
							int pl = strlen(p->abbrev);
							if(pl+nl > l) continue; // longueur totale > longueur de buffer
							// correspondance entre buffer et prefixe + unité courante
							if(buffer.compare(l-nl-pl, pl, p->abbrev)==0) break;
					}
					unsigned ll=0;
					// ll = longueur préfixe éventuel + longueur abbrev n.
					if(i < sizeof(Unite_info::prefixes)/sizeof(Unite_info::Prefixe)) 
						ll = strlen(u.prefixes[i].abbrev);
					ll += n->abbrev.length();
					// heuristiques: on stocke le meilleur résultat dans n1.
					// préfixe+unité de longueur l : 
					// première solution, n1==NULL, stockage inconditionnel, sinon
					// priorité à la plus longue chaîne
					// si égalité priorité au nom d'unité le plus long
					if( n1 == NULL || ll > l1 
						|| ( ll == l1 && n->abbrev.length() > n1->abbrev.length() ) ) {
							n1 = n;
							i1 = i;
							l1 = ll;
					} else if( n->abbrev.length() == n1->abbrev.length()) {
						// Tout est identique...
						if(n->getVecteur() == n1->getVecteur()) {
							// Afficher un avertissement pour la mise au point de la base
							// si jamais les dimensions sont identiques.
							// Méthode standard pour afficher des messages paramétrés traduits.
							const char fmt[] = "Ambiguous same dimension units %s and %s.";
							std::vector<char> buf;
							buf.resize(n->getNom().length()+n1->getNom().length()+sizeof(_(fmt)));
							SNPRINTF(&buf[0], buf.size(), _(fmt), n->getNom().c_str(), n1->getNom().c_str());
							std::string str = &buf[0];
							std::cerr << str << std::endl;
							// buf et str sont détruits
						}
						// Si les dimensions diffèrent, le problème est moindre. On ne
						// peut pas se servir de la dimension de u pour lever l'ambiguïté à
						// ce stade car même si u est une GrandeurPhysique dont la dimension
						// est imposée, l'unité peut être exprimée comme une combinaison
						// d'unités. On continue à analyser des fois que n1 soit remplacé.
						n2 = n;
						// TODO: construire un graphe des possibilités et faire les choix
						// plus tard.
					}
				}
			} // fin de boucle sur liste d'analyse
			if(n1 == NULL) goto error; // unité non reconnue
			// Diagnostic situation d'ambiguïté dans l'analyse
			if(n2 != NULL && 
				n1->abbrev.length() == n2->abbrev.length() &&
				n1->abbrev.compare(n2->abbrev)==0 ) {
					// Méthode standard pour afficher des messages paramétrés traduits.
					const std::string fmt("Ambiguous units %s and %s.");
					const std::string transl(_(fmt.c_str()));
					std::vector<char> buf;
					buf.resize(n1->getNom().length()+n2->getNom().length()+transl.length());
					SNPRINTF(&buf[0], buf.size(), transl.c_str(), n1->getNom().c_str(), n2->getNom().c_str());
					std::string str = &buf[0];
					std::cerr << str << std::endl;
					goto error; // ambiguïté
			}
			l -= n1->abbrev.length();
			buffer.resize(l); // truncate l.
			//cerr << " et unité " << n1->nom;
			// extraire un préfixe d'unité
			unsigned i;
			const Unite_info::Prefixe * p = u.prefixes;
			for(i = 0; 
				i < sizeof(Unite_info::prefixes)/sizeof(Unite_info::Prefixe);
				i++, p++) {
					int pl = strlen(p->abbrev);
					if(pl > l) continue;
					if(buffer.compare(l-pl, pl, p->abbrev)==0) break;
			}
			double ech=1.0;
			if(i < sizeof(Unite_info::prefixes)/sizeof(Unite_info::Prefixe)) {
				// trouvé un préfixe
				int val = p->valeur;
				for(; val > 0; val--) ech *= 10.0;
				for(; val < 0; val++) ech /= 10.0;
				l -= strlen(p->abbrev);
				buffer.resize(l); // truncate buffer
				//cerr << " et préfixe " << ech;
			} 
			//cerr << endl;
			l--;
			// gestion directe de la première unité trouvée car les produits
			// d'unités détruisent le biais.
			if(!uniteIni && exposant == 1) {
				dimension = n1->getVecteur();
				u.facteur = n1->facteur;
				u.biais   = n1->biais;
				if(ech != 1.0) {
					u.facteur *= ech;
					u.biais = n1->std(0.0)/u.facteur;
				}
			} else {
				u.biais  = 0.0;  // produit d'unites détruit le biais
				for(;exposant > 0;exposant--) {
					dimension = dimension + n1->getVecteur();
					u.facteur *= (n1->facteur * ech);
				}
				for(;exposant < 0;exposant++) {
					dimension = dimension - n1->getVecteur();
					u.facteur /= (n1->facteur * ech);
				}
			}
			uniteIni = true;
		} // boucler pour chercher une autre unité accolée
		// lire le caractère suivant
		char op;
		//cerr << "peek <" << (char)in.peek() << "> ";
		in.get(op);
		if(op==0 || in.eof()) break;
		//cerr << "op <" << op << "> ";
		//BUG: op pourrait être un caractère multibyte \x2215 (∕) par exemple
		if(op=='.') {
			u.abbrev.append(&op,1);
			continue;
		} else if(op=='/') {
			vufrac = true;
			u.abbrev.append(&op,1);
			continue;
		}
		in.putback(op);
		//cerr << "Putback char <" << op << ">" << endl;
		break;
	} while(!in.eof() && in.good());
	// facteur et biais sont positionnés
	u.oppBiais = -u.biais;
	u.biais_fois_facteur = u.biais*u.facteur;
	// facteur ne peut pas être nul dans un décodage d'unités
	// elles-mêmes valides, hors bug de cette librairie.
	if(u.facteur == 0.0) throw std::logic_error(_("bug"));
	u.invFacteur = 1.0/u.facteur;
	// en général, on lit une grandeur physique et l'unité n'est pas
	// mémorisée
	// Mémoriser la dimension
	try {
		u.setVecteur(dimension); // interdit dans ctor (pure virtual)
	}
	catch(std::invalid_argument) {
		// Impossible d'affecter cette dimension à u
	}
	// Valider la dimension
	if(!(u.getVecteur() == dimension)) {// interdit dans ctor (pure virtual)
error:
		in.setstate(std::ios::badbit); // peut envoyer une exception
	}
	return in;
}

// Lecture d'un flux. La dimension d'un UniteInfo pouvant changer, il faut 
// remettre à zéro la référence vers unite_si.
std::istream& operator>>(std::istream& in, _yama::UniteInfo& u) {
   // appel de la fonction précédente
  in >> static_cast<_yama_metaprog::Unite_info&>(u);
  if(u.unite_si != 0 && !(u.dimensions == u.unite_si->getVecteur()) ) 
    u.unite_si = 0;
  return in;
}

// Fonction générique qui utilise le vecteur stocké dimensions d'UniteInfo
std::string _yama::UniteInfo::nomStandard(void) const
{
  std::ostringstream snom; // commence par faire une chaîne en UTF-8 / ASCII via gettext()
  bool srest=false;
  // typeof(const_cast<Vecteur*>(&dimensions)->vecteur) v; // typeof est spécifique GCC
  typedef int vecteur_t[sizeof(dimensions.vecteur)];
  vecteur_t v;
  for(size_t i=0;i<sizeof(v)/sizeof(v[0]);i++) v[i] = dimensions.vecteur[i];
  // Exposant étant une constante, cette fonction est prodigieusement
  // raccourcie par l'optimiseur. En effet, toutes les conditions sont
  // connues à la compilation.
  if(v[0]>0) {
     snom << _("kg");
     if(v[0]>1) snom << v[0];
     srest=true;
   }
  if(v[1]>0) {
     if(srest) snom << ".";
     snom << _("m");
     if(v[1]>1) snom << v[1];
     srest=true;
   }
  if(v[2]>0) {
     if(srest) snom << ".";
     snom << _("s");
     if(v[2]>1) snom << v[2];
     srest=true;
  }
  if(v[3]>0) {
    if(srest) snom << ".";
    snom << _("A");
    if(v[3]>1) snom << v[3];
    srest=true;
  }
  if(v[4]>0) {
    if(srest) snom << ".";
    snom << _("K");
    if(v[4]>1) snom << v[4];
    srest=true;
  }
  if(v[5]>0) {
    if(srest) snom << ".";
    snom << _("cd");
    if(v[5]>1) snom << v[5];
    srest=true;
  }/*
  if(_rad_::Exposant>0) {
    if(srest) snom << ".";
    snom << _("r");
    if(_rad_::Exposant >1) snom << _rad_::Exposant ;
    srest=true;
  }
  if(_sr_::Exposant >0) {
    if(srest) snom << ".";
    snom << _("sr");
    if(_sr_::Exposant >1) snom << _sr_::Exposant ;
    srest=true;
    }*/
  if(v[6]>0) {
    if(srest) snom << ".";
    snom << _("$");
    if(v[6]>1) snom << v[6];
    srest=true;
  }
  if(v[7]>0) {
    if(srest) snom << ".";
    snom << _("p");
    if(v[7]>1) snom << v[7];
    srest=true;
  }

  std::ostringstream sden;

  bool drest=false;
  if(v[0]<0) {
    sden << _("kg");
    if(v[0]<-1) sden << -v[0];
    drest=true;
  }
  if(v[1]<0) {
    if(drest) sden << ".";
    sden << _("m");
    if(v[1]<-1) sden << -v[1];
    drest=true;
  }
  if(v[2]<0) {
    if(drest) sden << ".";
    sden << _("s");
    if(v[2]<-1) sden << -v[2];
    drest=true;
  }
  if(v[3]<0) {
    if(drest) sden << ".";
    sden << _("A");
    if(v[3]<-1) sden << -v[3];
    drest=true;
  }
  if(v[4]<0) {
    if(drest) sden << ".";
    sden << _("K");
    if(v[4]<-1) sden << -v[4];
    drest=true;
  }
  if(v[5]<0) {
    if(drest) sden << ".";
    sden << _("cd");
    if(v[5]<-1) sden << -v[5];
    drest=true;
  }/*
  if(_rad_::Exposant<0) {
    if(drest) sden << ".";
    sden << _("r");
    if(_rad_::Exposant <-1) sden << -_rad_::Exposant ;
    drest=true;
  }
  if(_sr_::Exposant <0) {
    if(drest) sden << ".";
    sden << _("sr");
    if(_sr_::Exposant <-1) sden << -_sr_::Exposant ;
    drest=true;
  }*/
  if(v[6]<0) {
    if(drest) sden << ".";
    sden << _("$");
    if(v[6]<-1) sden << -v[6];
    drest=true;
  }
  if(v[7]< 0) {
    if(drest) sden << ".";
    sden << _("p");
    if(v[7]<-1) sden << -v[7];
    drest=true;
  }
  if(drest) {
    if(srest) snom << _("/") << sden.str();
    else snom << _("1/") << sden.str();
  }

  return snom.str();
}
#ifdef _WINDOWS
std::wstring _yama::UniteInfo::nomStandardw(void) const {
	const std::string nom = nomStandard(); // récupère une chaîne encodée en UTF-8
	int sz = MultiByteToWideChar(CP_UTF8,0,nom.c_str(),-1,0,0);
	std::vector<wchar_t> wnom(sz+1,L'\0'); // initialiser à zéro
	sz = MultiByteToWideChar(CP_UTF8,0,nom.c_str(),-1,&wnom[0],sz+1);
	assert(sz != 0);
	return std::wstring(&wnom[0]);
}	
#endif
//======================================================================
// Bibliothèque d'unités prédéfinies

// Définition de 1 pour UniteInfo.
using _yama_metaprog::Unite_info;
using _yama::UniteInfo;
static const int vzero[]={0,0,0,0,0,0,0,0};
const UniteInfo UniteInfo::adim_si=UniteInfo(Vecteur(vzero));

// Accès aux types des dimensions de base S.I.
using _yama_metaprog::UniteAdimensionnee;
using _yama_metaprog::UniteMasse;
using _yama_metaprog::UniteLongueur;
using _yama_metaprog::UniteTemps;
using _yama_metaprog::UniteIntensite;
using _yama_metaprog::UniteTemperature;
using _yama_metaprog::UniteLuminosite;
// using _yama_metaprog::UniteAngle;
// using _yama_metaprog::UniteAngleSolide;
using _yama_metaprog::UniteMonetaire;
using _yama_metaprog::UniteHomme;
using _yama_metaprog::UniteSurface;
using _yama_metaprog::UniteVolume;
using _yama_metaprog::UniteTemps;
using _yama_metaprog::UniteFrequence;
using _yama_metaprog::UniteVitesse;
using _yama_metaprog::UniteAcceleration;
using _yama_metaprog::UniteDensite;
using _yama_metaprog::UniteForce;
using _yama_metaprog::UniteEnergie;
using _yama_metaprog::UnitePuissance;
using _yama_metaprog::UnitePression;
using _yama_metaprog::UniteCharge;
using _yama_metaprog::UniteTension;
using _yama_metaprog::UniteResistance;
using _yama_metaprog::UniteCapacitance;
using _yama_metaprog::UniteInductance;
using _yama_metaprog::UniteIntensiteMagnetique;
using _yama_metaprog::UniteFluxMagnetique;
using _yama_metaprog::UniteChampMagnetique;
using _yama_metaprog::UniteConductance;
using _yama_metaprog::UniteViscositeCinematique;
using _yama_metaprog::UniteViscositeDynamique;
using _yama_metaprog::UniteChampElectrique;
using _yama_metaprog::UniteChampLumineux;
using _yama_metaprog::UniteFluxLumineux;
using _yama_metaprog::UniteLuminosite;

// Définition des unités.
// Beaucoup de chaînes de caractères et quelques caractères non-ASCII.
// La plupart des éditeurs stockent le code source en UTF-8, mais ce 
// n'est pas garanti, sauf avec Emacs (où des commentaires structurés 
// permettent d'imposer le format de stockage). Aussi vaut-il mieux
// que le code source soit exclusivement en ASCII. Pour clarifier, cette
// nouvelle version de la librairie 
// Adimensionne, pourcentage, ...
const Unite<UniteAdimensionnee> &_1=Unite<UniteAdimensionnee>::unite_si(_("nondimensional"),"");
const Unite<UniteAdimensionnee> _pourcent PRIORITY (_("percent"),_("%"),0.01,_1),
  _dB       PRIORITY (_("decibel"),_("dB"),_1),
  _mol      PRIORITY (_("mole"),_("mol"),6.0221367e23,_1);

// Distance
const Unite<UniteLongueur> &_m=Unite<UniteLongueur>::unite_si(_("meter"),_("m"));
// How to ensure initialisation of _m before it is used to compute _m*_m or
// any other derived class? Put it in an initialisation function static unite_si().

const Unite<UniteLongueur> _km PRIORITY ("kilometer","km",1000.0,_m),
  _nm     PRIORITY (_("nautical mile"),_("NM"),1852.0,_m),
  _sm     PRIORITY (_("statute mile"),_("SM"),1609.34721869,_m),
  _mi     PRIORITY (_("international mile"),_("mi"),1609.344,_m),
  _mm     PRIORITY (_("millimeter"),_("mm"),0.001,_m),
  _in     PRIORITY (_("inch"),_("in"),0.0254,_m),
  _ft     PRIORITY (_("foot"),_("ft"),12.0,_in),
  _ua     PRIORITY (_("astronomical unit"),_("AU"),1.495979e11,_m),
  _ftUS   PRIORITY (_("Survey foot"),_("ftUS"),0.304800609601,_m),
  _lyr    PRIORITY (_("light year"),_("LYr"),9.46052840488e15,_m),
  _fath   PRIORITY (_("Fathom"),_("fath"),1.82880365761,_m),
  _chain  PRIORITY (_("chain"),_("chain"),20.1168402337,_m),
  _parsec PRIORITY (_("parsec"),_("pc"),3.08567818585e16,_m),
  _rod    PRIORITY (_("rod"),_("rd"),5.02921005842,_m),
  _yd     PRIORITY (_("yard"),_("yd"),0.9144,_m),
  _fermi  PRIORITY (_("Fermi"),_("fm"),1e-15,_m),
  _micron PRIORITY (_("micron"),_("u"),1e-6,_m),   // \xB5 µ is not ASCII
  _angstrom   PRIORITY (_("Angstrom"),_("AnU"),1e-10,_m),  // \xC5 Å \x212B is not ASCII (ångström)
  _mil    PRIORITY (_("mil"),_("mil"),1e-3,_in);

// Surface
const Unite<UniteSurface> _m2 PRIORITY (_("square meter"),_("m2"),_m*_m),
  _ft2  PRIORITY (_("square foot"),_("sqft"),_ft*_ft),
  _are  PRIORITY (_("are"),_("a"),100,_m2),
  _ha   PRIORITY (_("hectare"),_("ha"),10000,_m2),
  _acre PRIORITY (_("acre"),_("acre"),4046.87260987,_m2),
  _barn PRIORITY (_("barn"),_("b"),1e-28,_m2);

// Volume
const Unite<UniteVolume> _m3 PRIORITY (_("cubic meter"),_("m3"),_m*_m2),
  _l        PRIORITY (_("liter"),_("l"),0.001,_m3),
  _st       PRIORITY (_("stere"),_("st"),_m3),			// utilisé pour les tas de bois, avec les trous
  _ft3      PRIORITY (_("cubic foot"),_("ft3"),_ft*_ft2),
  _in3      PRIORITY (_("cubic inch"),_("in3"),_in.cube()),
  _gal      PRIORITY (_("US gallon"),_("gal"),3.785411784,_l),
  _galC     PRIORITY (_("Canada gallon"),_("galC"),4.54609,_l),
  _galUK    PRIORITY (_("UK gallon"),_("galUK"),4.546092,_l),
  _qt       PRIORITY (_("quart"),_("qt"),0.25,_gal),
  _bbl      PRIORITY (_("barrel"),_("bbl"),42,_gal),  // oil barrel, tonneau
  _regton	PRIORITY (_("Register tonnage"),_("rt"),100.0,_ft3),  // ships register tonnage, old
  _bu       PRIORITY (_("bushel US"),_("bu"),0.03523907,_m3),   // boisseau utilisé en cotation agricole US
  _fbm      PRIORITY (_("board foot"),_("fbm"),0.002359737216,_m3), // volume de bois scié 1 sqft x 1 in
  // cuisine
  _cup		PRIORITY (_("cup"),_("c"),2.365882365e-4,_m3), // tasse US
  _tbsp		PRIORITY (_("tablespoon"),_("tbsp"),1.47867647813e-5,_m3),
  _tsp		PRIORITY (_("teaspoon"),_("tsp"),4.92892159375e-6,_m3),
  _ozfl     PRIORITY (_("US fluid ounce"),_("ozfl"),2.95735295625e-5,_m3),
  _ozUK     PRIORITY (_("UK fluid ounce"),_("ozUK"),2.8413075e-5,_m3),
  _pk       PRIORITY (_("Peck"),_("pk"),8.8097675,_l), // vente de fruits et légumes, 2 dry gal
  _pt       PRIORITY (_("pint"),_("pt"),0.473176473,_l);

// Duree
const Unite<UniteTemps> &_s=Unite<UniteTemps>::unite_si(_("second"),_("s"));
const Unite<UniteTemps>	_min PRIORITY (_("minute"),_("min"),60,_s),
  _hr  PRIORITY (_("hour"),_("hr"),60,_min),
  _d  PRIORITY (_("day"),_("d"),24,_hr),
  _yr PRIORITY (_("year"),_("yr"),365.24219878125,_d);

// Frequence
const Unite<UniteFrequence> _Hz  PRIORITY (_("Hertz"),_("Hz"),_1/_s),
  _kHz PRIORITY (_("kilohertz"),_("kHz"),1000.0,_Hz),
  _MHz PRIORITY (_("megahertz"),_("MHz"),1000000.0,_Hz),
  _Bq  PRIORITY (_("Becquerel"),_("Bq"),_Hz),
  _Ci  PRIORITY (_("Curie"),_("Ci"),3.7e10,_Hz);

// Vitesse
const Unite<UniteVitesse> _m_s  PRIORITY (_("meter per second"),_("m/s"),_m/_s),
  _kt   PRIORITY (_("knot"),_("kt"),_nm/_hr),
  _km_h PRIORITY (_("kilometer per hour"),_("kph"),_km/_hr),
  _mph  PRIORITY (_("mile per hour"),_("mph"),_sm/_hr),
  _ft_s PRIORITY (_("foot per second"),_("ft/s"),_ft/_s),
  _c    PRIORITY (_("speed of light"),_("c"),299792458,_m_s);

// Acceleration
const Unite<UniteAcceleration> _G PRIORITY (_("G"),_("G"),9.80665,_m/(_s*_s)), // capital G to distinguish from gram
  _m_s2 PRIORITY (_("meter per second squared"),_("m/s2"),_m/(_s*_s));

// Masse
const Unite<UniteMasse> &_kg=Unite<UniteMasse>::unite_si(_("kilogram"),_("kg"));
const Unite<UniteMasse> _t PRIORITY (_("metric ton"),_("t"),1000.0,_kg),
  _lb    PRIORITY (_("pound"),_("lb"),0.45359237,_kg),
  _g     PRIORITY (_("gramme"),_("g"),0.001,_kg),
  _oz    PRIORITY (_("once"),_("oz"),0.028349523125,_kg),
  _slug  PRIORITY (_("slug"),_("slug"),_lb*_G*_s*_s/_ft), // approx 14.5939 kg
  _tonUS PRIORITY (_("ton US"),_("tonUS"),907.18474,_kg),
  _tonUK PRIORITY (_("ton UK"),_("tonUK"),1016.0469088,_kg),
  // pierres et métaux précieux
  _ct    PRIORITY (_("carat"),_("ct"),0.2,_g),
  _grain PRIORITY (_("grain"),_("grain"),0.06479891,_g),
  _ozt   PRIORITY (_("troy ounce"),_("ozt"),480,_grain),
  _lbt   PRIORITY (_("troy pound"),_("lbt"),12,_ozt),
  // atome
  _amu   PRIORITY (_("atomic mass unit"),_("amu"),1.66053892173e-27,_kg);

// Densité
const Unite<UniteDensite> _g_l PRIORITY (_("gram per liter"),_("g/l"),_g/_l),
  _kg_m3 PRIORITY (_("kilogram per cubic meter"),_("kg/m3"),_kg/_m3);

// Force
const Unite<UniteForce> _N PRIORITY ("Newton","N",_kg*_m_s2),
  _kgf PRIORITY (_("kilogram-force"),_("kgf"),_kg*_G),
  _gf  PRIORITY (_("gram-force"),_("gf"),_g*_G),
  _tf  PRIORITY (_("ton-force"),_("tf"),_t*_G),
  _lbf PRIORITY (_("pound-force"),_("lbf"),_lb*_G),
  _dyn PRIORITY (_("dyne"),_("dyn"),1e-5,_N),
  _kip PRIORITY (_("kilopound-force"),_("kip"),1000,_lbf),
  _pdl PRIORITY (_("poundal"),_("pdl"),0.138254954376,_N);

// Energie
const Unite<UniteEnergie> _J PRIORITY (_("Joule"),_("J"),_N*_m),
  _kJ    PRIORITY (_("kilojoule"),_("kJ"),1000.0,_J),
  _cal   PRIORITY (_("calorie"),_("cal"),4.1868,_J),
  _kcal  PRIORITY (_("kilocalorie"),_("kcal"),1000.0,_cal),
  _BTU   PRIORITY (_("british thermal unit"),_("BTU"),1055.05585262,_J),
  _erg   PRIORITY (_("erg"),_("erg"),1e-7,_J),
  _eV    PRIORITY (_("electron-volt"),_("eV"),1.60217653e-19,_J),
  _therm PRIORITY (_("thermie CEE"),_("thermie"),105506,_kJ);

// Puissance
const Unite<UnitePuissance> _W PRIORITY (_("Watt"),_("W"),_J/_s),
  _kW PRIORITY (_("kilowatt"),_("kW"),1000.0,_W),
  _MW PRIORITY (_("megawatt"),_("MW"),1000.0,_kW),
  _hp PRIORITY (_("horsepower"),_("hp"),745.699871582,_W),
  _cv PRIORITY (_("cheval-vapeur"),_("cv"),735.5,_W);

// Pression
const Unite<UnitePression> _Pa    PRIORITY (_("Pascal"),_("Pa"),_N/_m2),
  _hPa   PRIORITY (_("hectopascal"),_("hPa"),100.0,_Pa),
  _atm   PRIORITY (_("atmosphere"),_("atm"),1013.25,_hPa),
  _inHg  PRIORITY (_("inch of mercury"),_("inHg"),3386.38815789,_Pa),
  _psi   PRIORITY (_("pounds per square inch"),_("psi"),_lbf/(_in*_in)),
  _bar   PRIORITY (_("bar"),_("bar"),1000.0,_hPa),
  _mbar  PRIORITY (_("millibar"),_("mbar"),1.0,_hPa),
  _inH20 PRIORITY (_("inch of water"),_("inH20"),248.84,_Pa),
  _mmHg  PRIORITY (_("millimeter of mercury"),_("mmHg"),133.32236842086614173228,_Pa),
  _mmH2O PRIORITY (_("millimeter of water"),_("mmH2O"),9.79685039370078740157,_Pa),
  _torr  PRIORITY (_("Torr"),_("torr"),_mmHg);

// Temperature. le biais est utilise pour convertir des temperatures absolues
// Les traduction non ASCII utilisent °C, °F, °R pour la plupart...
const Unite<UniteTemperature> &_K=Unite<UniteTemperature>::unite_si(_("Kelvin"),_("K"));
const Unite<UniteTemperature> _dC PRIORITY (_("degree Celsius"),_("dC"),1.0,_K,273.15),
  _dF         PRIORITY (_("degree Fahrenheit"),_("dF"),0.55555555556,_dC,-17.77777778),
  _dR         PRIORITY (_("degree Rayleigh"),_("dR"),0.55555555556,_K);

// Electricite      kg m s A
const Unite<UniteIntensite> &_A=Unite<UniteIntensite>::unite_si(_("Ampere"),_("A"));
const Unite<UniteCharge> _C PRIORITY (_("Coulomb"),_("C"),_A*_s),
  _Fdy PRIORITY (_("Faraday"),_("Fdy"),1.60217653e-19,_mol*_C);//mole d'e-
const Unite<UniteTension> _V PRIORITY (_("Volt"),_("V"),_W/_A);
const Unite<UniteResistance>  _ohm PRIORITY (_("Ohm"),_("U"),_V/_A), // Symbole ASCII
// _ohm PRIORITY (_("Ohm"),_("Ω"),_V/_A),
  _kohm    PRIORITY (_("kiloohm"),_("kU"),1000.0,_ohm),
  _Mohm    PRIORITY (_("megohm"),_("MU"),1000.0,_kohm);
const Unite<UniteCapacitance> _F PRIORITY (_("Farad"),_("F"),_C/_V),
  _pF PRIORITY (_("picofarad"),_("pF"),1.0e-12,_F),
  _nF PRIORITY (_("nanofarad"),_("nF"),1.0e-9,_F),
  _uF PRIORITY (_("microfarad"),_("uF"),1.0e-6,_F),
  _mF PRIORITY (_("millifarad"),_("mF"),1.0e-3,_F);
const Unite<UniteInductance> _H PRIORITY (_("Henri"),_("H"),_J/(_A*_A)), // _ohm*_s
  _mH PRIORITY (_("millihenri"),_("mH"),0.001,_H);
const Unite<UniteFluxMagnetique> _Wb PRIORITY (_("Weber"),_("Wb"),_V*_s);
const Unite<UniteIntensiteMagnetique> _T PRIORITY (_("Tesla"),_("T"),_Wb/_m2),
  _mT PRIORITY (_("millitesla"),_("mT"),1.0e-3,_T);
const Unite<UniteConductance> _S PRIORITY (_("Siemens"),_("S"),_1/_ohm);

// Angles : rapports de longueurs (périmètre d'arc sur rayon)
// Angles solides : rapports de surfaces.
//const Unite<UniteAngle> &_r=Unite<UniteAngle>::unite_si(_("radian"),_("r"));  // les angles sont des ratios de longueurs donc sans dimension
//const Unite<UniteAngleSolide> &_A=Unite<UniteAngleSolide>::unite_si(_("steradian"),_("sr")); // la angles solides sont des ratios de surfaces
const Unite<UniteAdimensionnee> _r PRIORITY (_("radian"),_("r"),_1),
  _tr     PRIORITY (_("revolution"),_("tr"),6.28318530718,_r), // tour
  _deg  PRIORITY (_("degree"),_("deg"),1.0/360.0,_tr),   
  //_deg    PRIORITY (_("degree"),_("°"),1.0/360.0,_tr), // synonyme non ASCII
  _grad   PRIORITY (_("grade"),_("grad"),1.0/400.0,_tr),
  _arcmin PRIORITY (_("arc minute"),_("'"),1.0/60.0,_deg),
  _arcs   PRIORITY (_("arc second"),_("\""),1.0/60.0,_arcmin),
  _sr     PRIORITY (_("steradian"),_("sr"),_1);
const Unite<UniteFrequence> _rpm PRIORITY (_("revolution per min"),_("RPM"),_tr/_min);

// Viscosité
const Unite<UniteViscositeDynamique> _P PRIORITY (_("Poise"),_("P"),0.1,_kg/(_m*_s));
const Unite<UniteViscositeCinematique> _St PRIORITY (_("Stokes"),_("St"),
						     0.0001,_m2/_s);

#if 0
// Radioactivité
const Unite _Gy PRIORITY (_("Gray"),_("Gy"),_m2/(_s*_s));
const Unite _rad PRIORITY (_("rad"),_("rad"),0.01,_Gy);
const Unite _Sv PRIORITY (_("Sievert"),_("Sv"),_Gy);

const Unite _R PRIORITY (_("Roentgen"),_("R"),0.000258,_A*_s/_kg);
const Unite _rem PRIORITY (_("rem"),_("rem"),_rad);
#endif

// Illumination
const Unite<UniteLuminosite> &_cd=Unite<UniteLuminosite>::unite_si(_("candela"),_("cd")); //candela
const Unite<UniteChampLumineux> _lx PRIORITY (_("lux"),_("lx"),_m*_cd),
  _fc PRIORITY (_("foot-candle"),_("fc"),_lx*_m2/_ft2),   // 1 lumen par ft², environ 10,764 lux
  _ph PRIORITY (_("phot"),_("ph"),0.0001,_lx);
const Unite<UniteFluxLumineux>  _lm PRIORITY (_("lumen"),_("lm"),_lx*_m2);

// Divers
const Unite<UniteMasse>      _g_mol PRIORITY (_("gram per mole"),_("g/mol"),_g/_mol);
const Unite<UniteMonetaire>  &_USD=Unite<UniteMonetaire>::unite_si(_("US dollar"),_("$"));
const Unite<UniteHomme>      &_homme=Unite<UniteHomme>::unite_si(_("person"),_("p"));

#ifdef __Physique

int
main(int argc, char ** argv)
{
  using std::cout;
  using std::endl;
  using std::wcout;

  char * locName;

#ifdef _WINDOWS
  // On peut utiliser la page 850 (DOS) ou la page 1252 (Windows).
  // La console est capable des deux, mais attention: le symbole
  // degré ° est 0xF8 avec la CP850, et 0xB0 avec la CP1252.
  // Dans ce programme la CP1252 est utilisée.
  SetConsoleOutputCP(1252); 
#endif

  // Read output locale and console code page
  if(argc <= 1) {
	  // aucun paramètre, travaille en locale utilisateur par défaut
	  locName = "";
  } else if(argc >= 2){
	  // décode une locale pour les sorties, typiquement "C"
	  locName = argv[1];
#ifdef _WINDOWS
	  if(argc >= 3) {
		  // décode une page de codes
		  std::istringstream s1(argv[2]); 
		  unsigned short cp;
		  if(s1.good()) s1 >> cp;
		  if(s1.good()) SetConsoleOutputCP(cp);
	  }
#endif
  }
  // try to use user-supplied locale
  try {
	// configure wide output stream for data output.
	std::wcout.imbue(std::locale(locName));
	// configure narrow output stream for French text messages
	std::cout.imbue(std::locale("French_France.1252"));
	//std::locale::global(std::locale(""));
  }
  catch(const std::exception& e) {
    cout << "Probl" "\xe8" "me de locale pour afficher les degr" "\xe9" "s et accents" << endl;
    cout << "Exception localisation : " << e.what() << endl;
	std::wcout.imbue(std::locale("C")); // work in C locale
  }
  // On va commencer à utiliser la localisation sur wcout. Notez que l'accès au catalogue doit être automatisé
  // pour utilisation dans une librairie. On ne peut pas utiliser '.' dans le cadre d'une automatisation car
  // à chaque fois qu'il y aura un accès au catalogue de ce domaine, il sera recherché dans '.' que l'application
  // aura pu changer entre temps.
  char * codeset=bind_textdomain_codeset( XCPPSTR(GETTEXT_DOMAIN) , 0); // vérifier le codage des chaînes renvoyées par gettext() 
  try {
	cout << "Programme de test de la classe Physique n" "\xb0" "3" << endl << endl;
	cout << "R" "\xe9" "pertoire local : ";
	wcout << _wgetcwd( 0, 0) << endl;
	cout << argv[0] << endl;
	cout << "Locale : " << wcout.getloc().name().c_str() << endl;
	cout << "Internal message encoding : " << (codeset?codeset:"NULL") << endl;
#ifdef _WINDOWS
	cout << "Page de codes : " << GetConsoleOutputCP() << endl << endl;
#endif
    wcout << "1ft = " << Distance(1.0,_ft).conv(_m) << " " << _m << endl;
    wcout << "1m = " << Distance(1.0,_m).conv(_ft) << " " << _ft << endl;
    Distance d(Distance(1.0,_m)+Distance(1.0,_km));
    //Distance d1(0.0,_ft); // Afficher d1 convertit automatiquement en _ft
    //d1 = d; 
    // modif: les unités n'étant plus stockées dans la version 2
    // cette fonctionnalité n'existe plus. Seule la dimension est codée dans
    // le type et seule la valeur S.I. est stockée.
    wcout << "1m + 1km = " ;
	wcout << d ;
	wcout << " = " << d.conv(_ft) << " " << _ft << endl; 
    Temperature T(0.0,_dC);
    wcout << T ;  
	wcout << " = " << T.conv(_dF) << " " << _dF 
	 << " = " << T.conv(_K)  << " " << _K << endl;
    Masse m(10.0,_t);
    Acceleration a(1.0,_G);
//     Force f=m*a;
//     cout << "f=m.a  " << f << " = " << m << " * " << a << endl;
//     cout << "       " << f.conv(_lbf) << " " << _lbf 
// 	 << " = " << m.conv(_lb) << " " << _lb
// 	 << " * " << a.conv(_G) << " " << _G << endl;
    // cylindrées
    Volume O320(320,_in3);
    wcout << O320.conv(_in3) << " " << _in3 
	 << " = " << O320.conv(_l) << " " << _l << endl;
    // recherche de nom d'une unité anonyme
    wcout << _ft2 << " : " << (_ft*_ft) << " " << (_ft*_ft).getAbbrevw() << endl; 
    // affichage du nom standard (SI)
    wcout << _g_l << " : " << (_g/_l) << " " << (_g/_l).getAbbrevw() << endl;
    // unité barbare non SI
    wcout << "m/h : " << (_m/_hr) << " " << (_m/_hr).getAbbrevw() << endl;
    // lecture d'unités
    FluxMagnetique gp1(0.0,(_m3)*(_A.carre())*(_V)*(_s)/(_m3)/(_A.carre()));
	// data1 n'est pas de la même unité que gp1, or elles sont validées à la compilation
    const char *data1 = "-12.3456e-5_A2srkm3.MHz/s4\t  stream";
    std::istringstream s1(data1);
	s1.imbue(std::locale("C"));
    s1 >> gp1; // s1 devient 'bad'
    char buffer[10];
    s1.get(buffer, 10); // lire s1 sans sauter les blancs initiaux
    wcout << (s1.bad()?"\nERROR ":"") << data1  
	 << " = " << gp1 <<    buffer << endl;  // doit afficher ERROR, la chaîne, et la bonne valeur -1,23456e11 suivie de l'unité de gp1, à savoir kg.m2/s2.A
    // gp2 stocke des températures. La valeur initiale sera écrasée.
	Temperature gp2(0.0,_dF);
    const char data2[] = "0,0_" "\xb0" "C"; // degrés Celsius attention à la virgule en locale France. Comme °C n'est pas dans la base de données, il trouve Coulomb.
    std::istringstream s2(data2);
    s2.imbue(std::locale("French_France.1252"));
    s2 >> gp2;
    wcout << (s2.bad()?"\nERROR ":"") << data2 << " = " << gp2 << endl;
    Angle gp3(0.0,_r);
    const char *data3 = "90000_m" "\xb0"; // milli-degrés
    std::istringstream s3(data3);
    s3.imbue(std::locale("French_France.1252"));
    s3 >> gp3;
    wcout << (s3.bad()?"\nERROR ":"") << data3 << " = " << gp3 << endl;
    Frequence gp4;
    const char *data4 = "1 MHz";
    std::istringstream s4(data4);
    s4.imbue(std::locale("C"));
    s4 >> gp4;
    cout << (s4.bad()?"\nERROR ":"") << data4 << " = " << gp4 << endl;
    Surface gp5;
    const char *data5 = "550000 km2";
    std::istringstream s5(data5);
    s5.imbue(std::locale("C"));
    s5 >> gp5;
    wcout << (s5.bad()?"\nERROR ":"") << data5 << " = " << gp5 << endl;
    std::istringstream s6(data5);
    s6.imbue(std::locale("C"));
    double value;
    UniteInfo unite("externe","",_1); // dimension redéfinie à la lecture
    s6 >> value >> unite;
    wcout << (s6.bad()?"\nERROR ":"") << data5 << " = " << value << " " 
	 << unite.getAbbrevw() << " (" << unite.getNomw() << ")" << " = " 
	 << unite.std(value) << " " << unite.base().getAbbrevw() << endl;
    // Lecture depuis un flux
    const char * data="4 6.35677e+006_m\n"
		      "-304.8_m 219.15_K \n"
		      "7620_m 219.15_K \n";
    std::istringstream istr(data);
    istr.imbue(std::locale("C"));
    unsigned n;
    Rayon r;
    istr >> n;
    istr >> r;
    wcout << n << " " << r << endl;
    if(istr.bad()) cout << "Le flux est en erreur" << endl;
    if(istr.fail()) cout << "Perte d'int" "\xe9" "grit" "\xe9" " du flux" << endl;
    if(istr.eof()) cout << "Fin de fichier KO" << endl;
    Altitude alt;
    Temperature temp;
    do {
      if(istr.eof()) break;
      istr >> alt >> temp;
      wcout << alt << temp << endl;
    } while(istr.good());
    if(istr.bad()) cout << "Le flux est en erreur" << endl;
    if(istr.fail()) cout << "Perte d'int" "\xe9" "grit" "\xe9" " du flux" << endl;
    if(istr.eof()) cout << "Fin de fichier: OK" << endl;
    // Base de données d'unités
    //Unite_info::lister(cout, false);
    wcout << endl;
    // Tests complémentaires (couverture de tests à 100%)
    //gp1 = gp2; // assignation avec changement d'unité (ne compile pas)
    Unite<UniteInductance> _uH("microhenri","µH",1e-6,_H);
    _yama_metaprog::Unite_info::lister(wcout, true);
    Pourcentage pourcent(18);
    pourcent = 1;
    pourcent += -0.02;
    pourcent -= 0.8;
    pourcent *= 0.6;
    pourcent /= (1.0/1.4);
    Adimensionne adim(18);
    wcout << L"Pourcentage: " << pourcent.formatw(_pourcent) 
	 << L" Adimensionné: " << adim.formatw(_1) << endl;
    Capacitance C(10,_uF);
    Inductance H(1,_mH);
    // Unités rares
    typedef UniteLongueur::Ops<UniteMonetaire>::Ratio ut1;
    typedef ut1::Ops<UniteMonetaire>::Ratio ut2;
    typedef ut2::Ops<UniteTemps>::Ratio ut3;
    typedef ut3::Ops<UniteTemperature::Carre>::Ratio ut4;
    typedef ut4::Ops<UniteLuminosite::Cube>::Ratio UniteRare1;
    Unite<UniteRare1> rare1(_m*(_sr.carre().inv())*(_r.carre().inv())*
			   (_USD.carre().inv())/(_s*(_K.carre())*
						 (_cd.cube())));
    rare1.base();
    //rare1.nomStandard();
    typedef UniteHomme::Carre::Inv::Ops<UniteTemps>::Ratio UniteRare2;
    Unite<UniteRare2> rare2((_homme.carre().inv())/_s);
    rare2.nomStandard();
    wcout << rare1 << " " << rare2 << " " 
	 << (_m2/_cd) << " " 
	 << (_m/_r) << " "
	 << (_m/_sr) << " "
	 << (_m/_USD) << " "
	 << (_m/_homme) << endl;
    // provoquer l'exception
    C *= pourcent;
    C /= pourcent;
    C += C;
    C *= 2.0;
    C /= 1.6;
    //C += H;    ne compile pas (pas d'exception du coup...)
  }
  catch(const std::exception& e) {
    cout << "Exception homogénéïté : " << e.what() << endl;
  }  // Cette exception ne doit plus se produire : détecté à la compilation
  
  // Exceptions
  try { 
    Unite<UniteLongueur> _zarbi("Zarbi","Z",0,_m); 
  }
  catch(const std::exception& e) {
    cout << "Exception Unite::Unite nulle : " << e.what() << endl;
  }
  
//   try { 
//     Unite<UniteLongueur> _zarbi; 
//   }
//   catch(const std::exception& e) {
//     cout << "Exception Unite::Unite() : " << e.what() << endl;
//   } // ne compile pas : constructeur privé, comme dans l'ancienne version
  Unite<UniteAdimensionnee> _McDo("Hamburger","H",0.5,_1); // crée l'ambiguïté
  try {
    Inductance gp(0.0,_H);   // Henri
    const char *data = "100.0_cH"; // centiHamburgers
    std::istringstream s(data);
    s.imbue(std::locale("C"));
    s >> gp; // exception
  }
  catch(const std::exception& e) {
    cout << "Exception unité ambiguë : " << e.what() << endl;
  }
  Pression P(1,_atm);
  Intensite i(10,_A);
//   try {
//     P += i; // ne compile pas
//   }
//   catch(const std::exception& e) {
//     cout << "Exception homogénéïté : " << e.what() << endl;
//   }  // Cette exception ne se produit plus jamais à l'exécution
//   try { P *= i; }
//   catch(const std::exception& e) {
//     cout << "Exception homogénéïté : " << e.what() << endl;
//   }
//   try { P /= i; }
//   catch(const std::exception& e) {
//     cout << "Exception homogénéïté : " << e.what() << endl;
//   }
  std::cin.ignore(); // attendre avant de fermer la fenêtre
}

#endif
