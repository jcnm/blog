---
title: "Agent Name Service (ANS) : Un protocole universel pour la découverte sécurisée d'agents IA"
date: 2025-06-09T18:31:50+00:00
draft: false
categories: ["Intelligence Artificielle", "Protocoles", "Sécurité"]
tags: ["ANS", "Agent Name Service", "Agents IA", "Découverte d'agents", "Interopérabilité", "DIDs", "MCP", "A2A", "PKI"]
description: "Une analyse approfondie du protocole Agent Name Service (ANS), un standard émergent pour la découverte, l'identification et la communication sécurisée entre agents IA autonomes, avec comparaison détaillée aux autres systèmes de découverte."
translationKey: ans_protocol
cover:
  image: "/jcnm/images/ans_protocol_illustration.png"
  alt: "ANS Protocol"
toc: true
---

## Introduction

C'est par un heureux hasard que j'ai découvert le protocole Agent Name Service (ANS). Alors que j'explorais les implications du Model Context Protocol (MCP) d'Anthropic fin 2024, je suis tombé par accident sur une mention d'ANS dans un fil de discussion technique. Ce qui ne devait être qu'une simple curiosité s'est révélé être une véritable trouvaille.

Dans l'écosystème en rapide évolution des agents d'intelligence artificielle autonomes, la découverte sécurisée et l'interopérabilité entre agents représentent des défis majeurs que MCP ne résolvait pas entièrement. Le protocole **Agent Name Service (ANS)** est apparu comme une pièce inattendue du puzzle, offrant un mécanisme robuste pour la découverte, l'identification et la communication sécurisée entre agents IA.

Développé sous l'égide du projet OWASP GenAI Security et soutenu par des organisations majeures comme AWS, Intuit et Cisco, ANS représente une avancée significative dans la standardisation des interactions entre agents IA. Ce protocole, dont les premières spécifications officielles ont été publiées en mai 2025, s'inspire du DNS tout en intégrant des mécanismes de sécurité modernes adaptés aux besoins spécifiques des agents autonomes.

Ce qui m'a particulièrement surpris dans ANS, c'est sa capacité à combler le fossé entre les différents protocoles de communication comme MCP et A2A, en fournissant cette couche fondamentale de découverte que je ne cherchais même pas, mais qui manquait cruellement à l'écosystème des agents IA.

## Problématiques résolues par ANS

Le protocole ANS vise à résoudre plusieurs problèmes fondamentaux dans les écosystèmes d'agents IA :

### Identifiants peu conviviaux

À l'instar des adresses blockchain difficiles à mémoriser pour les humains, les agents IA utilisent souvent des identifiants complexes peu adaptés à l'usage humain. ANS fournit une couche de nommage qui associe des noms lisibles par les humains à des identifiants d'agents sécurisés [1, 2].

### Absence de découverte standardisée

Sans ANS, les agents IA de différents fournisseurs peinent à se découvrir et à interagir entre eux, nécessitant une intégration personnalisée pour chaque interaction entre agents [3]. ANS établit un standard commun qui facilite cette découverte.

### Vulnérabilités de sécurité

Les protocoles de communication actuels entre agents, comme le Model Context Protocol (MCP) d'Anthropic et l'Agent-to-Agent Protocol (A2A) de Google, manquent de sécurité spécifique au protocole, les rendant vulnérables à diverses attaques comme l'usurpation d'identité d'agent, l'empoisonnement de registre et les attaques homme-du-milieu [4, 5].

### Contrôle centralisé

De nombreux systèmes de nommage existants reposent sur des autorités centralisées, créant des points uniques de défaillance et des risques de censure. ANS exploite des approches décentralisées pour une plus grande résilience [6].

## Comparaison avec d'autres systèmes de nommage et de découverte

J'ai utilisé l'IA DeepResearch like pour réaliser un tableau comparatif pour moi. 
L'idée est simplement de comprendre avec hauteur où se situe ANS dans le tableau des protocols découvertes. 

### Comparaison générale des systèmes de nommage

| Système                         | Type         | Décentralisation | Sécurité | Noms lisibles | Spécificité aux agents IA |
| ------------------------------- | ------------ | ---------------- | -------- | ------------- | ------------------------- |
| **ANS**                         | Hybride      | ★★★★☆            | ★★★★★    | ★★★★☆         | ★★★★★                     |
| **DNS**                         | Hiérarchique | ★★☆☆☆            | ★★★☆☆    | ★★★★★         | ★☆☆☆☆                     |
| **Namecoin**                    | Blockchain   | ★★★★★            | ★★★★☆    | ★★★☆☆         | ★☆☆☆☆                     |
| **ENS** (Ethereum Name Service) | Blockchain   | ★★★★☆            | ★★★★☆    | ★★★★☆         | ★☆☆☆☆                     |
| **DIDs** (W3C)                  | Décentralisé | ★★★★★            | ★★★★★    | ★★☆☆☆         | ★★☆☆☆                     |

ANS se distingue par sa conception spécifique pour les agents IA, combinant les avantages des systèmes existants tout en répondant aux besoins particuliers de sécurité et d'interopérabilité des écosystèmes d'agents autonomes.

### Comparaison détaillée entre ANS, A2A et MCP

Pour mieux comprendre le positionnement et les avantages du protocole Agent Name Service (ANS), il est essentiel de le comparer aux autres protocoles majeurs de communication entre agents IA : l'Agent-to-Agent Protocol (A2A) de Google et le Model Context Protocol (MCP) d'Anthropic.

#### Tableau comparatif

| Caractéristique                | ANS                                             | A2A                                | MCP                                         |
| ------------------------------ | ----------------------------------------------- | ---------------------------------- | ------------------------------------------- |
| **Objectif principal**         | Découverte et identification sécurisée d'agents | Communication directe entre agents | Intégration de modèles avec outils externes |
| **Développeur principal**      | OWASP GenAI / Consortium (AWS, Intuit, Cisco)   | Google                             | Anthropic                                   |
| **Date de publication**        | Mai 2025                                        | Avril 2025                         | Novembre 2024                               |
| **Statut de standardisation**  | Draft IETF                                      | Spécification propriétaire         | Spécification ouverte                       |
| **Mécanisme d'identification** | PKI + DIDs                                      | Identifiants propriétaires         | Identifiants contextuels                    |
| **Sécurité intégrée**          | ★★★★★                                           | ★★★☆☆                              | ★★☆☆☆                                       |
| **Décentralisation**           | ★★★★☆                                           | ★★☆☆☆                              | ★☆☆☆☆                                       |
| **Interopérabilité**           | ★★★★★                                           | ★★★☆☆                              | ★★☆☆☆                                       |
| **Extensibilité**              | ★★★★☆                                           | ★★★★☆                              | ★★★☆☆                                       |
| **Maturité**                   | Émergent                                        | Émergent                           | En développement                            |

#### Analyse comparative

##### Objectifs et portée

**ANS** se concentre principalement sur la découverte et l'identification sécurisée des agents, servant de couche fondamentale pour l'écosystème d'agents IA. Il fournit un mécanisme standardisé pour localiser et authentifier les agents avant même que la communication ne commence.

**A2A** (Agent-to-Agent) est conçu spécifiquement pour la communication directe entre agents, définissant un format de message et un protocole d'échange standardisés. Il se concentre sur la façon dont les agents interagissent une fois qu'ils se sont découverts.

**MCP** (Model Context Protocol) est orienté vers l'intégration des modèles d'IA avec des outils et des sources de données externes. Il définit comment les modèles peuvent demander et utiliser des capacités externes, mais n'aborde pas directement la découverte d'agents.

##### Architecture et fonctionnement

**ANS** adopte une architecture inspirée du DNS avec une couche d'adaptateur de protocole qui lui permet de s'intégrer avec A2A et MCP. Il utilise une structure de nommage hiérarchique (ANSName) et s'appuie sur des mécanismes cryptographiques pour la sécurité.

**A2A** définit un format de message JSON standardisé avec des champs spécifiques pour les métadonnées, les capacités et le contenu. Il inclut des mécanismes pour la gestion des sessions et le routage des messages, mais dépend d'autres systèmes pour la découverte initiale.

**MCP** utilise un modèle de contexte pour permettre aux modèles d'IA d'interagir avec des outils externes. Il définit comment les modèles peuvent demander des actions, recevoir des résultats et maintenir un contexte conversationnel, mais n'inclut pas de mécanismes robustes pour l'authentification ou la découverte.

##### Sécurité et authentification

**ANS** intègre des mécanismes de sécurité avancés dès sa conception, utilisant l'infrastructure à clé publique (PKI), les identifiants décentralisés (DIDs), les signatures numériques et les preuves à connaissance nulle (ZKP). Il inclut une analyse de menaces complète basée sur le framework MAESTRO.

**A2A** inclut des fonctionnalités de sécurité de base comme l'authentification des messages, mais n'offre pas le même niveau de sécurité intégrée qu'ANS. Il dépend souvent de couches de sécurité externes pour une protection complète.

**MCP** se concentre principalement sur la fonctionnalité plutôt que sur la sécurité, avec des mécanismes limités pour l'authentification et la protection contre les attaques. Il est généralement déployé dans des environnements contrôlés où la sécurité est gérée par d'autres couches.

##### Complémentarité et intégration

Ces trois protocoles sont en réalité complémentaires plutôt que concurrents :

- **ANS** fournit la couche de découverte et d'identification
- **A2A** offre un protocole standardisé pour la communication entre agents
- **MCP** permet l'intégration des modèles avec des outils externes

L'architecture d'ANS reconnaît cette complémentarité en incluant une couche d'adaptateur de protocole qui permet l'intégration avec A2A et MCP, créant ainsi un écosystème plus cohérent et interopérable pour les agents IA.

#### Cas d'usage spécifiques

##### ANS excelle dans :
- La découverte d'agents basée sur les capacités
- L'authentification sécurisée entre agents de différents fournisseurs
- La résolution de noms lisibles par les humains vers des identifiants techniques
- La gestion du cycle de vie des agents (enregistrement, renouvellement, révocation)

##### A2A excelle dans :
- La communication directe et standardisée entre agents
- La définition de formats de message cohérents
- La gestion des sessions de communication
- L'orchestration des interactions multi-agents

##### MCP excelle dans :
- L'intégration des modèles d'IA avec des outils externes
- La gestion du contexte conversationnel
- L'exécution d'actions spécifiques demandées par les modèles
- Le retour de résultats formatés aux modèles

#### Conclusion sur la comparaison

ANS, A2A et MCP représentent différentes couches d'une pile technologique émergente pour les écosystèmes d'agents IA. ANS se positionne comme la couche fondamentale de découverte et d'identification, tandis que A2A et MCP se concentrent sur les aspects de communication et d'intégration.

L'avenir des écosystèmes d'agents IA dépendra probablement de l'intégration harmonieuse de ces trois protocoles, chacun apportant ses forces spécifiques à l'ensemble. ANS, en tant que développement le plus récent, comble une lacune critique dans cette pile technologique en fournissant la couche de découverte sécurisée qui manquait jusqu'à présent.

## Architecture du protocole ANS

Le protocole ANS s'articule autour de plusieurs composants interconnectés qui fonctionnent ensemble pour permettre l'enregistrement, la découverte et l'interaction des agents.

### Composants principaux

1. **Composant de registre** : Agit comme le référentiel central où les agents enregistrent leurs capacités, points de terminaison et identifiants. Ce composant maintient la correspondance entre les noms lisibles par les humains et les identifiants cryptographiques [7].

2. **Mécanisme de découverte** : Permet aux agents de localiser d'autres agents en fonction de leurs capacités ou des services spécifiques requis. Ce composant gère l'interrogation et la résolution des identifiants d'agents [8].

3. **Couche de communication** : Facilite l'interaction réelle entre les agents une fois la découverte terminée, prenant en charge divers modes d'interaction, notamment le texte, l'audio/vidéo et les échanges de données structurées [8].

4. **Couche de sécurité** : Garantit que toutes les interactions sont authentifiées et autorisées, empêchant l'usurpation d'identité et l'accès non autorisé aux services des agents. ANS intègre l'infrastructure à clé publique (PKI) pour la vérification d'identité, les signatures numériques et les preuves à connaissance nulle (ZKP) pour la validation des capacités [9].

5. **Framework d'extensibilité** : Permet d'étendre le protocole avec de nouvelles fonctionnalités tout en maintenant la compatibilité ascendante [10].

### Structure de nommage ANS

ANS définit une structure de nommage complète (ANSName) qui encode le protocole, la capacité de l'agent, le fournisseur et les métadonnées de version, permettant une résolution cohérente et sécurisée à travers divers réseaux d'agents [11]. Cette structure s'inspire des conventions de nommage DNS tout en ajoutant des fonctionnalités spécifiques aux agents.

### Couche d'adaptateur de protocole

Une innovation majeure d'ANS est sa couche d'adaptateur de protocole modulaire qui prend en charge divers standards de communication :

- **Adaptateur A2A** : Pour l'intégration avec le protocole Agent-to-Agent de Google
- **Adaptateur MCP** : Pour l'intégration avec le Model Context Protocol d'Anthropic
- **Adaptateur ACP** : Pour l'intégration avec l'Agent Communication Protocol

Cette flexibilité permet à ANS de servir de couche d'interopérabilité entre différents écosystèmes d'agents [12].

## Processus d'enregistrement et de résolution

### Enregistrement d'agent

Le processus d'enregistrement d'un agent dans ANS suit généralement ces étapes [13, 14] :

1. **Initialisation** : L'agent crée un identifiant unique et génère des clés cryptographiques pour l'authentification.

2. **Soumission des informations d'enregistrement** : L'agent soumet ses détails d'enregistrement au registre ANS, incluant :
   - Identifiant d'agent (généralement un DID - Decentralized Identifier)
   - Clé(s) publique(s) pour l'authentification
   - Points de terminaison de service
   - Métadonnées sur les capacités et services offerts

3. **Vérification** : Le registre ANS vérifie les identifiants de l'agent et assure l'unicité de l'identifiant.

4. **Dépôt/Staking de jetons** : Selon l'implémentation, les agents peuvent devoir déposer des jetons ou fournir une mise dans le cadre de l'enregistrement [15].

5. **Configuration des paramètres** : Les agents définissent des paramètres internes, notamment la distribution des incitations et les métriques de qualité de service [15].

6. **Période de test** : Les nouveaux agents subissent généralement une période de test de qualité (par exemple, une semaine) avant l'activation complète [15].

7. **Finalisation** : Après vérification et test réussis, l'agent est enregistré dans le registre ANS et devient découvrable.

### Processus de résolution

Lorsqu'un agent doit découvrir un autre agent, le processus de résolution se déroule comme suit [16, 17] :

1. **Soumission de requête** : L'agent demandeur soumet une requête avec le nom de l'agent cible ou des exigences de capacité spécifiques.

2. **Recherche dans le registre** : Le système recherche l'entrée correspondante dans le registre.

3. **Traitement par le résolveur** : Le résolveur récupère et traite les données associées.

4. **Livraison de la réponse** : Le système renvoie les informations résolues (adresse réseau, clé publique, etc.) à l'agent demandeur.

## Mécanismes de sécurité

ANS intègre plusieurs mécanismes de sécurité avancés pour protéger l'écosystème des agents [18] :

### Analyse des menaces basée sur MAESTRO

Le framework MAESTRO 7 Layers est utilisé pour identifier et atténuer les menaces telles que :

- **Usurpation d'identité d'agent** : Contrecarrée par l'authentification basée sur PKI et les signatures numériques
- **Empoisonnement de registre** : Atténué par des mécanismes de consensus et de vérification
- **Attaques homme-du-milieu (MitM)** : Prévenues par le chiffrement et l'authentification mutuelle
- **Attaques par déni de service (DoS/DDoS)** : Limitées par des mécanismes de limitation de débit et de staking

### Contrôles de sécurité PKI

ANS s'appuie fortement sur l'infrastructure à clé publique pour :
- La vérification d'identité basée sur PKI
- Les signatures numériques pour l'intégrité des messages
- La rotation des clés pour maintenir la sécurité dans le temps
- Les schémas multi-signatures pour une sécurité renforcée

### Authentification bidirectionnelle

Le protocole implémente une authentification bidirectionnelle entre agents et serveurs en utilisant les signatures de messages HTTP (RFC 9421) pour garantir l'intégrité et l'authenticité des messages [19].

## Cas d'utilisation pratiques

Le protocole ANS permet de nombreuses applications pratiques :

### Collaboration sécurisée entre agents

Des agents IA spécialisés (par exemple, un scraper d'actualités, un résumeur et un gestionnaire de distribution) peuvent se découvrir mutuellement et collaborer de manière sécurisée [20]. Cette capacité est particulièrement précieuse dans les scénarios où plusieurs agents doivent travailler ensemble pour accomplir des tâches complexes.

### Gestion d'identité cross-platform

À l'instar de Clusters qui fournit une couche d'identité unifiée à travers plusieurs blockchains, ANS peut offrir une identification d'agent cohérente à travers différentes plateformes [21]. Cela permet aux agents de maintenir une identité cohérente indépendamment de l'environnement d'exécution.

### Identification utilisateur en un clic

ANS peut faciliter la reconnaissance sécurisée des utilisateurs grâce à des connexions agent-à-agent préétablies, similaire à la façon dont les "Pico Agents" permettent une authentification transparente [22]. Cette fonctionnalité simplifie considérablement l'expérience utilisateur tout en maintenant un niveau élevé de sécurité.

### Middleware pour la découverte d'agents

À l'instar de l'approche d'Everyname pour la résolution de noms blockchain, ANS peut servir de middleware qui simplifie la découverte d'agents à travers différents écosystèmes [23]. Cette couche d'abstraction réduit la complexité d'intégration pour les développeurs.

## Implémentation et considérations techniques

### Implémentation TypeScript

L'implémentation TypeScript d'ANS fournit une base solide pour les développeurs souhaitant intégrer ce protocole dans leurs applications, exploitant le système de typage fort de TypeScript pour garantir la conformité au protocole et la sécurité [24, 25].

Les développeurs peuvent modéliser les composants du protocole ANS à l'aide d'interfaces et de classes TypeScript, avec une communication gérée via des protocoles web standard comme HTTP/HTTPS ou WebSockets. Les fonctionnalités de sécurité peuvent être implémentées à l'aide de bibliothèques cryptographiques établies et de mécanismes d'authentification disponibles dans l'écosystème TypeScript.

### Considérations d'implémentation

Lors de l'implémentation d'ANS, les développeurs doivent prendre en compte plusieurs facteurs [26] :

- **Scalabilité** : Conception pour gérer un grand nombre d'agents et de résolutions
- **Résilience** : Mécanismes pour gérer les pannes et les attaques
- **Performance** : Optimisation pour des résolutions rapides et efficaces
- **Interopérabilité** : Support pour divers protocoles et standards
- **Gouvernance** : Mécanismes pour la mise à jour et l'évolution du protocole

## Statut actuel et perspectives d'avenir

Le protocole ANS est un développement très récent (mai 2025), soutenu par des organisations majeures et en cours de standardisation à l'IETF [27]. Les premières spécifications ont été publiées sous forme de draft IETF et de document OWASP, avec une adoption croissante attendue dans les mois à venir.

À mesure que l'écosystème des agents IA continue de se développer, ANS est positionné pour devenir un standard essentiel facilitant l'interopérabilité et la sécurité dans ce domaine en rapide évolution.

## Conclusion

Le protocole Agent Name Service (ANS) représente une avancée significative dans la standardisation de la découverte et de la communication entre agents IA. En combinant des approches inspirées du DNS avec des mécanismes de sécurité modernes et une architecture flexible, ANS fournit une solution robuste aux défis d'identification, de découverte et d'interopérabilité dans les écosystèmes d'agents autonomes.

L'innovation majeure d'ANS réside dans sa capacité à combler le fossé entre les différents protocoles de communication d'agents (A2A, MCP) en fournissant une couche de découverte sécurisée qui manquait jusqu'à présent. Sa conception modulaire et son approche orientée sécurité en font une pièce essentielle de l'infrastructure émergente pour les agents IA autonomes.

Alors que nous entrons dans une ère où les agents IA jouent un rôle de plus en plus important dans nos systèmes numériques, des protocoles comme ANS seront essentiels pour garantir que ces agents peuvent interagir de manière sécurisée, efficace et standardisée.

## Références

[1] OWASP GenAI Security Project, "Agent Name Service (ANS) for Secure Al Agent Discovery v1.0," 14 mai 2025. [En ligne]. Disponible: https://genai.owasp.org/resource/agent-name-service-ans-for-secure-al-agent-discovery-v1-0/

[2] K. Huang, V. S. Narajala, I. Habler, et A. Sheriff, "Agent Name Service (ANS): A Universal Directory for Secure AI Agent Discovery and Interoperability," arXiv:2505.10609, 15 mai 2025.

[3] K. Huang, V. S. Narajala, I. Habler, et A. Sheriff, "Agent Name Service (ANS): A Universal Directory for Secure AI Agent Discovery and Interoperability," Internet-Draft, draft-narajala-ans-00, 16 mai 2025.

[4] Anthropic, "Introducing the Model Context Protocol," 25 novembre 2024. [En ligne]. Disponible: https://www.anthropic.com/news/model-context-protocol

[5] Google Developers Blog, "Announcing the Agent2Agent Protocol (A2A)," 9 avril 2025.

[6] Solo.io, "Deep Dive MCP and A2A Attack Vectors for AI Agents," 5 mai 2025.

[7] W3C, "Decentralized Identifiers (DIDs) v1.0," W3C Recommendation, 19 juillet 2022. [En ligne]. Disponible: https://www.w3.org/TR/did-core/

[8] Wikipedia, "Zooko's triangle," [En ligne]. Disponible: https://en.wikipedia.org/wiki/Zooko%27s_triangle

[9] IETF, "RFC 8949: Concise Binary Object Representation (CBOR)," décembre 2020. [En ligne]. Disponible: https://www.rfc-editor.org/rfc/rfc8949.html

[10] IETF, "RFC 9421: HTTP Message Signatures," octobre 2024. [En ligne]. Disponible: https://www.rfc-editor.org/rfc/rfc9421.html

[11] A. Ehtesham et al., "A survey of agent interoperability protocols: Model Context Protocol (MCP), Agent Communication Protocol (ACP), and Agent-to-Agent (A2A)," arXiv:2505.02279, mai 2025.

[12] Clarifai, "MCP (Model Context Protocol) vs A2A (Agent-to-Agent) Clearly Explained," 5 mai 2025.

[13] Dynatrace, "Agentic AI: How MCP and AI agents drive the latest automation revolution," 13 mai 2025.

[14] Akka.io, "MCP, A2A, ACP: What does it all mean?," 15 mai 2025.

[15] Gravitee.io, "Google's Agent-to-Agent (A2A) and Anthropic's Model Context Protocol (MCP)," 18 avril 2025.

[16] The Register, "The Agent Name Service, it's like DNS but for AI agents," 20 mai 2025.

[17] AIGL Blog, "Agent Name Service (ANS) for Secure Al Agent Discovery," 22 mai 2025.

[18] C. Greyling, "AI Agent Discoverability," Medium, juin 2025.

[19] Daily.dev, "DNS-Inspired Secure Discovery for AI Agents," juin 2025.

[20] LinkedIn, "Building a DNS-like Backbone for Autonomous AI Agents," juin 2025.

[21] Wikipedia, "Namecoin," [En ligne]. Disponible: https://en.wikipedia.org/wiki/Namecoin

[22] Medium, "History of Namecoin: A Token Forked From Bitcoin's Blockchain," 2023.

[23] Blockchain-names.com, "Namecoin | Blockchain Naming Systems," [En ligne].

[24] IETF, "RFC 1035: Domain Names - Implementation and Specification," novembre 1987.

[25] IETF, "RFC 2782: A DNS RR for specifying the location of services (SRV)," février 2000.

[26] IETF, "RFC 8446: The Transport Layer Security (TLS) Protocol Version 1.3," août 2018.

[27] Decentralized-intelligence.com, "Decentralized Naming and Zooko's Trilemma," 11 juin 2023.
