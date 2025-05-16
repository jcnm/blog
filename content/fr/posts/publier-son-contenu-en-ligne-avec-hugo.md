---
date: '2025-05-14T16:18:02+02:00'
draft: false
title: 'Rédaction de contenu en ligne avec Hugo'
tags: ["hugo", "web", "blog", "static", "exploration"]
categories: ["Tutoriel", "Adoption"]
series: ["Hugo Introduction"]
ShowPostNavLinks: true
cover:
  image: "/jcnm/site-static-hugo.png"
  alt: "Hugo le moteur generateur de site"
---

## Qu'est-ce que Hugo

Les générateurs de sites statiques (GSS) représentent une approche fondamentalement différente de la création web par rapport aux systèmes de gestion de contenu (CMS) dynamiques. Au lieu d'assembler les pages à la volée lors de chaque visite, un GSS pré-compile l'intégralité du site en fichiers HTML, CSS et JavaScript statiques qui peuvent être servis directement, sans traitement serveur supplémentaire.

Cette architecture présente plusieurs avantages inhérents :speak_no_evil: :
- **Performance** : Les pages statiques se chargent instantanément
- **Sécurité** : L'absence de base de données et de code exécuté dynamiquement élimine de nombreux vecteurs d'attaque
- **Évolutivité** : Des fichiers statiques peuvent être facilement mis en cache et distribués via CDN
- **Simplicité d'hébergement** : N'importe quel serveur web peut héberger ces fichiers - *the best argument* pour moi

## L'écosystème des générateurs de sites statiques

Le marché des GSS s'est considérablement développé ces dernières années, chacun apportant sa philosophie et ses spécificités:

| GSS             | Langage          | Année | Points forts                                    | Limitations                              |
| --------------- | ---------------- | ----- | ----------------------------------------------- | ---------------------------------------- |
| **[Hugo](https://gohugo.io)**        | Go               | 2013  | Vitesse extrême, fonctionnalités natives riches | Langage de template spécifique           |
| Jekyll          | Ruby             | 2008  | Intégration GitHub, précurseur                  | Lenteur sur gros sites, dépendances Ruby |
| Gatsby          | JavaScript/React | 2015  | Écosystème React, GraphQL intégré               | Complexité, builds lourds                |
| Eleventy (11ty) | JavaScript       | 2018  | Flexibilité, minimalisme                        | Moins de fonctionnalités natives         |
| Next.js         | JavaScript/React | 2016  | Hybride statique/dynamique                      | Complexité, orienté application          |
| Astro           | JavaScript       | 2021  | Multi-framework, îlots interactifs              | Encore jeune mais sexy                   |

### Et comparée aux autres solutions non GSS

Le marché des CMS plus vieux et prédominant se fait bouffer par les plate-forme No-Code.

| Solution                 | Complexité       | Vitesse     | Maintenance | Coût       | Sécurité   |
| ------------------------ | ---------------- | ----------- | ----------- | ---------- | ---------- |
| Hugo                     | Faible           | Très rapide | Minimale    | Gratuit    | Excellente |
| WordPress                | Moyenne à élevée | Modérée     | Régulière   | Variable   | Vulnérable |
| Wix/Squarespace          | Faible           | Modérée     | Faible      | Abonnement | Bonne      |
| Développement sur mesure | Très élevée      | Variable    | Élevée      | Élevé      | Variable   |

## Hugo : origines et architecture technique

Créé en 2013 par Steve Francia (qui a aussi travaillé sur Docker et MongoDB) et maintenu activement par Bjørn Erik Pedersen, Hugo est né de la frustration face à la lenteur des builds de Jekyll. Le projet visait à créer un générateur de sites statiques ultra-rapide et aux fonctionnalités complètes.

### Stack technique d'Hugo

- **Langage** : Écrit en Go (Golang), langage développé par Google connu pour sa rapidité et sa compilation en binaires autonomes
- **Architecture** : Compilation unique sans dépendances externes, contrairement aux solutions basées sur Node.js ou Ruby
- **Système de templates** : Utilise le moteur de templates Go avec des extensions spécifiques à Hugo
- **Traitement de contenu** : Markdown par défaut avec support de shortcodes personnalisés
- **Pipeline de ressources** : Hugo Pipes pour le traitement CSS/JS (SASS, PostCSS, minification)
- **Système de taxonomies** : Gestion native des catégories, tags et taxonomies personnalisées
- **Internationalisation** : Support multilingue intégré et performant

Le choix de Go comme langage sous-jacent n'est pas anodin. Go est conçu pour la concurrence et la performance, ce qui permet à Hugo de paralléliser efficacement la génération de contenu et d'atteindre des vitesses de compilation inégalées.

## Analyse comparative détaillée

### Hugo vs Jekyll

Jekyll, créé par Tom Preston-Werner (cofondateur de GitHub), a longtemps été le standard des GSS :

- **Performance** : Hugo génère les sites environ 30 à 100 fois plus rapidement que Jekyll
- **Installation** : Hugo est un binaire unique vs dépendances Ruby pour Jekyll
- **Écosystème** : Jekyll bénéficie de l'intégration native avec GitHub Pages
- **Maturité** : Jekyll a une plus longue histoire mais Hugo a une communauté très active
- **Fonctionnalités natives** : Hugo intègre plus de fonctionnalités sans plugins

### Hugo vs Gatsby

Gatsby représente l'approche JavaScript/React des GSS :

- **Paradigme** : Hugo est un générateur pur vs approche hybride React de Gatsby
- **Expérience développeur** : Hugo requiert moins de connaissances préalables
- **Données externes** : Gatsby excelle avec son layer GraphQL pour sources multiples
- **Performances runtime** : Hugo produit des sites plus légers côté client
- **Temps de build** : Hugo est significativement plus rapide

### Hugo vs Next.js et Nuxt.js

Next.js et Nuxt.js sont des frameworks hybrides permettant le rendu statique :

- **Objectif** : Hugo est centré contenu vs applications web pour Next/Nuxt
- **Complexité** : Hugo est beaucoup plus simple à prendre en main
- **Interactivité** : Next/Nuxt permettent plus facilement des fonctionnalités dynamiques
- **Polyvalence** : Next/Nuxt sont plus adaptés aux applications complexes
- **Infrastructure requise** : Hugo nécessite moins de ressources pour le déploiement

### Hugo vs les derniers venus (11ty, Astro)

Les nouveaux entrants comme 11ty ou Astro apportent de nouvelles approches :

- **Philosophie** : 11ty mise sur la simplicité, Astro sur les "îlots d'interactivité"
- **Maturité** : Hugo bénéficie d'un écosystème plus établi et éprouvé
- **Performance** : Hugo reste généralement plus rapide pour la génération
- **Flexibilité de templating** : 11ty et Astro offrent plus de choix de langages de templates

## Contenu dense sans complexité technique?

Après cette analyse comparative, Hugo se distingue par plusieurs facteurs clés et permet de produire rapidement un contenu riche et structuré sans vous perdre dans les méandres du développement web. Cette approche offre plusieurs avantages clés :

1. **Rapidité inégalée** : Les temps de build restent imbattables, ce qui est crucial lors de la mise à jour fréquente de contenu
2. **Simplicité d'installation** : Un simple binaire sans dépendances complexes
3. **Fonctionnalités natives complètes** : Multilinguisme, taxonomies, traitement d'images sans plugins
4. **Stabilité** : Plus de 10 ans d'existence avec une philosophie cohérente
5. **Faible empreinte technique** : Ne nécessite pas de maîtriser JavaScript, React ou d'autres frameworks
6. **Focus sur le contenu** : Écrivez en Markdown et concentrez-vous sur la qualité de vos textes
7. **Structure cohérente** : Organisation logique du contenu grâce aux taxonomies (catégories, tags)
8. **Versionnable** : Tout votre site peut être mis sous contrôle de version avec Git
9. **Portable** : Changez d'hébergeur facilement, votre site n'a pas de dépendances complexes
10. **Évolutif** : Ajoutez du contenu sans craindre une dégradation des performances


### Cas d'usage idéaux pour Hugo

Hugo est particulièrement adapté pour :

- Sites à contenu riche nécessitant des mises à jour fréquentes
- Projets où la vitesse de déploiement est critique
- Publications multilingues avec structure complexe
- Environnements où l'installation de nombreuses dépendances est problématique
- Équipes avec des profils techniques variés

## Conclusion : Un choix assez arbitraire

Dans l'écosystème foisonnant des GSS, Hugo se positionne comme une solution équilibrée entre puissance et simplicité. Son approche minimaliste mais complète permet de créer des sites web performants sans la complexité technique d'autres solutions.

Mais en toute honeteté le choix pour Hugo avec le thème PaperMod est suite à un tirage au sort le but est simple mettre en place un déploiement automatisé sur OVH, de contenu écrit avec markdown.

Nous verrons dans un article à venir comment configurer Hugo et intégrer une pipeline de déploiement automatisé sur OVH hebergement perso (donc pas de SSH du pure SFTP 😅).