// -*- coding: utf-8-dos; -*-
// (c)1997-1998 Jean-Marc Le Peuvedic
// (c)2009 Jean-Marc Le Peuvédic & Dassault Aviation _yama::UniteInfo class
// (c)2015 Jean-Marc Le Peuvédic & Dassault Aviation portage vers VisualC++ 2008
// Tous droits réservés
#ifndef _PHYSIQUE_H
#define _PHYSIQUE_H
// Version 2 : C++ with std namespace, uses on std::string externally.
// Version 3 : UniteInfo class allows processing of unknown units.

#include <string>
#include <stdexcept>
#include <cmath>       // inline math ops
#include <sstream>     // ostringstream for templates
#include <cassert>
#include <vector>
#ifdef _WINDOWS
#include <Windows.h>   // TODO supprimer la dépendance en déplaçant le code vers .cc
#endif

// Declaration de toutes les classes servant a stocker des grandeurs physiques.
// Ces classes rendent transparent l'emploi d'unites quelconques.

// 20151110 Compilation MSVC++ 2008
// suppression des définitions propres à GCC et inutiles avec MSVC++
#define __attribute__(x)
// MSVC implémente une recommandation d'ignorer les déclarations explicites de throw(x) dans
// les déclarations de fonctions et méthodes, et fait comme si n'importe quelle exception 
// pouvait remonter. Ne pas afficher le warning. Même si le code qui gère l'exception est
// générique, il est bon de pouvoir vérifier si les exceptions que je lève moi-même sont gérées.
// Ne pas supprimer cet avertissement hors de ce fichier
#pragma warning(push)
#pragma warning( disable : 4290 )
// attributs GCC n'existent pas dans MSVC, l'équivalent serait un pragma init_seg(lib), mais
// faire attention parce que lib ne détermine qu'une priorité par rapport au programme. 
#define PRIORITY __attribute__((__init_priority__(101)))
// La notation 'extern template' n'est supportée qu'à partir de VisualC++ 2010
// Pour les versions antérieures, laisser le linker se débrouiller avec les copies multiples.
#ifndef _GCC_
#define EXTERN_TEMPLATE template
#define SKIP_HXX_TEMPLATES 1
#else
#define EXTERN TEMPLATE extern template
#endif

// les exceptions sont débrayables dans MSVC++
#if !_HAS_EXCEPTIONS
#error Ce code utilise les exceptions C++
#endif

// Note:
// L'existence d'un parseur ne limite pas l'utilisation des templates
// pour les unites, car toutes les unites reconnues par le parseur
// doivent être définies dans la librairie Physique. Seuls les
// multiples ou les sous-multiples standard (miili~, kilo~) sont interprétés
// à la volée. On ne peut pas créer un type à l'exécution en C++, donc
// ces multiples et sous-multiples sont soit gérés automatiquement à
// l'affichage, soit perdus à l'affichage. Les multiples et
// sous-multiples communs peuvent être gérés en tant qu'unités
// distinctes.

// forward déclaration
namespace _yama_metaprog {
  class Unite_info;
};

// Lecture depuis un flux, déclaration d'une fonction friend.
// Appelle une fonction virtuelle et ne peut donc pas être appellée avant
// le corps d'un constructeur.
std::istream& operator>>(std::istream& in, _yama_metaprog::Unite_info& u);

// namespace privé _yama regroupant les définitions intermédiaires de
// templates pour les unités.
namespace _yama_metaprog {
  // Meta programmation:

  // Assertion statique
  // L'instantiation générique n'étant pas définie, elle échoue à la
  // compilation si le paramètre s'évalue à false
  template<bool> struct StaticAssert;
  template<> struct StaticAssert<true> {}; // structure vide

  // Une seule dimension _d_.
  template<int _d1_>
  class Dimension {
  public:
    enum {
      Exposant = _d1_
    };
  };
  // Le type de l'unité quel que soit la dimension...
  typedef Dimension<0> DimensionZero;

  // Métafonction qui calcule les types dont on a besoin
  // Le produit et le ratio sont capables d'élever à la puissance p/q
  template<class _d1_,class _d2_,int _p_,int _q_>
  class DimensionOp {
    // Attention: _p_/_q_ doit être entier!
    StaticAssert<((_d1_::Exposant+_d2_::Exposant)*_p_/_q_)*_q_==(_d1_::Exposant+_d2_::Exposant)*_p_> assert1;
  public:
    typedef Dimension<(_d1_::Exposant+_d2_::Exposant)*_p_/_q_> Produit;
    typedef Dimension<(_d1_::Exposant-_d2_::Exposant)*_p_/_q_> Ratio;
  };
  
  // Cette classe permet de vérifier dans une classe template que le
  // type qui paramètre le template à l'instanciation est bien une
  // classe dérivée de Unite_base_parent.
  class Unite_base_parent
  {
  public:
    typedef int test;
  };

  // Cette classe décrit par construction une unité S.I. Elle n'a en effet pas
  // la possibilité de stocker le biais et l'offset d'une unité non-S.I. Sa
  // particularité est de ne pratiquement pas avoir de code généré. Seules les
  // fonctions nomStandard et nomStandardw calculent à la volée une description
  // de l'unité à partir des unités de base kg, m, s, A, K, cd, USD et h.
  // Paramétrée par des classes Dimension<>
  template<class _kg_,class _m_,class _s_,class _A_,class _K_,class _cd_,
	   /*class _rad_,class _sr_,*/class _USD_,class _h_>
  class Unite_base : public Unite_base_parent {
  public:
    //----------------------------------------------------------------------
    // Métaprogrammes de calcul de types
    typedef _kg_  DimMasse;
    typedef _m_   DimLongueur;
    typedef _s_   DimTemps;
    typedef _A_   DimIntensite;
    typedef _K_   DimTemperature;
    typedef _cd_  DimLuminosite;
    //typedef _rad_ DimAngle;
    //typedef _sr_  DimAngleSolide;
    typedef _USD_ DimUniteMonetaire;
    typedef _h_   DimHomme;
    
    // Produit d'unités paramétré par l'unité du 2nd opérande
    template<class _u_>
    class Ops {
#define Ops(dim)					      \
      typedef typename DimensionOp<Dim ## dim,	              \
				   typename _u_::Dim ## dim,		\
				   1,1>::Produit Produit ## dim;	\
      typedef typename DimensionOp<Dim ## dim,				\
				   typename _u_::Dim ## dim,		\
				   1,1>::Ratio   Ratio ## dim
      Ops(Masse);
      Ops(Longueur);
      Ops(Temps);
      Ops(Intensite);
      Ops(Temperature);
      Ops(Luminosite);
//       Ops(Angle);
//       Ops(AngleSolide);
      Ops(UniteMonetaire);
      Ops(Homme);
#undef Ops
    public:
      // type produit de l'unité courante par _u_
      typedef
      Unite_base<typename Ops<_u_>::ProduitMasse,
		 typename Ops<_u_>::ProduitLongueur,
		 typename Ops<_u_>::ProduitTemps,
		 typename Ops<_u_>::ProduitIntensite,
		 typename Ops<_u_>::ProduitTemperature,
		 typename Ops<_u_>::ProduitLuminosite,
		 //typename Ops<_u_>::ProduitAngle,
		 //typename Ops<_u_>::ProduitAngleSolide,
		 typename Ops<_u_>::ProduitUniteMonetaire,
		 typename Ops<_u_>::ProduitHomme>        Produit;
      // type ratio de l'unité courante avec _u_
      typedef
      Unite_base<typename Ops<_u_>::RatioMasse,
		 typename Ops<_u_>::RatioLongueur,
		 typename Ops<_u_>::RatioTemps,
		 typename Ops<_u_>::RatioIntensite,
		 typename Ops<_u_>::RatioTemperature,
		 typename Ops<_u_>::RatioLuminosite,
// 		 typename Ops<_u_>::RatioAngle,
// 		 typename Ops<_u_>::RatioAngleSolide,
		 typename Ops<_u_>::RatioUniteMonetaire,
		 typename Ops<_u_>::RatioHomme>          Ratio;
    };

    // Elévation à la puissance paramétrée par un entier _p_
    template<int _p_,int _q_>
    class PuissOps {
#define PuissOps(dim)                                                  \
      typedef typename                                                 \
      DimensionOp<Dim ## dim,Dimension<0>,_p_,_q_>::Produit Puiss ## dim
    public:
      PuissOps(Masse);
      PuissOps(Longueur);
      PuissOps(Temps);
      PuissOps(Intensite);
      PuissOps(Temperature);
      PuissOps(Luminosite);
      //PuissOps(Angle);
      //PuissOps(AngleSolide);
      PuissOps(UniteMonetaire);
      PuissOps(Homme);
#undef PuissOps
    typedef 
    Unite_base<typename PuissOps<_p_,_q_>::PuissMasse,
	       typename PuissOps<_p_,_q_>::PuissLongueur,
	       typename PuissOps<_p_,_q_>::PuissTemps,
	       typename PuissOps<_p_,_q_>::PuissIntensite,
	       typename PuissOps<_p_,_q_>::PuissTemperature,
	       typename PuissOps<_p_,_q_>::PuissLuminosite,
	       //typename PuissOps<_p_,_q_>::PuissAngle,
	       //typename PuissOps<_p_,_q_>::PuissAngleSolide,
	       typename PuissOps<_p_,_q_>::PuissUniteMonetaire,
	       typename PuissOps<_p_,_q_>::PuissHomme>         Puissance;
    };
  public:
    // Type carré de l'unité, cube, inverse, racine carrée, racine cubique
    typedef typename PuissOps<2,1>::Puissance   Carre;
    typedef typename PuissOps<3,1>::Puissance   Cube;
    typedef typename PuissOps<-1,1>::Puissance  Inv;

    //----------------------------------------------------------------------
    // Opérations 

    // Produit de 2 unités.
    template<class _u_> 
    typename Ops<_u_>::Produit
    operator*(_u_ u) const
    {
      typename Ops<_u_>::Produit result;
      return result;
    }; // pas de calcul à faire. Le seul calcul est le type retourné
    
    // Ratio de 2 unités
    template<class _u_> 
    typename Ops<_u_>::Ratio
    operator/(_u_ u) const
    {
      typename Ops<_u_>::Ratio result;
      return result;
    }; // pas de calcul à faire. Le seul calcul est le type retourné

    // Elévation au carré d'une unité
    // Le paramètre du template est la classe à laquelle on applique
    // l'opération
    Carre carre(void) const
    {
      Carre result;
      return result;
    };
    // Elevation au cube d'une unité
    Cube cube(void) const
    {
      Cube result;
      return result;
    };
    // Nom de l'unité SI correspondant à ces dimensions (calculé)
    static std::string nomStandard(void);
#ifdef _WINDOWS
	static std::wstring nomStandardw(void);
#endif
  }; // end of template class Unite_base<>
  
  // Dans cette version de la librairie, GrandeurPhysique et Unite sont
  // deux classes dérivées de Unite_base, sans lien d'héritage entre
  // elles. Le constructeur d'une GrandeurPhysique accepte une Unite
  // comme argument. La dimension d'une GrandeurPhysique ou d'une Unite
  // est fixée une fois pour toutes par la variante d'Unite_base dont
  // elles dérivent. La valeur est toujours stockée en S.I. Il faut
  // disposer d'une GrandeurPhysique et d'une Unite compatibles pour
  // faire des entrées/sorties.

  // La classe de base publique Unite_base regroupe les données qui
  // existent dans chaque Unite mais sont liées au parseur, et traitées
  // de la même manière pour toutes les unités.

  // Attention, ne pas confondre avec la classe template
  // _yama_metaprog::Unite_base<> 
  class Unite_info {
  protected:
    typedef std::string string;
  private:
    // données statiques
    static Unite_info * liste;   // liste des différentes unités
    static Unite_info * parse;   // liste réduite utilisée par le parseur
    static Unite_info * oldliste;// liste lors de la création de parse
    static unsigned longueurMax; // longueur max des noms
    struct Prefixe {
      char * abbrev;
      char * nom;
      int  valeur;
    };
    static const Prefixe prefixes[];
    // méthodes statiques
    static void creeListeParseur(void);
  public:
    // lister les unités connues
    static void lister(std::wostream& out, bool elem=false);

  private:
    // données propre à chaque unité
    string nom;        // nom de cette unite
    string abbrev;     // abbreviation officielle de cette unité
  protected://TODO supprimer protected: ?
    double facteur;    // multiplier par ce facteur pour obtenir du S.I.
    double biais;      // utilisé pour les temperatures
    // optimisations
    double biais_fois_facteur; // optimisation
    double invFacteur; // multiplier une valeur S.I. par ce facteur
    double oppBiais;   // égal à -biais

  private:
    // constructeur par défaut désactivé
    Unite_info(void);
    // constructeur de copie désactivé
    Unite_info(const Unite_info&);

  protected:
    // Constructeurs
    // constructeur général
    Unite_info(const char * iNom, const char * iAbbrev, 
	       double iFacteur=1.0, double iBiais=0.0)
      throw(std::invalid_argument);
    // variante avec des std::string
    Unite_info(const string iNom, const string iAbbrev,
	       double iFacteur=1.0, double iBiais=0.0)
      throw(std::invalid_argument);
    // constructeur de multiple ou sous-multiple
    // le biais optionnel est exprimé en unités u
    Unite_info(const char * iNom, const char * iAbbrev,
	       double val, const Unite_info& u, double iBiais=0.0)
      throw(std::invalid_argument);
    // variante avec des std::string
    Unite_info(const std::string iNom, const std::string iAbbrev,
	       double val, const Unite_info& u, double iBiais=0.0)
      throw(std::invalid_argument);
    // constructeur à partir d'une unité transiente
    // construite par opérations entre unités
    Unite_info(const char * iNom, const char * iAbbrev,
	       const Unite_info& u)
      throw();
    // variante avec des std::string
     Unite_info(const std::string iNom, const std::string iAbbrev,
	       const Unite_info& u)
      throw();

  protected:
    // Enregistrement dans la liste des Unite_Info. Doit être appelée dans les 
    // constructeurs des classes concrètes dérivées si nécessaire.
    void enregistrer(void); // met this dans la liste
    // Recherche dans la liste une unité identique: dimension, facteur et biais.
    // Renvoie 0 en cas d'échèc.
    const Unite_info* rechercher(const Unite_info& u) const;

    // ces deux attributs sont modifiables meme sur une Unite const
    Unite_info * suivante; // liste statique des unités
    Unite_info * suivparse;// sous-liste des unités du parseur

  public:
    // Destructeur
    virtual ~Unite_info(void);

    // Obtenir le nom de l'unité
    operator const std::string(void) const   { return getNom();};

#ifdef _WINDOWS
	operator const std::wstring(void) const
	{
		// implementation avec vector<wchar_t>
		const std::string nom = getNom();
		int sz = MultiByteToWideChar(CP_UTF8,0,nom.c_str(),-1,0,0);
		std::vector<wchar_t> wnom(sz+1,L'\0'); // initialiser à zéro
		sz = MultiByteToWideChar(CP_UTF8,0,nom.c_str(),-1,&wnom[0],sz+1);
		if(sz != 0) return std::wstring(&wnom[0]);
		return getAbbrevw();
	};
#endif

    // Autres accesseurs
    const std::string getNom(void)  const 
    {
      if(!nom.empty()) return nom;
      return getAbbrev();
    };

#ifdef _WINDOWS
    const std::wstring getNomw(void)  const 
    {
      if(!nom.empty()) return static_cast<std::wstring>(*this);
      return getAbbrevw();
    };
#endif

	const std::string getAbbrev(void) const 
	{ 
		if(!abbrev.empty()) return abbrev;
		if(facteur == 1.0 && biais == 0.0) return getNomStandard();
		// Chercher dans la liste la même unité
		Unite_info * l = liste;
		for(;l!=NULL;l=l->suivante)
			if(l->facteur == facteur && l->biais == biais)
				return l->getAbbrev();
		return std::string("\xC2\xA4"); // ¤ Symbole monétaire en UTF-8... 
	};

#ifdef _WINDOWS
	const std::wstring getAbbrevw(void) const
    {
		// implementation avec vector<wchar_t>
		const std::string abbr = getAbbrev();
		int sz = MultiByteToWideChar(CP_UTF8,MB_ERR_INVALID_CHARS,abbr.c_str(),-1,0,0);
		std::vector<wchar_t> wabbr(sz+1,L'\0');
		sz = MultiByteToWideChar(CP_UTF8,MB_ERR_INVALID_CHARS,abbr.c_str(),-1,&wabbr[0],sz+1);
		if(sz != 0) return std::wstring(&wabbr[0]);
		return std::wstring(L"¤");
	};
#endif

	double getFacteur(void) const
    {
      return facteur;
    };

    double getBiais(void) const
    {
      return biais;
    };

    virtual const Unite_info& base(void) const = 0;

    struct Vecteur; // déclaration forward
    virtual Vecteur getVecteur(void) const = 0;
    virtual void setVecteur(const Vecteur&) throw(std::invalid_argument) = 0;

    // convertir une valeur S.I dans cette unite. 
    // Syntaxe: _ft.conv(val_m), où val_m est la valeur en mètres (SI)
    inline double 
    conv(double val) const {
      return val * invFacteur + oppBiais; // le compilateur peut optimiser en fast-multiply-add (1 cycle)
    };
    // convertir une valeur dans cette unite en S.I.. 
    // Syntaxe: _ft.std(val_ft), où val_ft est la valeur en pieds (non SI)
    // (utilisé à la construction de GrandeurPhysique)
    inline double 
    std(double val) const { 
      return val * facteur + biais_fois_facteur; // le compilateur peut optimiser en fast-multiply-add (1 cycle)
    };
    // méthodes définies pour toute unité, mais redéfinies pour chacune

    // Vérification de compatibilité: fonctionne sur les Unite_info
    virtual bool isCompat(const Unite_info& u) const = 0;
    // Nom standard (calculé selon la dimension)
    virtual std::string getNomStandard(void) const = 0;
#ifdef _WINDOWS
	virtual std::wstring getNomStandardw(void) const = 0;
#endif
    // Vecteur d'exposants
    struct Vecteur {
      int vecteur[8];

      Vecteur(void) {
	for(unsigned i=0;i<sizeof(vecteur)/sizeof(vecteur[0]);i++) 
	  vecteur[i] = 0;
      };
      Vecteur(const int v[8]) {
	for(unsigned i=0;i<sizeof(vecteur)/sizeof(vecteur[0]);i++) 
	  vecteur[i] = v[i];
      };
      Vecteur operator+(const Vecteur& v) const {
	Vecteur result;
	for(unsigned i=0;i<sizeof(vecteur)/sizeof(vecteur[0]);i++) 
	  result.vecteur[i] = vecteur[i]+v.vecteur[i];
	return result;
      };
      Vecteur operator-(const Vecteur& v) const {
	Vecteur result;
	for(unsigned i=0;i<sizeof(vecteur)/sizeof(vecteur[0]);i++) 
	  result.vecteur[i] = vecteur[i]-v.vecteur[i];
	return result;
      };
      int operator==(const Vecteur& v) const {
	for(unsigned i=0;i<sizeof(vecteur)/sizeof(vecteur[0]);i++) 
	  if(vecteur[i] != v.vecteur[i]) return 0; //false
	return 1; // true
      };
    };
    
    friend
    std::istream& ::operator>>(std::istream& in, Unite_info& u);
  }; // fin de Unite_info
  
  // Déclaration de l'unité de base sans dimensions
  typedef Dimension<0> d0;
  typedef Unite_base<d0,d0,d0,d0,d0,d0,/*d0,d0,*/d0,d0> UniteAdimensionnee;

}; // fin du namespace _yama_metaprog

namespace _yama {
  class UniteInfo; // declaration forward pour operator>>
};

// Lecture depuis un flux, déclaration d'une fonction friend.
// Appelle une fonction virtuelle et ne peut donc pas être appellée avant
// le corps d'un constructeur.
std::istream& operator>>(std::istream& in, _yama::UniteInfo& u);

namespace _yama {
  // Classe UniteInfo, similaire à Unite_info ci-dessus, mais directement
  // accessible dans le namespace yama. Reprend tous les services de Unite qui
  // sont applicables à une unité générique.
  class UniteInfo: public _yama_metaprog::Unite_info
  {
    static const UniteInfo adim_si; // Unité adimensionnée globale
	// Sert à calculer les unités inverses m/s -> s/m

    // Référence constante vers l'unité de base correspondante
    const Unite_info* unite_si; // n'est initialisé que s'il est demandé

    // Stocke le vecteur. La classe parente Unite_info utilise une fonction
    // pure virtuelle pour obtenir le vecteur à la demande.
    Vecteur dimensions;

    // Constructeur privé qui crée une unité SI de dimension spécifiée.
    UniteInfo(const Vecteur& dim)
      : Unite_info("",""),
	unite_si(0),
	dimensions(dim)
    {};

    // Méthodes génériques d'affichage du nom à partir du vecteur
    std::string nomStandard(void) const;
#ifdef _WINDOWS
    std::wstring nomStandardw(void) const;
#endif

  public:
    // Constructeurs et destructeurs --------------------------------------

    // Les unités nommées sont enregistrées.
    
    // constructeur d'une unite par produit d'autres unites
    // c'est à dire en donnant un nom à une unité anonyme construite
    UniteInfo(const std::string iNom, const std::string iAbbrev, 
	      const Unite_info& u)
      throw()
      : Unite_info(iNom, iAbbrev, u),
	unite_si(&u.base()),
	dimensions(u.getVecteur())
    {
      enregistrer();
    };
    // constructeur d'une nouvelle unite 'iNom' egale a 'val' fois 'u'.
    // exception si val est nul.
    UniteInfo(const std::string iNom, const std::string iAbbrev,
	      double val, const Unite_info& u, double iBiais=0.0)
      throw(std::invalid_argument)
      : Unite_info(iNom, iAbbrev,val,u,iBiais),
	unite_si(&u.base()),
	dimensions(u.getVecteur())
    {
      enregistrer();
    };
    // constructeurs de copie
    // la manipulation d'unités est coûteuse en ressources de calcul,
    // mais elle ne se produit pas au cours de calculs ordinaires avec
    // des GrandeurPhysique.
    UniteInfo(const UniteInfo& u) 
      throw()
      : Unite_info("",u.getAbbrev(), u), // anonyme pour éviter les recherches
	unite_si(u.unite_si),
	dimensions(u.dimensions)
    {}; // une copie n'est jamais enregistrée

    UniteInfo(const Unite_info& u) 
      throw()
      : Unite_info("",u.getAbbrev(), u), // anonyme pour éviter les recherches
	unite_si(0),
	dimensions(u.getVecteur())
    {}; // une copie n'est jamais enregistrée
   
    // Méthodes
    // -----------------------------------------------------------
    
    // Renvoie l'unité SI (de base) correspondante
    // L'unité correspondante est forcément homogène
    // Implémentation de UniteInfo::base
	virtual const Unite_info& base(void) const {
		const Unite_info * c = unite_si;
		UniteInfo u(dimensions); // constructeur privé
		if(c == 0) {
			// Recherche un objet UniteInfo SI de même dimension
			c = rechercher(u);
		}
		if(c == 0) {
			// b n'est jamais désalloué
			UniteInfo * b = new UniteInfo(u.nomStandard(),u.nomStandard(),u);
			b->unite_si = b;
			b->enregistrer();
			c = b;
		}
		// accélération des prochaines requêtes
		const_cast<UniteInfo*>(this)->unite_si = c;
		return *unite_si;
	};
    
    // Opérations sur les unités: le type de retour est calculé
    UniteInfo operator*(const Unite_info& u) const
      throw(std::invalid_argument)
    {
      assert(biais == 0 && u.getBiais() == 0);
      if(biais != 0 || u.getBiais() != 0)
	throw std::invalid_argument("Produit d'unités avec biais interdit");
      // calcul du vecteur résultant
      UniteInfo produit(dimensions + u.getVecteur());
      // il ne reste qu'à calculer le facteur.
      return UniteInfo("","",facteur*u.getFacteur(),produit);
    };
    
    UniteInfo operator/(const UniteInfo& u) const
      throw(std::invalid_argument)
    {
      assert(biais == 0 && u.getBiais() == 0);
      if(biais != 0 || u.getBiais() != 0)
	throw std::invalid_argument("Ratio d'unités avec biais interdit");
      // calcul du vecteur résultant
      UniteInfo ratio(dimensions - u.dimensions);
      // il ne reste qu'à calculer le facteur et le biais.
      // TODO il faut calculer l'objet unite_si donnant la dimension TODO
      return UniteInfo("","",facteur/u.getFacteur(),ratio);
    };
    
    // TODO puissance
    
    // carre, cube
    UniteInfo carre(void) const
    {
      return (*this)*(*this);
    };
    UniteInfo cube(void)  const
    {
      return carre()*(*this);
    };
    UniteInfo inv(void)   const
    {
      return adim_si / (*this);
    };
    bool isCompat(const UniteInfo& u) const
    {
      if (dimensions == u.dimensions)
	return true;
      else
	return false;
    };
    // Implémentation de Unite_info::isCompat()
    virtual bool isCompat(const Unite_info& u) const
    {
      if (dimensions == u.getVecteur())
	return true;
      else
	return false;
    };
    
    // Implémentation de UniteInfo::getNomStandard()
    virtual std::string getNomStandard(void) const 
    throw(std::logic_error) 
    {
      //assert(facteur == 1.0 && biais == 0);
      if(facteur!=1.0 || biais!=0.0) throw std::logic_error("bug");
      return nomStandard();
    };
#ifdef _WINDOWS
	virtual std::wstring getNomStandardw(void) const
	throw(std::logic_error)
	{
      if(facteur!=1.0 || biais!=0.0) throw std::logic_error("bug");
      return nomStandardw();
	};
#endif
    // Implémentation de Unite_info::getVecteur()
    virtual Vecteur getVecteur(void) const
    {
      Vecteur v(dimensions);
      return v;
    };
    virtual void setVecteur(const Vecteur& v) throw()
    {
      dimensions = v;
    };

    friend
    std::istream& ::operator>>(std::istream& in, UniteInfo& u);
  };   // fin de la classe UniteInfo  

}; // fin du namespace _yama

// Forward declaration servant pour la fonction friend ci-dessous
// template<class _u_>
// class Unite;

// Prototypes des fonctions amies de Unite<_u_>, qui doivent être vus
// avant la clause friend dans le corps de la classe.
// template<class _u_>
// std::istream& operator>>(std::istream&, Unite<_u_>&);

// Les unités sont des éléments de référence servant aux
// entrées/sorties. Elles ne sont pas traités au cours des calculs, donc
// leur taille n'est pas optimisée. L'implémentation est optimisée
// pour la vitesse d'exécution des opérations courantes de conversion.
// Les unités ne sont jamais anonymes. L'équivalent dans cette version
// de la librairie est l'objet Unite_base d'un objet GrandeurPhysique.
template<class _u_>
class Unite: public _yama_metaprog::Unite_info, public _u_ {
  // méta-assertion sur le type de u.
  typedef typename _u_::test _parent;

  // interdire le constructeur par défaut
  Unite(void) {};
  // constructeur des unités élémentaires SI, et autres par
  // spécification directe du facteur et du biais
  // privé car toutes ces unités sont mises à disposition sous forme
  // d'instances.
  Unite(const char * iNom, const char * iAbbrev,
	double iFacteur=1.0, double iBiais=0.0)
    throw()
    : Unite_info(iNom,iAbbrev,iFacteur,iBiais)
  {
    enregistrer();
  };
  // le même avec des string
  Unite(const std::string& iNom, const std::string& iAbbrev,
	double iFacteur=1.0, double iBiais=0.0)
    throw()
    : Unite_info(iNom,iAbbrev,iFacteur,iBiais)
  {
    enregistrer();
  };

public:


  // L'unité SI correspondant aux dimensions de cette instance du template
  // 20151116 remplacement unite_si par unite_si(nom, abbrev) pour construire
  // et unite_si() pour lire. Les arguments ne sont utilisés que lors du 1er
  // appel pour initialiser u.
  //static const Unite unite_si;
  static const Unite& unite_si(const char * iNom="", const char * iAbbrev="")
  {
	  static Unite u(iNom,iAbbrev); // construit l'unité par défaut (SI) de la classe
	  assert(!u.getNom().empty()); // vérifie l'initialisation correcte préalable de static u.
	  // le déclenchement de l'assertion signifie que nom et abbrev sont vides.
	  return u;
  };
  // Constructeurs et destructeurs --------------------------------------
  
  // Les unités nommées sont enregistrées.

  // constructeur d'une unite par produit d'autres unites
  // c'est à dire en donnant un nouveau nom à une unité
  Unite(const char * iNom, const char * iAbbrev, const Unite& u)
    throw()
    : Unite_info(iNom, iAbbrev, u)
  {
    enregistrer();
  };
#if 0
  // ATTENTION: ce code était juste un test pour savoir si VC++ 2008
  // supportait les rvalue_reference et std::move. Ce n'est pas le cas
  // et ce code n'est pas correct.
  // le même avec une rvalue_reference, qui implemente une sémantique de
  // déplacement plus efficace quand l'unité u est anonyme et va être détruite.
  Unite(const char * iNom, const char * iAbbrev, const Unite&& u)
    throw()
    : Unite_info(iNom, iAbbrev, u)
  {
    enregistrer();
  };
#endif

  // constructeur d'une nouvelle unite 'iNom' egale a 'val' fois 'u'.
  // exception si val est nul.
  Unite(const char * iNom, const char * iAbbrev,
	double val, const Unite& u, double iBiais=0.0)
    throw(std::invalid_argument)
    : Unite_info(iNom, iAbbrev,val,u,iBiais)
  {
    // cas particulier si u == unite_si, parce qu'unite_si n'est pas
    // toujours initialisé lorsqu'il est utilisé.
    if(&u == &unite_si()) {
      facteur = val;
      biais   = iBiais;
      biais_fois_facteur = biais * facteur;
      invFacteur = 1.0/facteur;
      oppBiais = -biais;
    }
    assert(facteur != 0);
    enregistrer();
  };
  // constructeur de copie
  // la manipulation d'unités est coûteuse en ressources de calcul,
  // mais elle ne se produit pas au cours de calculs ordinaires avec
  // des GrandeurPhysique.
  Unite(const Unite& u) 
    throw()
    : Unite_info("",u.getAbbrev(),u)  // les copies ne sont pas enregistrées.
  {};                       
  // constructeur d'unité à partir d'un stream
  // implémentation template de operator>> en fin de ce fichier.
  // Produit une erreur stream si l'unité lue est incompatible avec la dimension
  // de l'objet Unite dans lequel on la lit.
  Unite(std::istream& in)
    : Unite_info("","")  // forcément anonyme
  {
    in >> static_cast<Unite_info&>(*this);
  };

  // Méthodes
  // -----------------------------------------------------------

  // Renvoie l'unité SI (de base) correspondante
  // L'unité correspondante est forcément homogène
  virtual const Unite& base(void) const {
    // 20151116 remplacement unite_si par unite_si()
    return unite_si();
  };

  // Opérations sur les unités: le type de retour est calculé
  template<class _u2_>
  Unite<typename _u_::template Ops<_u2_>::Produit>
  operator*(const Unite<_u2_>& u) const
    throw(std::invalid_argument)
  {
    assert(biais == 0 && u.getBiais() == 0);
    if(biais != 0 || u.getBiais() != 0)
      throw std::invalid_argument("Produit d'unités avec biais interdit");
    // la dimension qui résulte est calculé par les templates
    // il ne reste qu'à calculer le facteur.
	// 20151116 remplacement de unite_si par unite_si()
    typedef Unite<typename _u_::template Ops<_u2_>::Produit> Produit;
    return Produit("","",facteur*u.getFacteur(),Produit::unite_si());
  };

  template<class _u2_>
  Unite<typename _u_::template Ops<_u2_>::Ratio>
  operator/(const Unite<_u2_>& u) const
    throw(std::invalid_argument)
  {
    assert(biais == 0 && u.getBiais() == 0);
    if(biais != 0 || u.getBiais() != 0)
      throw std::invalid_argument("Ratio d'unités avec biais interdit");
    // la dimension qui résulte est calculé par les templates
    // il ne reste qu'à calculer le facteur et le biais.
 	// 20151116 remplacement de unite_si par unite_si()
   typedef Unite<typename _u_::template Ops<_u2_>::Ratio> Ratio;
    return Ratio("","",facteur/u.getFacteur(),Ratio::unite_si());
  };

  // Il n'est pas possible de définir une fonction élévation à la
  // puissance d'une unité, car cela reviendrait à définir des
  // méthodes dont le nom et les paramètres seraient identiques, mais
  // dont le type de retour varierait en fonction de la valeur d'un
  // paramètre.

  // carre, cube
  Unite<typename _u_::Carre> carre(void) const
  {
    return (*this)*(*this);
  };
  Unite<typename _u_::Cube>  cube(void)  const
  {
    return carre()*(*this);
  };
  Unite<typename _u_::Inv>   inv(void)   const
  {
	// 20151116 remplacement de unite_si par unite_si()
    typedef Unite<_yama_metaprog::UniteAdimensionnee> Adim;
    return Adim::unite_si() / (*this);
  };
  // Implémentation de Unite_info::isCompat()
  // Un objet Unite<u> peut être compatible avec un UniteInfo ou avec
  // un objet GrandeurPhysique<u>. 
  // Cette fonction est peu utilisée car la compatibilité est vérifiée à la
  // compilation dans la plupart des cas. getVecteur() est lente, et si
  // nécessaire une implémentation plus rapide dans le cas nominal pourrait
  // être obtenue en essayant de transtyper u (code commenté).
  virtual bool isCompat(const Unite_info& u) const
  {
    if (getVecteur() == u.getVecteur())
      return true;
    else
      return false;
  };
//   try {
//       const Unite& test  __attribute__((__unused__))
// 	= dynamic_cast<const Unite&>(u);
//   }
//   catch(std::exception) {
//     return false;
//   }
//   return true;


  virtual std::string getNomStandard(void) const 
    throw(std::logic_error) 
  {
    //assert(facteur == 1.0 && biais == 0);
    if(facteur!=1.0 || biais!=0.0) throw std::logic_error("bug");
    return _u_::nomStandard();
  };

#ifdef _WINDOWS
  virtual std::wstring getNomStandardw(void) const 
    throw(std::logic_error) 
  {
    //assert(facteur == 1.0 && biais == 0);
    if(facteur!=1.0 || biais!=0.0) throw std::logic_error("bug");
    return _u_::nomStandardw();
  };
#endif

  virtual Vecteur getVecteur(void) const
  {
    typedef typename _u_::DimMasse          Masse;
    typedef typename _u_::DimLongueur       Longueur;
    typedef typename _u_::DimTemps	    Temps;
    typedef typename _u_::DimIntensite	    Intensite;
    typedef typename _u_::DimTemperature    Temperature;
    typedef typename _u_::DimLuminosite	    Luminosite;
    typedef typename _u_::DimUniteMonetaire UniteMonetaire;
    typedef typename _u_::DimHomme	    Homme;
    static const int vecteur[] = { 
      Masse::Exposant,
      Longueur::Exposant,
      Temps::Exposant,
      Intensite::Exposant,
      Temperature::Exposant,
      Luminosite::Exposant,
      UniteMonetaire::Exposant,
      Homme::Exposant
    };
    Vecteur v(vecteur);
    return v;
  }
  // Fait une comparaison. En cas d'inégalité, renvoie une exception
  // On ne peut pas changer la dimension d'un objet Unite
  virtual void setVecteur(const Vecteur& v) throw(std::invalid_argument)
  {
    if(!(getVecteur() == v))
      throw std::invalid_argument("La dimension est fixée à la compilation");
  }
  // La lecture est sélective : la dimension doit être compatible
  //friend std::istream& operator>><>(std::istream&, Unite<_u_>&);
}; // fin de la classe Unite<>
#pragma warning(pop)
// fin de la suppression de l'avertissement pour les déclarations throw(...) explicites
  
// parseur d'unités
template<class _u_>
std::istream& operator>>(std::istream& in, Unite<_u_>& u)
{
  // on lit dans l'Unite_info car il n'y a aucun champ de données
  // supplémentaire dans u.
  in >> static_cast<_yama_metaprog::Unite_info&>(u);
  return in;
};

template<class _u_>
std::ostream& operator<<(std::ostream& out, const Unite<_u_>& u)
{
  out << u.getNom(); // méthode de la classe parente Unite_info
  return out;
};

#ifdef _WINDOWS
template<class _u_>
std::wostream& operator<<(std::wostream& wout, const Unite<_u_>& u)
{
  wchar_t * wnom = 0;
  const std::string nom = u.getNom();
  int sz = MultiByteToWideChar(CP_UTF8,0,nom.c_str(),-1,0,0);
  try {
	  wnom = new wchar_t[sz];
	  sz = MultiByteToWideChar(CP_UTF8,0,nom.c_str(),-1,wnom,sz);
	  // TODO tester sz<>0, 0 indique une erreur
      wout << wnom; // méthode de la classe parente Unite_info
  }
  catch(std::exception& e) {
	  (void)e; 
  }
  if(wnom != 0) delete [] wnom;
  return wout;
};
#endif
// Variable unite_si définie pour chaque classe template,
// donc une fois par dimension d'unité (les unités de même dimension
// sont du même type, car les unités non SI ne sont utilisées que lors
// des entrées/sorties).
// Définition des unités SI (non enregistrées, les noms standard seront
// calculés à la volée si nécessaire). 
// 20151116 remplacement unite_si par unite_si() TODO
//template<class _u_>
//const Unite<_u_> Unite<_u_>::unite_si PRIORITY("","");

// spécialisation pour unité adimensionnée
// car utilisée immédiatement pour construire des GrandeurPhysique
// à partir de 'double'.
// 20151116 remplacement unite_si par unite_si()
//EXTERN_TEMPLATE
//const Unite<_yama_metaprog::UniteAdimensionnee>
//Unite<_yama_metaprog::UniteAdimensionnee>::unite_si;

//======================================================================
// Déclaration forward de GrandeurPhysique<>
template<class _u_>
class GrandeurPhysique;

// Spécialisation partielle pour les GP adimensionnés
// Possibilité de les convertir en double, et de les construire à
// partir d'un double
template<>
class GrandeurPhysique<_yama_metaprog::UniteAdimensionnee>
{
  // méta assertion sur la classe de base _u_
  typedef _yama_metaprog::UniteAdimensionnee::test _parent;
  // convenient short-hand
  typedef GrandeurPhysique GP;

  double valeur; // valeur dans les unites SI

public:
  GP operator=(GP g)  { valeur=g.valeur;  return *this; };
  GP operator+=(GP g) { valeur+=g.valeur; return *this; };
  GP operator-=(GP g) { valeur-=g.valeur; return *this; };
  GP operator*=(GP g) 
  { 
    valeur*=g.valeur; return *this;
  };
  GP operator/=(GP g) 
  { 
    valeur/=g.valeur; return *this;
  };
  // operateur relationnels
//   int operator==(GP g) const { return valeur == g.valeur; };
//   int operator<(GP g)  const { return valeur <  g.valeur; };
//   int operator>(GP g)  const { return valeur >  g.valeur; };
//   int operator<=(GP g) const { return valeur <= g.valeur; };
//   int operator>=(GP g) const { return valeur >= g.valeur; };
//   int operator!=(GP g) const { return valeur != g.valeur; };

  // getUnite renvoie une référence vers l'unité SI correspondant à 
  // cette GrandeurPhysique.
  static const Unite<_yama_metaprog::UniteAdimensionnee>& getUnite(void) {
    //return Unite<_yama_metaprog::UniteAdimensionnee>::unite_si;
	// 20151116 remplacement unite_si par unite_si()
	return Unite<_yama_metaprog::UniteAdimensionnee>::unite_si();
  };
  // syntaxe GP.conv(_ft) -> double
  double conv(const Unite<_yama_metaprog::UniteAdimensionnee>& u) const {
    return u.conv(valeur);
  };
  double conv_SI(void) const {
    return valeur;
  };
  std::string format(const Unite<_yama_metaprog::UniteAdimensionnee>& u) const {
	  std::ostringstream s;
	  s << conv(u);
	  const std::string abbrev = u.getAbbrev();
	  if(!abbrev.empty()) s << '_' << abbrev;
	  return s.str();
  };
  std::string format(const Unite<_yama_metaprog::UniteAdimensionnee>& u, const std::locale& loc) const {
	  std::ostringstream s;
	  s.imbue(loc);
	  s << conv(u);
	  const std::string abbrev = u.getAbbrev();
	  if(!abbrev.empty()) s << '_' << abbrev;
	  return s.str();
  };
#ifdef _WINDOWS
  std::wstring formatw(const Unite<_yama_metaprog::UniteAdimensionnee>& u) const {
	  std::wostringstream s;
	  s << conv(u);
	  const std::wstring abbrev = u.getAbbrevw();
	  if(!abbrev.empty()) s << L'_' << abbrev;
	  return s.str();
  };
  std::wstring formatw(const Unite<_yama_metaprog::UniteAdimensionnee>& u, const std::locale& loc) const {
	  std::wostringstream s;
	  s.imbue(loc);
	  s << conv(u);
	  const std::wstring abbrev = u.getAbbrevw();
	  if(!abbrev.empty()) s << '_' << abbrev;
	  return s.str();
  };
#endif
  // Arithmetique
  GP operator-(void) const {
    return GP(-valeur);
  };
//   GP operator+(GP g) const {
//     return GP(valeur+g.valeur);
//   };
//   GP operator-(GP g) const {
//     return GP(valeur-g.valeur);
//   };
  template<class _u2_>
  GrandeurPhysique<_u2_> 
  operator*(GrandeurPhysique<_u2_> g) const {
    typedef GrandeurPhysique<_u2_> Prod;
    return Prod(valeur*g.conv_SI(), Prod::getUnite());
  };
  template<class _u2_>
  GrandeurPhysique<typename _u2_::Inv> 
  operator/(GrandeurPhysique<_u2_> g) const {
    typedef GrandeurPhysique<typename _u2_::Inv> Ratio;
    return Ratio(valeur/g.conv_SI(), Ratio::getUnite());
  };
  // Constructeurs et destructeurs
  // Avec unité
  GrandeurPhysique(double val, 
		   const Unite<_yama_metaprog::UniteAdimensionnee>& u)
    : valeur(u.std(val)) {};
  // Valeur nulle en SI
  GrandeurPhysique(void)
    : valeur(0.0) {};
  ~GrandeurPhysique() {};

  // Opérateurs supplémentaires pour GP adimensionnées

  // Conversion en double
  operator double(void) const {return valeur;};
  // Construction à partir d'un double sans unité
  GrandeurPhysique(double val)
    : valeur(val) {};
};

// Opérations arithmétiques avec des double en 1er opérande
// Fonctions friend, doivent être déclarées avant.
template<class _u_>
GrandeurPhysique<_u_> operator*(double d, GrandeurPhysique<_u_> g);
template<class _u_>
GrandeurPhysique<typename _u_::Inv> 
operator/(double d, GrandeurPhysique<_u_> g);


// Une GrandeurPhysique est un réel double précision contenant une
// valeur physique exprimée en unités SI. Le transtypage vers "double"
// est possible uniquement pour les GrandeurPhysique adimensionnées.
// La dimension étant codée dans le type, l'unité SI est implicite.
template<class _u_>
class GrandeurPhysique : public _u_ {
  // méta assertion sur la classe de base _u_
  typedef typename _u_::test _parent;
  
  // convenient short-hand
  typedef GrandeurPhysique GP;

  double valeur; // valeur dans les unites SI

  // constructeur privé n'utilisant que la valeur SI (unité SI implicite)
  GrandeurPhysique(const double val)
    // ERRMSG error: `GrandeurPhysique<_u_>::GrandeurPhysique(double)'
    //                is private with this context.
    // Should be interpreted as : parameter is declared as a dimensionful
    // GrandeurPhysique but incorrectly passed a double. Automatic conversion
    // is not allowed. Declare a temporary GrandeurPhysique object and specify
    // the unit.
    : valeur(val) 
  {};

public:
  GP operator=(GP g)  { valeur=g.valeur;  return *this; };
  GP operator+=(GP g) { valeur+=g.valeur; return *this; };
  GP operator-=(GP g) { valeur-=g.valeur; return *this; };
  GP operator*=(GrandeurPhysique<_yama_metaprog::UniteAdimensionnee> g) 
  { 
    valeur*=g.conv_SI(); return *this;
  };
  GP operator/=(GrandeurPhysique<_yama_metaprog::UniteAdimensionnee> g) 
  { 
    valeur/=g.conv_SI(); return *this;
  };
  // operateurs relationels
  int operator==(GP g) const { return valeur == g.valeur; };
  int operator<(GP g)  const { return valeur <  g.valeur; };
  int operator>(GP g)  const { return valeur >  g.valeur; };
  int operator<=(GP g) const { return valeur <= g.valeur; };
  int operator>=(GP g) const { return valeur >= g.valeur; };
  int operator!=(GP g) const { return valeur != g.valeur; };
  // getUnite renvoie une référence vers l'unité SI correspondant à 
  // cette GrandeurPhysique.
  static const Unite<_u_>& getUnite(void) {
    //return Unite<_u_>::unite_si;
    return Unite<_u_>::unite_si();
  };
  // syntaxe GP.conv(_ft) -> double
  double conv(const Unite<_u_>& u) const {
    return u.conv(valeur);
  };
  // conversion en SI
  double conv_SI(void) const {
    return valeur;
  };
  // conversion en chaîne pour affichage
  std::string format(const Unite<_u_>& u) const {
    std::ostringstream s;
    s << conv(u);
    const std::string abbrev = u.getAbbrev();
    if(!abbrev.empty()) s << '_' << u.getAbbrev();
    return s.str();
  };
  // conversion en chaîne localisée pour affichage
  std::string format(const Unite<_u_>& u, const std::locale& loc) const {
    std::ostringstream s;
	s.imbue(loc);
    s << conv(u);
    const std::string abbrev = u.getAbbrev();
    if(!abbrev.empty()) s << '_' << u.getAbbrev();
    return s.str();
  };
#ifdef _WINDOWS
  std::wstring formatw(const Unite<_u_>& u) const {
	  std::wostringstream s;
	  s << conv(u);
	  const std::wstring abbrev = u.getAbbrevw();
	  if(!abbrev.empty()) s << L'_' << abbrev;
	  return s.str();
  };
  std::wstring formatw(const Unite<_u_>& u, const std::locale& loc) const {
	  std::wostringstream s;
	  s.imbue(loc);
	  s << conv(u);
	  const std::wstring abbrev = u.getAbbrevw();
	  if(!abbrev.empty()) s << '_' << abbrev;
	  return s.str();
  };
#endif
  // Arithmetique
  GP operator-(void) const {
    return GP(-valeur);
  };
  GP operator+(GP g) const {
    return GP(valeur+g.valeur);
  };
  GP operator-(GP g) const {
    return GP(valeur-g.valeur);
  };
  template<class _u2_>
  GrandeurPhysique<typename _u_::template Ops<_u2_>::Produit> 
  operator*(GrandeurPhysique<_u2_> g) const {
    typedef GrandeurPhysique<typename _u_::template Ops<_u2_>::Produit> Prod;
    return Prod(valeur*g.conv_SI(), Prod::getUnite());
  };
  template<class _u2_>
  GrandeurPhysique<typename _u_::template Ops<_u2_>::Ratio> 
  operator/(GrandeurPhysique<_u2_> g) const {
    typedef GrandeurPhysique<typename _u_::template Ops<_u2_>::Ratio> Ratio;
    return Ratio(valeur/g.conv_SI(), Ratio::getUnite());
  };
  GP operator*(double d) const {
    return GP(valeur * d);
  };
  GP operator/(double d) const {
    return GP(valeur / d); // div par zéro non vérifiée
  };
  // Autres fonctions
  void zero(void) {
    valeur = 0.0;
  };
  // Constructeurs et destructeurs
  // Avec unité
  GrandeurPhysique(double val, const Unite<_u_>& u)
    : valeur(u.std(val)) {};
  // Valeur nulle en SI
  GrandeurPhysique(void)
    : valeur(0.0) {};
  ~GrandeurPhysique() {};

  // Cette opération n'est définie que dans la spécialisation adimensionnée
  //operator double(void) const;

  // Fonctions friend
  friend GrandeurPhysique<_u_> 
  operator*<>(double d, GrandeurPhysique<_u_> g);

  friend GrandeurPhysique<typename _u_::Inv> 
  operator/<>(double d, GrandeurPhysique<_u_> g);
};

// Operateurs d'entrée sortie sur des grandeurs physiques
// avec parsing d'échelle et d'unité.
template<class _u_>
std::istream& operator>>(std::istream& in, GrandeurPhysique<_u_>& g)
{
	const std::istream::sentry _Ok(in); // verrouillage
	double val;
	if(_Ok) in >> val;
	//if(in.fail()) return in;
	if(_Ok) {
		Unite<_u_> unite(in);
		g = GrandeurPhysique<_u_>(val,unite);
	}
	return in; // déverrouillage
};

// s'affiche en S.I.
template<class _u_>
std::ostream& operator<<(std::ostream& out, GrandeurPhysique<_u_> g)
{
  out << g.format(g.getUnite(),out.getloc());
//   Unite<_u_> u(g.getUnite());
//   out << g.conv(u);
//   const std::string abbrev = u.getAbbrev();
//   if(!abbrev.empty()) out << '_' << u.getAbbrev();
  return out;
};

#ifdef _WINDOWS
// s'affiche en S.I.
template<class _u_>
std::wostream& operator<<(std::wostream& wout, GrandeurPhysique<_u_> g)
{
	wout << g.formatw(g.getUnite(),wout.getloc());
	return wout;
}
#endif

// Opérations arithmétiques avec des double en 1er opérande
template<class _u_>
GrandeurPhysique<_u_> operator*(double d, GrandeurPhysique<_u_> g) {
  return GrandeurPhysique<_u_>(d*g.conv_SI(), g.getUnite());
};
template<class _u_>
GrandeurPhysique<typename _u_::Inv> 
operator/(double d, GrandeurPhysique<_u_> g) {
  typedef GrandeurPhysique<typename _u_::Inv> Inv;
  return Inv(d/g.conv_SI(), Inv::getUnite());
};

// Autres opérations sur des Grandeurs Physiques
template<class _u_>
GrandeurPhysique<_u_> fabs(GrandeurPhysique<_u_> g) {
  return GrandeurPhysique<_u_>(fabs(g.conv_SI()), g.getUnite());
};
template<class _u_>
GrandeurPhysique<typename _u_::template PuissOps<1,2>::Puissance> 
sqrt(GrandeurPhysique<_u_> g) {
  typedef GrandeurPhysique<typename _u_::template PuissOps<1,2>::Puissance> RC;
  return RC(sqrt(g.conv_SI()), RC::getUnite());
};

//======================================================================
// Définition des unités et des grandeurs physiques

namespace _yama_metaprog {
  // Déclaration des Unite_base élémentaires.
  typedef Dimension<1> d1;
  typedef Dimension<2> d2;
  // dimensions élémentaires
  typedef Unite_base<d1,d0,d0,d0,d0,d0,/*d0,d0,*/d0,d0> UniteMasse;
  typedef Unite_base<d0,d1,d0,d0,d0,d0,/*d0,d0,*/d0,d0> UniteLongueur;
  typedef Unite_base<d0,d0,d1,d0,d0,d0,/*d0,d0,*/d0,d0> UniteTemps;
  typedef Unite_base<d0,d0,d0,d1,d0,d0,/*d0,d0,*/d0,d0> UniteIntensite;
  typedef Unite_base<d0,d0,d0,d0,d1,d0,/*d0,d0,*/d0,d0> UniteTemperature;
  typedef Unite_base<d0,d0,d0,d0,d0,d1,/*d0,d0,*/d0,d0> UniteLuminosite;
//   typedef Unite_base<d0,d0,d0,d0,d0,d0,d1,d0,d0,d0> UniteAngle;
//   typedef Unite_base<d0,d0,d0,d0,d0,d0,d0,d1,d0,d0> UniteAngleSolide;
  typedef Unite_base<d0,d0,d0,d0,d0,d0,/*d0,d0,*/d1,d0> UniteMonetaire;
  typedef Unite_base<d0,d0,d0,d0,d0,d0,/*d0,d0,*/d0,d1> UniteHomme;
  // dimensions courantes
  typedef UniteLongueur::Carre UniteSurface;
  typedef UniteLongueur::Cube  UniteVolume;
  typedef UniteAdimensionnee::Ops<UniteTemps>::Ratio UniteFrequence;
  typedef UniteLongueur::Ops<UniteTemps>::Ratio UniteVitesse;
  typedef UniteVitesse::Ops<UniteTemps>::Ratio UniteAcceleration;
  typedef UniteMasse::Ops<UniteVolume>::Ratio UniteDensite;
  typedef UniteMasse::Ops<UniteAcceleration>::Produit UniteForce;
  typedef UniteForce::Ops<UniteLongueur>::Produit UniteEnergie;
  typedef UniteEnergie::Ops<UniteTemps>::Ratio UnitePuissance;
  typedef UniteForce::Ops<UniteSurface>::Ratio UnitePression;
  typedef UniteIntensite::Ops<UniteTemps>::Produit UniteCharge;
  typedef UnitePuissance::Ops<UniteIntensite>::Ratio UniteTension;
  typedef UniteTension::Ops<UniteIntensite>::Ratio UniteResistance;
  typedef UniteCharge::Ops<UniteTension>::Ratio UniteCapacitance;
  // Energie = Puissance * Temps = Tension * Intensite * Temps
  // Resistance = Tension / Intensite
  // Inductance = Energie / Intensite^2 = Resistance * Temps
  typedef UniteResistance::Ops<UniteTemps>::Produit UniteInductance;
  // flux magnétique total émis par une source magnétique (e.g. le vide)
  // (intégrale de l'intensité magnétique B sur une surface)
  typedef UniteTension::Ops<UniteTemps>::Produit UniteFluxMagnetique;
  // intensité de champ magnétique B en un point de l'espace
  typedef UniteFluxMagnetique::Ops<UniteSurface>::Ratio 
                                           UniteIntensiteMagnetique;
  typedef UniteIntensite::Ops<UniteTension>::Ratio UniteConductance;
  typedef UniteSurface::Ops<UniteTemps>::Ratio UniteViscositeCinematique;
  typedef UniteViscositeCinematique::Ops<UniteDensite>::Produit 
                                           UniteViscositeDynamique;
  // Champ électrique E: tension génératrice/distance
  typedef UniteTension::Ops<UniteLongueur>::Ratio UniteChampElectrique;
  // Champ magnétique H: courant générateur/long. circuit magnétique
  typedef UniteIntensite::Ops<UniteLongueur>::Ratio UniteChampMagnetique;
  typedef UniteLuminosite::Ops<UniteSurface>::Ratio UniteLuminance;
  typedef UniteLuminosite::Ops<UniteVolume>::Produit UniteFluxLumineux;
  typedef UniteFluxLumineux::Ops<UniteSurface>::Ratio UniteChampLumineux;

}; // end of namespace _yama_metaprog

// déclaration des unites elementaires en utilisant le constructeur
// privé. Spécialisations partielles.
// Déclarer les variables globales 'extern' ici. Cela permet de ne définir que dans un
// seul fichier Physique.o le code des classes templates les plus courantes, dont les
// unités de base font partie.
#if 0
#define UNITE_SI(dim) \
  EXTERN_TEMPLATE	\
  const Unite<_yama_metaprog::Unite ## dim> Unite<_yama_metaprog::Unite ## dim>::unite_si
#else
#define UNITE_SI(dim)
#endif
UNITE_SI(Masse); 
UNITE_SI(Longueur);
UNITE_SI(Temps);
UNITE_SI(Intensite);
UNITE_SI(Temperature);
UNITE_SI(Luminosite);
// UNITE_SI(Angle);
// UNITE_SI(AngleSolide);
UNITE_SI(Monetaire);
UNITE_SI(Homme);

#undef UNITE_SI


extern const Unite<_yama_metaprog::UniteAdimensionnee> &_1,_pourcent,_dB,_mol;
extern const Unite<_yama_metaprog::UniteLongueur>      &_m,_km,_nm,_sm,_mi,_mm;
extern const Unite<_yama_metaprog::UniteLongueur>      _ft,_ua,_ftUS,_lyr,_fath;
extern const Unite<_yama_metaprog::UniteLongueur>      _chain,_parsec,_rod,_yd;
extern const Unite<_yama_metaprog::UniteLongueur>      _fermi,_micron;
extern const Unite<_yama_metaprog::UniteLongueur>      _angstrom,_mil;
extern const Unite<_yama_metaprog::UniteSurface>       _m2,_ft2,_are,_ha;
extern const Unite<_yama_metaprog::UniteSurface>       _acre,_barn;
extern const Unite<_yama_metaprog::UniteVolume>        _m3,_ft3,_in3,_l,_gal;
extern const Unite<_yama_metaprog::UniteVolume>        _qt,_bbl,_bo,_tasse,_st;
extern const Unite<_yama_metaprog::UniteVolume>        _cuilsoup,_cuilcafe;
extern const Unite<_yama_metaprog::UniteVolume>        _fbm,_galC,_galUK,_ozfl;
extern const Unite<_yama_metaprog::UniteVolume>        _ozUK,_pk,_pt;
extern const Unite<_yama_metaprog::UniteTemps>         &_s,_h,_mn,_j,_an;
extern const Unite<_yama_metaprog::UniteFrequence>     _Hz,_kHz,_MHz,_Bq,_Ci;
extern const Unite<_yama_metaprog::UniteVitesse>       _m_s,_kt,_km_h;
extern const Unite<_yama_metaprog::UniteVitesse>       _mph,_ft_s,_c;
extern const Unite<_yama_metaprog::UniteAcceleration>  _m_s2,_G;
extern const Unite<_yama_metaprog::UniteMasse>         &_kg,_t,_lb,_g,_ct;
extern const Unite<_yama_metaprog::UniteMasse>         _grain,_lbt,_oz,_ozt;
extern const Unite<_yama_metaprog::UniteMasse>         _slug,_tonUS,_tonUK,_uma;
extern const Unite<_yama_metaprog::UniteDensite>       _kg_m3,_g_l;// densité
extern const Unite<_yama_metaprog::UniteForce>         _N,_lbf,_tf,_kgf,_gf;
extern const Unite<_yama_metaprog::UniteForce>         _dyn,_kip,_pdl;
extern const Unite<_yama_metaprog::UniteEnergie>       _J,_kJ,_kcal,_cal,_BTU;
extern const Unite<_yama_metaprog::UniteEnergie>       _erg,_eV,_therm;
extern const Unite<_yama_metaprog::UnitePuissance>     _W,_kW,_MW,_hp,_cv;
extern const Unite<_yama_metaprog::UnitePression>      _Pa,_hPa,_atm,_bar,_mbar;
extern const Unite<_yama_metaprog::UnitePression>      _inHg,_psi,_inH2O,_mmHg;
extern const Unite<_yama_metaprog::UnitePression>      _mmH2O,_torr;
extern const Unite<_yama_metaprog::UniteTemperature>   &_K,_dC,_dF,_dR,_celsius;
extern const Unite<_yama_metaprog::UniteTemperature>   _fahrenheit,_rayleigh;
extern const Unite<_yama_metaprog::UniteTemperature>   _rankine;
extern const Unite<_yama_metaprog::UniteTension>       _V;
extern const Unite<_yama_metaprog::UniteIntensite>     &_A;
extern const Unite<_yama_metaprog::UniteFluxMagnetique> _Wb;
extern const Unite<_yama_metaprog::UniteIntensiteMagnetique> _T,_mT;
extern const Unite<_yama_metaprog::UniteInductance>    _H,_mH;
extern const Unite<_yama_metaprog::UniteCapacitance>   _F,_pF,_nF,_uF,_mF;
extern const Unite<_yama_metaprog::UniteResistance>    _ohm;
extern const Unite<_yama_metaprog::UniteConductance>   _mho;
extern const Unite<_yama_metaprog::UniteCharge>        _C,_Fdy;
extern const Unite<_yama_metaprog::UniteAdimensionnee> _deg,_r,_grad,_tr;
extern const Unite<_yama_metaprog::UniteAdimensionnee> _arcmin,_arcs,_sr;
extern const Unite<_yama_metaprog::UniteFrequence>     _rpm;
extern const Unite<_yama_metaprog::UniteViscositeDynamique>   _P;
extern const Unite<_yama_metaprog::UniteViscositeCinematique> _St;
extern const Unite<_yama_metaprog::UniteLuminosite>    &_cd;//,_lam
extern const Unite<_yama_metaprog::UniteChampLumineux> _lx,_fc,_ph;//,_flam
extern const Unite<_yama_metaprog::UniteFluxLumineux>  _lm;//,_sb
#if 0
extern const Unite _Gy,_R,_rad,_rem,_S,_Sv;
#endif
extern const Unite<_yama_metaprog::UniteMasse>         _g_mol;
extern const Unite<_yama_metaprog::UniteMonetaire>     &_USD;
extern const Unite<_yama_metaprog::UniteHomme>         &_homme;

// Ces classes ne tolèrent pas les multiplications *= et /= par autre
// chose que des grandeurs sans dimensions.
typedef GrandeurPhysique<_yama_metaprog::UniteAdimensionnee> Adimensionne;
typedef Adimensionne Pourcentage;
typedef Adimensionne Angle;
typedef Adimensionne AngleSolide;
typedef GrandeurPhysique<_yama_metaprog::UniteLongueur> Longueur;
typedef Longueur     Distance;
typedef Longueur     Altitude;
typedef Longueur     Largeur;
typedef Longueur     Epaisseur;
typedef Longueur     Rayon;
typedef GrandeurPhysique<_yama_metaprog::UniteSurface> Surface;
typedef GrandeurPhysique<_yama_metaprog::UniteVolume> Volume;
typedef GrandeurPhysique<_yama_metaprog::UniteTemps> Duree;
typedef GrandeurPhysique<_yama_metaprog::UniteFrequence> Frequence;
typedef Frequence    Radioactivite; // 1 Bq = 1 désintégration / seconde
typedef Frequence    VitesseAngulaire;
typedef GrandeurPhysique<_yama_metaprog::UniteVitesse> Vitesse;
typedef GrandeurPhysique<_yama_metaprog::UniteAcceleration> Acceleration;
typedef GrandeurPhysique<_yama_metaprog::UniteMasse> Masse;
typedef Masse        MasseMolaire;
typedef GrandeurPhysique<_yama_metaprog::UniteForce> Force;
typedef GrandeurPhysique<_yama_metaprog::UniteDensite> Densite;
typedef GrandeurPhysique<_yama_metaprog::UniteEnergie> Energie;
typedef Energie      Couple; // les couples sont homogènes à des énergies
typedef GrandeurPhysique<_yama_metaprog::UnitePuissance> Puissance;
typedef GrandeurPhysique<_yama_metaprog::UnitePression> Pression;
typedef GrandeurPhysique<_yama_metaprog::UniteTemperature> Temperature;
typedef GrandeurPhysique<_yama_metaprog::UniteIntensite> Intensite;
typedef GrandeurPhysique<_yama_metaprog::UniteTension> Tension;
typedef GrandeurPhysique<_yama_metaprog::UniteCharge> Charge; //charge élec.
typedef GrandeurPhysique<_yama_metaprog::UniteResistance> Resistance;
typedef GrandeurPhysique<_yama_metaprog::UniteCapacitance> Capacitance;
typedef GrandeurPhysique<_yama_metaprog::UniteInductance> Inductance;
typedef GrandeurPhysique<_yama_metaprog::UniteIntensiteMagnetique> 
                                                IntensiteMagnetique;
typedef GrandeurPhysique<_yama_metaprog::UniteChampMagnetique> 
                                                ChampMagnetique;
typedef GrandeurPhysique<_yama_metaprog::UniteFluxMagnetique> FluxMagnetique;
typedef GrandeurPhysique<_yama_metaprog::UniteChampElectrique> ChampElectrique;
typedef GrandeurPhysique<_yama_metaprog::UniteLuminance> Luminance;
typedef GrandeurPhysique<_yama_metaprog::UniteViscositeCinematique>
                                                ViscositeCinematique;
typedef GrandeurPhysique<_yama_metaprog::UniteViscositeDynamique>
                                                ViscositeDynamique;

//======================================================================
// Méthodes template 

//======================================================================
// Classe Unite_base<>
namespace _yama_metaprog {
  // construire un nom d'unite base sur le vecteur
  template<class _kg_,class _m_,class _s_,class _A_,class _K_,class _cd_,
	   /*class _rad_,class _sr_,*/class _USD_,class _h_>
  std::string 
  Unite_base<_kg_,_m_,_s_,_A_,_K_,_cd_,_USD_,_h_>::nomStandard(void)
  {
    std::ostringstream snom;
    bool srest=false;
    // Exposant étant une constante, cette fonction est prodigieusement
    // raccourcie par l'optimiseur. En effet, toutes les conditions sont
    // connues à la compilation.
    if(_kg_::Exposant>0) {
       snom << "kg";
       if(_kg_::Exposant>1) snom << "^" << _kg_::Exposant;
       srest=true;
     }
    if(_m_::Exposant >0) {
       if(srest) snom << ".";
       snom << "m";
       if(_m_::Exposant >1) snom << _m_::Exposant ;
       srest=true;
     }
    if(_s_::Exposant >0) {
       if(srest) snom << ".";
       snom << "s";
       if(_s_::Exposant >1) snom << _s_::Exposant ;
       srest=true;
     }
     if(_A_::Exposant >0) {
       if(srest) snom << ".";
       snom << "A";
       if(_A_::Exposant >1) snom << _A_::Exposant ;
       srest=true;
     }
     if(_K_::Exposant >0) {
       if(srest) snom << ".";
       snom << "K";
       if(_K_::Exposant >1) snom << _K_::Exposant ;
       srest=true;
     }
     if(_cd_::Exposant>0) {
       if(srest) snom << ".";
       snom << "cd";
       if(_cd_::Exposant >1) snom << _cd_::Exposant ;
       srest=true;
     }/*
     if(_rad_::Exposant>0) {
       if(srest) snom << ".";
       snom << "r";
       if(_rad_::Exposant >1) snom << _rad_::Exposant ;
       srest=true;
     }
     if(_sr_::Exposant >0) {
       if(srest) snom << ".";
       snom << "sr";
       if(_sr_::Exposant >1) snom << _sr_::Exposant ;
       srest=true;
       }*/
     if(_USD_::Exposant>0) {
       if(srest) snom << ".";
       snom << "$";
       if(_USD_::Exposant>1) snom << _USD_::Exposant;
       srest=true;
     }
     if(_h_::Exposant > 0) {
       if(srest) snom << ".";
       snom << "h";
       if(_h_::Exposant > 1) snom << _h_::Exposant;
       srest=true;
     }

     std::ostringstream sden;

     bool drest=false;
     if(_kg_::Exposant<0) {
       sden << "kg";
       if(_kg_::Exposant<-1) sden << -_kg_::Exposant;
       drest=true;
     }
     if(_m_::Exposant <0) {
       if(drest) sden << ".";
       sden << "m";
       if(_m_::Exposant <-1) sden << -_m_::Exposant ;
       drest=true;
     }
     if(_s_::Exposant <0) {
       if(drest) sden << ".";
       sden << "s";
       if(_s_::Exposant <-1) sden << -_s_::Exposant ;
       drest=true;
     }
     if(_A_::Exposant <0) {
       if(drest) sden << ".";
       sden << "A";
       if(_A_::Exposant <-1) sden << -_A_::Exposant ;
       drest=true;
     }
     if(_K_::Exposant <0) {
       if(drest) sden << ".";
       sden << "K";
       if(_K_::Exposant <-1) sden << -_K_::Exposant ;
       drest=true;
     }
     if(_cd_::Exposant<0) {
       if(drest) sden << ".";
       sden << "cd";
       if(_cd_::Exposant <-1) sden << -_cd_::Exposant ;
       drest=true;
     }/*
     if(_rad_::Exposant<0) {
       if(drest) sden << ".";
       sden << "r";
       if(_rad_::Exposant <-1) sden << -_rad_::Exposant ;
       drest=true;
     }
     if(_sr_::Exposant <0) {
       if(drest) sden << ".";
       sden << "sr";
       if(_sr_::Exposant <-1) sden << -_sr_::Exposant ;
       drest=true;
     }*/
     if(_USD_::Exposant<0) {
       if(drest) sden << ".";
       sden << "$";
       if(_USD_::Exposant<-1) sden << -_USD_::Exposant;
       drest=true;
     }
     if(_h_::Exposant < 0) {
       if(drest) sden << ".";
       sden << "h";
       if(_h_::Exposant <-1) sden << -_h_::Exposant;
       drest=true;
     }
     if(drest) {
       if(srest) snom << "/" << sden.str();
       else snom << "1/" << sden.str();
     }

     return snom.str();
  }

  template<class _kg_,class _m_,class _s_,class _A_,class _K_,class _cd_,
  /*class _rad_,class _sr_,*/class _USD_,class _h_>
  std::wstring 
  Unite_base<_kg_,_m_,_s_,_A_,_K_,_cd_,_USD_,_h_>::nomStandardw(void)
  {
	  std::string nom(nomStandard());
	  int sz = MultiByteToWideChar(CP_UTF8,0,nom.c_str(),-1,0,0);
	  std::vector<wchar_t> wnom(sz+1,L'\0'); // initialiser à zéro
	  sz = MultiByteToWideChar(CP_UTF8,0,nom.c_str(),-1,&wnom[0],sz+1);
	  assert(sz != 0);
	  return std::wstring(&wnom[0]);
  };
}  // fin du namespace _yama_metaprog

#endif // _PHYSIQUE_H
