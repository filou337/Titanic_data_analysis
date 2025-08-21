# 🚢 Titanic Project — Econometrics of Qualitative Data

![GitHub last commit](https://img.shields.io/github/last-commit/username/repo?style=flat-square&color=blue)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen?style=flat-square)
![Stack](https://img.shields.io/badge/Stack-Python%20%7C%20R%20%7C%20Stats-orange?style=flat-square)
![License](https://img.shields.io/badge/License-Academic-blueviolet?style=flat-square)

---

## 📑 Table of Contents
- [🎯 Objective](#-objective)
- [📂 Data & Files](#-data--files)
- [🛠️ Methodology](#️-methodology)
- [📈 Key Findings](#-key-findings)
- [🧪 Modeling](#-modeling)
- [✅ Conclusion](#-conclusion)
- [📚 References](#-references)

---

## 🎯 Objective
Identify the **determinants of survival** in the Titanic disaster (sex, age, class) and **quantify their effects** using **discrete choice models** (LOGIT/PROBIT).

---

## 📂 Data & Files
- **Dataset**: `5_Titanic.csv` (class, age, sex, survived).
- **Brief & metadata**: `5_Informations.docx`.
- **Full report**: `Rapport_Projet_5_Titanic.pdf` (EDA, PCA, LOGIT/PROBIT, marginal effects).
- **Languages**: README 🇫🇷 and 🇬🇧.

---

## 🛠️ Methodology
1. **Descriptive analysis**  
   - Distributions, profiles (sex/age/class), cross-tabs (survival × class/sex/age).
2. **Principal Component Analysis (PCA)**  
   - Variable relationships (correlation circle).  
   - Dimension selection.
3. **LOGIT/PROBIT regression**  
   - **Forward/backward** selection, information criteria (AIC/BIC).  
   - Comparing **trivial**, **baseline (sex+age)**, and **full** models.  
   - Interpretation via **odds ratios** and **marginal effects**.

---

## 📈 Key Findings
- **Determinants hierarchy**: **sex ≫ class ≫ age**.
- **Effects (full LOGIT model)**:  
  - Male vs Female: **OR ≈ 0.09** (≈ **–50 pp** in average survival probability).  
  - Adult vs Child: **OR ≈ 0.35** (≈ **–19 pp**).  
  - 1st class vs Crew: **OR ≈ 2.36** (≈ **+16.8 pp**).  
  - 3rd class vs Crew: **OR ≈ 0.40** (≈ **–14 pp**).  
  - 2nd class: **not significant**.
- **Model fit**:  
  - Trivial: **AIC ~ 2771**, **error ~ 32%**.  
  - Sex+Age: **AIC ~ 2335**, **error ~ 22.4%**.  
  - Full: **AIC ~ 2222**, **error ~ 22.2%**.
- **Extreme profiles**:  
  - **Girl, 1st class**: p(survival) ≈ **95.7%**.  
  - **Adult male, 3rd class**: p(survival) ≈ **10.3%**.

---

## 🧪 Modeling
- **Chosen specification**: **Full LOGIT** (sex, age, class).  
- **Why**: better **interpretability** than interaction model (despite lower AIC), **stable** between LOGIT/PROBIT, satisfactory diagnostics.

---

## ✅ Conclusion
Survival was **not random**: it reflects structural **inequalities** of **gender**, **social position** (travel class), and **age**. The “**Women & Children First**” rule is empirically confirmed but **modulated** by **class**.

---

## 📚 References
- Titanic project data & brief.  
- Econometrics of qualitative data: LOGIT/PROBIT, AIC/BIC, marginal effects.  

---

### 👤 Authors
- Philippe Roumbo — M1 BIDABI  
- (Project team) Rayan Idoudi, Elmesbahi Mehdi, Ange-Paul Emmanuel The  
Université Sorbonne Paris Nord — 2024/2025
"""
