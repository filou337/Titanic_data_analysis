rm(list=ls())

getwd()
setwd("C:/Master USPN/Cours M1 Big Data/Econometrie quzlitative")

library(readr)
library(MASS)
library(questionr)
library("broom")
library(ggplot2)
library(effects)
library("margins")
library(dplyr) 
library(questionr) 
library(ggfortify) 
library(ggplot2) 
library(reshape2)
library(FactoMineR)
library(explor)
library(readxl)
library(openxlsx)
library(readr)
library(Hmisc)       
library(corrplot)     
library(RColorBrewer)
library(PerformanceAnalytics)
library(factoextra)


titanic <- read_delim("C:/Master USPN/Cours M1 Big Data/Econometrie quzlitative/5_Titanic.csv",
                      ";", escape_double = FALSE, trim_ws = TRUE)


titanic_acp = titanic # notre base pour l'ACP avec des données numérique

str(titanic)
dim(titanic)

summary(titanic)
colnames(titanic)

# On renomme et on type nos donnees

names(titanic)[1] <- "ID"

titanic$CLASS <- factor(titanic$CLASS, levels = c(0, 1, 2, 3), 
                        labels = c("Equipage", "Premiere", "Deuxieme", "Troisieme"))
titanic$AGE <- factor(titanic$AGE, levels = c(0, 1), 
                      labels = c("Enfant", "Adulte"))
titanic$SEX <- factor(titanic$SEX, levels = c(0, 1), 
                      labels = c("Femme", "Homme"))
titanic$SURV <- factor(titanic$SURV, levels = c(0, 1), 
                       labels = c("Non", "Oui"))

colnames(titanic) <- tolower(colnames(titanic))
str(titanic)

##### ANALYSE DESCRIPTIVE DE DONNEES #####

summary(titanic)

# Tableaux de proportion
table_class <- table(titanic$class, titanic$surv)
round(prop.table(table_class,1),3)  

table_age <- table(titanic$age, titanic$surv)
round(prop.table(table_age, 1),3) 

table_sex <- table(titanic$sex, titanic$surv)
round(prop.table(table_sex, 1),3) 

# Taux de survie par profil
titanic %>%
  group_by(class, sex, age) %>%
  summarise(Nombre_survivant = n(),
            Taux_survie = sum(surv == "Oui") / n() * 100, .groups = "drop")


#Diagramme circulaire des survivants par classe :
ggplot(titanic, aes(x = "", fill = factor(surv))) +
  geom_bar(width = 1) +
  coord_polar("y") +
  facet_wrap(~class) +
  labs(title = "Taux de Survie par Classe")

par(mfrow=c(2,2))
# On visualise les probalites de survie selon la class, l'age et le sexe
barplot(prop.table(table_class, 1)[,2], 
        main="Taux de survie par classe", 
        names.arg=levels(titanic$CLASS),
        ylab="Probabilite de survie",
        col="steelblue")

barplot(prop.table(table_age, 1)[,2], 
        main="Taux de survie par age", 
        names.arg=levels(titanic$AGE),
        ylab="Probabilite de survie",
        col="tomato")

barplot(prop.table(table_sex, 1)[,2], 
        main="Taux de survie par sexe", 
        names.arg=levels(titanic$SEX),
        ylab="Probabilite de survie",
        col="seagreen")

ggplot(titanic, aes(x = factor(sex), fill = factor(surv))) +
  geom_bar(position = "dodge") +
  labs(title = "Survie par Sexe", x = "Sexe", fill = "Survecu")

par(mfrow=c(1,1))



##### ANALYSE EN COMPOSANTE PRINCIPALE ACP #####

names(titanic_acp)[1] <- "ID"
titanic_acp$ID = as.character(titanic_acp$ID)
titanic_acp$CLASS = as.numeric(titanic_acp$CLASS)
titanic_acp$AGE = as.numeric(titanic_acp$AGE)
titanic_acp$SEX = as.numeric(titanic_acp$SEX)
titanic_acp$SURV = as.numeric(titanic_acp$SURV)



matrice_correlation = cor(titanic_acp[,2:5], use = "complete.obs")
corrplot(matrice_correlation, method = "color", type = "upper",order = "hclust",
         tl.col = "black", tl.srt = 45,addCoef.col = "black", 
         cl.cex = 1.2, addCoefasPercent = TRUE, number.cex = 0.8)


tit.pca<- PCA(titanic_acp[,2:5], graph= FALSE, scale.unit = T)
print(tit.pca)


#Table de contribution des variables à la formation des dimensions
round(tit.pca$var$contrib, 1)

#Valeurs propres & inertie cumulée
tit.pca$eig

#    Eboulis des Valeurs propres  de titanic 
fviz_eig(tit.pca,addlabels = TRUE, main      = "Eboulis des valeurs propres")

# Tableau des inerties cumulées
summary.PCA(tit.pca, ncp = 2, nbelements = 4)

# graphique de contribution des variable aux axes

variables= get_pca_var(tit.pca)
corrplot(variables$cor, is.corr=FALSE)

fviz_contrib(tit.pca, choice = "var", axes = 1, top = 4)
fviz_contrib(tit.pca, choice = "var", axes = 2, top = 4)

### Representations graphique de l'ACP  

# Cercle de corrélation
fviz_pca_var(tit.pca, col.var    = "cos2",        
  gradient.cols = c("lightgrey", "blue", "red"), repel= TRUE,          
  title      = "Cercle de correlation")


# Graphe de répartition du sexe dans le Titanic
plot.PCA(tit.pca,select='cos2',
         habillage='SEX',title="Graphe de repartition du sexe dans le Titanic")

# Graphe de répartition de l'age dans le Titanic

plot.PCA(tit.pca,select='cos2',
         habillage='AGE',title="Graphe de repartition de l'age dans le Titanic")

# Graphe de répartition du niveau de survie dans le Titanic

plot.PCA(tit.pca,select='cos2',
         habillage='SURV',title="Graphe de repartition du niveau de survie dans le Titanic")

# Graphe de répartition des classes dans le Titanic

plot.PCA(tit.pca,select='cos2',
         habillage='CLASS',title="Graphe de repartition des classes dans le Titanic")

# Cercle de corrélation DIM 2-3
fviz_pca_var(
  tit.pca,axe=2:3,
  col.var    = "cos2",        # cos² (qualité de représentation)
  gradient.cols = c("lightgrey", "blue", "red"),
  repel      = TRUE,          
  title      = "Cercle de correlation sur les dimensions 2 et 3")

# PCAshiny (titanic)
# Factoshiny(titanic)



##### MODELES LOGIT ET PROBIT #####

logit_trivial = glm(surv~1, data = titanic, family = binomial(link="logit"))
summary(logit_trivial)

logit2 = glm(surv~age, data = titanic, family = binomial(link="logit"))
summary(logit2)

logit3 = glm(surv~sex, data = titanic, family = binomial(link="logit"))
summary(logit3)

logit4 = glm(surv~class, data = titanic, family = binomial(link="logit"))
summary(logit4)

logit5 = glm(surv~age+sex, data = titanic, family = binomial(link="logit"))
summary(logit5)

logit_complet = glm(surv~age+sex+class, data = titanic, family = binomial(link="logit"))
summary(logit_complet)


#On vas considérer le modèle 5 comme notre modèle à étudier qui étudie l'effet des
#variable AGE et SEX sur la survie d'un passager.

#on vas partir de ce modèle et le comparer à d'autres 
#modèles puis sélectionner les meilleures.


# On constate que les deux modeles surpasse en toutes logique le modele trivial
# Avec des valeur AIC relativement basses et un meme taux d'eurreur d'environ 22%
# Le llogit5 = glm(surv~age+sex, data = titanic, family = binomial(link="logit"))

summary(logit5)

# Qualite du modele
anova(logit5, test="Chisq")

chi2_l5 <- logit5$null.deviance
print (chi2_l5)

ddl_logit5 <- logit5$df.null - logit5$df.residual
print(ddl_logit5)

pvalue_logit5 <- pchisq(chi2_l5,ddl_logit5,lower.tail=F)
print(pvalue_logit5)

# Precision du modele
pred_logit5 = predict.glm(logit5, newdata = titanic, type = "response")

mod_logit5 = factor(ifelse(pred_logit5 > 0.5, "Oui", "Non"), levels = levels(titanic$surv))

matrice_logit5 <- table(titanic$surv, mod_logit5)
print(matrice_logit5)

taux_erreur5 <- (matrice_logit5[2,1]+matrice_logit5[1,2])/sum(matrice_logit5)

print(paste("Taux d'erreur du modele :", round(taux_erreur5, 4)))
print(paste("Taux de precision du modele :", round(1-taux_erreur5, 4)))


# On creer cette fonction qui emboite toute les caracteristiques 
# relatives a la qualite du modele

qualite_modele <- function(model){
  
  print(anova(model, test="Chisq"))
  cat("\n")
  
  chi2 <- model$null.deviance
  print(paste("Le Khi-deux du modele est :", round(chi2,3)))
  cat("\n")
  
  # degre de liberte
  ddl<- model$df.null - model$df.residual
  print(paste("Le degre de liberte est :", ddl))
  cat("\n")
  
  # p-value du modele
  p_value <- pchisq(chi2, ddl, lower.tail=F)
  print(paste("La p-value est de :", p_value))
  cat("\n")
  
  # vue d'ensemble et significativite des coefficeints
  print(summary(model))
}


# On creer cette fonction qui emboite toute les caracteristiques 
# relatives a précision du modele

taux_erreur <- function(model, base){
  
  pred_logit = predict.glm(model, newdata = base, type = "response")
  
  mod_logit = factor(ifelse(pred_logit > 0.5, "Oui", "Non"), levels = levels(titanic$surv))
  
  #la matrice de confusion
  matrice_logit <- table(observation =base$surv, prediction =mod_logit)
  cat("Matrice de confusion :\n")
  cat("\n")
  
  print(matrice_logit)
  
  cat("\n")
  #le taux d'erreur
  taux_erreur <- (matrice_logit[2,1]+matrice_logit[1,2])/sum(matrice_logit)
  
  cat("\n")
  
  AIC_model = AIC(model)
  BIC_model = BIC(model)
  
  cat(sprintf("AIC du modele : %.3f\n", AIC_model))
  cat(sprintf("BIC du modele : %.3f\n", BIC_model))
  
  cat("\n")
  
  cat(sprintf("Taux d'erreur du modele : %.2f %%\n", taux_erreur * 100))
  cat(sprintf("Taux de precision du modele :%.2f %%\n", (1-taux_erreur)*100))
  
  cat("\n") 
}

qualite_modele(logit5)
taux_erreur(logit5, titanic)

# COMPARONS LE MODELE LOGIT ETUDIE AVEC LE MODELE TRIVIALE ET UN MODELE PROBIT

logit_trivial = glm(surv~1, data = titanic, family = binomial(link="logit"))

probit5 = glm(surv~age+sex, data = titanic, family = binomial(link="probit"))

logit5 = glm(surv~age+sex, data = titanic, family = binomial(link="logit"))

qualite_modele(logit_trivial)
taux_erreur(logit_trivial, titanic)

# qualite_ogit et le probit donnent quasimentles meme resultat on choisi donc
# de continuer notre etude avecle modele logit


# Nous allons utiliser la library MASS pour analyser 
# et selectionner de facon aautomatique les meilleur modele


# Méthode backward : On part du modèle complet avec toutes les variables pour aboutir
# a un modele avec  moins de variables explicatives et qui minimise l'AIC 

logit_complet = glm(surv~age+sex+class, data = titanic, family = binomial(link="logit"))

model_select_back <- stepAIC(logit_complet, scope=list(lower="surv ~ 1", 
                                                upper=logit_complet)
                             ,direction="backward")

print(model_select_back)
summary(model_select_back)


# Methode backward : On part du modele trival pour aboutir
# a un modele avec variables explicatives et qui minimise l'AIC

model_select_forward <- stepAIC(logit_trivial, scope=list(lower="surv ~ 1", 
                                                   upper=logit_complet)
                                ,direction="forward")

print(model_select_forward)
summary(model_select_forward)

qualite_modele(model_select_forward)
taux_erreur(model_select_forward, titanic)

qualite_modele(model_select_back)
taux_erreur(model_select_back, titanic)



# les direction backward et forward forunisset exactement les memes resultats
# le modele complet reste meilleur que notre modele etudier avec le sex et l'age
# l'introduction de la class aporte une amélioration de precision du model car
# le taux d'erreur baisse 0.23 point de pourcentage avec egalement un AIC qui
# passe de 2335.1 a 2222.1 l'écart n'est pas abyssal 
# mais on retiens pour l'instant le modele complet 

### MODELE AVEC INETERRACTION : VARIABLES CROISEES ###

croise1 = glm(surv~class+(age*sex), data = titanic, family = binomial(link="logit"))
summary(croise1)
taux_erreur(croise1, titanic)

croise2 = glm(surv~sex+(class*age), data = titanic, family = binomial(link="logit"))
summary(croise2)
taux_erreur(croise2, titanic)

croise3 = glm(surv~age+(sex*class), data = titanic, family = binomial(link="logit"))
summary(croise3)

qualite_modele(croise3)
taux_erreur(croise3, titanic)

qualite_modele(logit_complet)
taux_erreur(logit_complet, titanic)

# le modèle croise semble etre plus precis que le modele complet
# avec un taux d'erreur legerement plus faible et un AIC et BIC minal
# Toutefois tous les coefficents estimes ne sont statistiquement significatifs
# on vas quand meme conserver ces deux modèles. 

# sous un prisme de prevision, le modele croise est plus adapte dans le sens ou il
# predit mieux la survie.
# de l'autre cote si on s'incrit dans une dynamique explicative il est mieux d'opter pour 
# le modele complet qui est sans interraction de variables, il est plus simple
# à interpreter avec moins de coefficients et tous statisquement significatifs.


############ ANALYSE GRAPHIQUE ET INTERPRETATION DES MODELES (Complet & Croise) ###############

summary(logit_complet)

# Le signe et la significativite des parametres estimes montre que :
# l'age le sex et la class des passagers influents sur les probalites de survie
# Etre un adulte reduis vos chance de survie
# Un homme a moins de chance de survie qu'une femme
# etre un passagers en class premiere augmente plus de chancevos probabilites de survie 
# etre en troisieme classe reduis significativement vos probabilites de survie


# tableaux de probabilite predites de survie pour tous les profils

proba_predites <- list(class = levels(titanic$class), age = levels(titanic$age),
             sex= levels(titanic$sex))
profiles <- expand.grid(proba_predites, stringsAsFactors = TRUE)

for (v in names(proba_predites)) {
  profiles[[v]] <- factor(profiles[[v]], levels = proba_predites[[v]])
}
profiles$prob_survie <- predict(logit_complet, newdata = profiles, type= "response")
profiles$prob_survie_croise <- predict(croise3, newdata = profiles, type= "response")

# Iprobabilité de survie pour un profil précis
head(profiles) 


# Odds ratio des modeles
odds.ratio(logit_complet)
odds.ratio(croise3)

# model complet
complet_graph <- tidy(logit_complet, conf.int = TRUE, exponentiate = TRUE)
str(complet_graph)


# Effet marginal 
complet_marginal <- margins(logit_complet) 
croise_marginal <- margins(croise3) 
summary(complet_marginal)
summary(croise_marginal)



# Graphique et visualisation
# tracer les odds-ratios avec la fonciton ggplot de la library ggplot2
ggplot(complet_graph) + aes(x = estimate, y= term, xmin = conf.low, 
                         xmax = conf.high) + geom_vline(xintercept = 1) + 
                         geom_errorbarh() + geom_point() + scale_x_log10()

plot(allEffects(logit_complet))
plot(allEffects(croise3))

plot(complet_marginal)
plot(croise_marginal)


profiles <- profiles[order(profiles$prob_survie, decreasing = TRUE), ]

op <- par(mar = c(8, 5, 4, 2) + 0.1)

barplot(
  height    = t(as.matrix(profiles[, c("prob_survie","prob_survie_croise")])),
  names.arg = paste0(profiles$class, "\n", profiles$age, "\n", profiles$sex),
  las       = 2,
  beside    = T,
  cex.names = 0.8,        
  col       = c("steelblue", "tomato"),       
  border    = "white",    
  ylim      = c(0, 1),    
  main      = "Probabilites de survie predites\npour chaque profil",
  ylab      = "Probabilite de survie")
legend("topright", legend = c("Modele Complet", "Modele Croise"), 
       fill = c("steelblue", "tomato"))

barplot(
  height    = t(as.matrix(profiles[, c("prob_survie")])),
  names.arg = paste0(profiles$class, "\n", profiles$age, "\n", profiles$sex),
  las       = 2,
  beside    = T,
  cex.names = 0.8,        
  col       = c("steelblue"),       
  border    = "white",    
  ylim      = c(0, 1),    
  main      = "Probabilites de survie predites\npour chaque profil",
  ylab      = "Probabilite de survie")
legend("topright", legend = c("Modele Complet"), 
       fill = c("steelblue"))