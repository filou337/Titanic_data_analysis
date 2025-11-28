# 🚢 Projet Titanic — Économétrie des données qualitatives

![GitHub last commit](https://img.shields.io/github/last-commit/username/repo?style=flat-square&color=blue)
![Status](https://img.shields.io/badge/Statut-Terminé-brightgreen?style=flat-square)
![Stack](https://img.shields.io/badge/Stack-Python%20%7C%20R%20%7C%20Stats-orange?style=flat-square)
![License](https://img.shields.io/badge/Licence-Académique-blueviolet?style=flat-square)

---

## 📑 Table des matières
- [🎯 Objectif](#-objectif)
- [📂 Données & fichiers](#-données--fichiers)
- [🛠️ Méthodologie](#️-méthodologie)
- [📈 Résultats clés](#-résultats-clés)
- [🧪 Modélisation](#-modélisation)
- [✅ Conclusion](#-conclusion)
- [📚 Références](#-références)

---

## 🎯 Objectif

Identifier les **déterminants de la survie** lors du naufrage du Titanic (sexe, âge, classe) et **quantifier leurs effets** à l’aide de **modèles de choix discrets** (LOGIT/PROBIT).

---

## 📂 Données & fichiers

- **Jeu de données** : `5_Titanic.csv` (classe, âge, sexe, survie).  
- **Énoncé & métadonnées** : `5_Informations.docx`.  
- **Rapport complet** : `Rapport_Projet_5_Titanic.pdf` (EDA, ACP, LOGIT/PROBIT, effets marginaux).  
- **Langues** : README 🇫🇷 et 🇬🇧.

---

## 🛠️ Méthodologie

1. **Analyse descriptive**  
   - Distributions, profils (sexe/âge/classe), tableaux croisés (survie × classe/sexe/âge).

2. **Analyse en Composantes Principales (ACP)**  
   - Relations entre variables (cercle de corrélation).  
   - Choix du nombre de dimensions.

3. **Régressions LOGIT/PROBIT**  
   - Sélection de variables **forward/backward**, critères d’information (AIC/BIC).  
   - Comparaison des modèles **trivial**, **de base (sexe+âge)** et **complet**.  
   - Interprétation via les **odds ratios** et les **effets marginaux**.

---

## 📈 Résultats clés

- **Hiérarchie des déterminants** : **sexe ≫ classe ≫ âge**.  

- **Effets (modèle LOGIT complet)** :  
  - Homme vs Femme : **OR ≈ 0,09** (≈ **–50 points de probabilité** moyenne de survie).  
  - Adulte vs Enfant : **OR ≈ 0,35** (≈ **–19 points**).  
  - 1ʳᵉ classe vs Équipage : **OR ≈ 2,36** (≈ **+16,8 points**).  
  - 3ᵉ classe vs Équipage : **OR ≈ 0,40** (≈ **–14 points**).  
  - 2ᵉ classe : **non significative**.

- **Qualité des modèles** :  
  - Trivial : **AIC ~ 2771**, **erreur ~ 32 %**.  
  - Sexe+Âge : **AIC ~ 2335**, **erreur ~ 22,4 %**.  
  - Complet : **AIC ~ 2222**, **erreur ~ 22,2 %**.

- **Profils extrêmes** :  
  - **Fille, 1ʳᵉ classe** : p(survie) ≈ **95,7 %**.  
  - **Homme adulte, 3ᵉ classe** : p(survie) ≈ **10,3 %**.

---

## 🧪 Modélisation

- **Spécification retenue** : **LOGIT complet** (sexe, âge, classe).  
- **Pourquoi ce choix ?**  
  - Meilleure **interprétabilité** que le modèle avec interactions (malgré un AIC plus faible pour ce dernier).  
  - Résultats **stables** entre LOGIT et PROBIT.  
  - Diagnostics satisfaisants sur les résidus et la qualité d’ajustement.

---

## ✅ Conclusion

La survie n’était **pas aléatoire** : elle reflète des **inégalités structurelles** liées au **genre**, à la **position sociale** (classe de voyage) et à l’**âge**.  
La règle « **Women & Children First** » est **confirmée empiriquement**, mais son effet est **modulé par la classe** : les femmes et enfants des classes supérieures étaient nettement plus protégés.

---

## 📚 Références

- Données et énoncé du **projet Titanic**.  
- Cours d’**économétrie des données qualitatives** : modèles LOGIT/PROBIT, AIC/BIC, effets marginaux.  

---

### 👤 Auteurs

- **Philippe Roumbo** — M1 BIDABI  
- **Rayan Idoudi**, **Elmesbahi Mehdi**, **Ange-Paul Emmanuel The**  
Université Sorbonne Paris Nord — 2024/2025
