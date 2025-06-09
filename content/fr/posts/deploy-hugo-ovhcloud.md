---
title: "Déploiement Automatisé de Votre Site Hugo sur un Hébergement OVHcloud"
date: 2025-06-09T18:55:00+00:00
draft: false
description: "Guide complet pour déployer automatiquement votre site Hugo sur un hébergement OVHcloud, des méthodes manuelles aux solutions CI/CD avancées."
categories: ["Tutoriel", "Déploiement"]
tags: ["hugo", "ovhcloud", "déploiement", "automatisation", "hébergement web", "rsync", "sftp", "git", "ci/cd"]
toc: true
lastmod: 2025-06-09T18:57:00+00:00
aliases: ["/fr/deploiement-hugo-ovh/", "/fr/tutoriels/hugo-ovhcloud/"]
series: ["Hugo Introduction"]
ShowPostNavLinks: true
cover:
  image: "/jcnm/images/hugo_deploy_simple_en.png"
  alt: "Hugo le moteur generateur de site"
---

Une fois votre site Hugo développé localement, testé et que son contenu est prêt, l'étape suivante est de le mettre en ligne pour le rendre accessible au monde entier. OVHcloud, l'un des principaux hébergeurs européens, propose diverses offres d'hébergement web mutualisé qui sont parfaitement adaptées pour héberger des sites statiques générés par Hugo. L'objectif de cet article est de vous présenter les différentes méthodes pour déployer votre site sur un hébergement OVHcloud, en mettant l'accent sur l'automatisation pour simplifier ce processus.

Le déploiement consiste essentiellement à transférer les fichiers statiques générés par Hugo (contenus dans le dossier `public/` par défaut) vers le répertoire approprié de votre serveur d'hébergement OVHcloud.

## Prérequis Côté OVHcloud

Avant de pouvoir déployer votre site, assurez-vous d'avoir les informations suivantes relatives à votre hébergement OVHcloud :

> **Info**  
> Ces informations sont disponibles dans votre espace client OVHcloud, section "Hébergements", onglet "FTP - SSH".

1. **Accès FTP/SFTP/SSH** : Vous aurez besoin des identifiants de connexion :
   * **Serveur hôte (Hostname)** : L'adresse du serveur FTP/SFTP (par exemple, `ftp.clusterXXX.hosting.ovh.net` ou une adresse IP).
   * **Nom d'utilisateur (Login)** : Votre identifiant FTP/SFTP/SSH principal ou un utilisateur que vous avez créé.
   * **Mot de passe** : Le mot de passe associé à cet utilisateur.
   * **Port** : Généralement 21 pour FTP, 22 pour SFTP et SSH.

2. **Répertoire de destination (Remote Path)** : Il s'agit du dossier sur le serveur où les fichiers de votre site web doivent être placés. Sur les hébergements mutualisés OVHcloud, c'est très souvent le dossier `www/`. Parfois, cela peut être `public_html/` ou un sous-dossier si vous hébergez plusieurs sites ou si votre domaine pointe vers un sous-répertoire spécifique. Vérifiez la configuration de votre hébergement ou la documentation OVHcloud si vous avez un doute. Le chemin complet depuis la racine de votre accès FTP/SFTP sera quelque chose comme `/home/votrenomdutilisateur/www/`.

3. **Accès SSH (Optionnel mais recommandé pour certaines méthodes)** : Si votre offre d'hébergement OVHcloud inclut un accès SSH, cela ouvre la voie à des méthodes de déploiement plus robustes et sécurisées comme `rsync` via SSH ou l'utilisation de clés SSH pour une authentification sans mot de passe. L'accès SSH est souvent disponible sur les offres "Pro" ou "Performance".

## Méthodes de Déploiement

Plusieurs méthodes s'offrent à vous pour déployer votre site Hugo. Nous allons en explorer quatre principales, en allant de la plus simple (mais manuelle) à des approches plus automatisées et robustes.

### 1. Déploiement Manuel via un Client FTP/SFTP

Bien que cet article se concentre sur l'automatisation, il est bon de connaître la méthode manuelle de base.

> **Attention**  
> Cette méthode est manuelle, répétitive, et sujette aux erreurs (oubli de fichiers, mauvais répertoire de destination). Elle n'est pas recommandée pour des mises à jour fréquentes.

1. **Générez votre site** : Localement, exécutez la commande `hugo` (ou `hugo --minify` pour optimiser la taille des fichiers) à la racine de votre projet. Cela crée (ou met à jour) le dossier `public/` avec tous les fichiers statiques de votre site.

2. **Connectez-vous à votre serveur OVHcloud** : Utilisez un client FTP/SFTP comme FileZilla, Cyberduck ou WinSCP avec vos identifiants.

3. **Transférez les fichiers** : Naviguez dans le dossier `public/` localement. Sur le serveur distant, naviguez vers votre répertoire de destination (ex: `www/`). Sélectionnez tous les fichiers et dossiers à l'intérieur de votre dossier `public/` local et transférez-les vers le dossier `www/` distant. Assurez-vous de bien écraser les fichiers existants si vous mettez à jour le site.

### 2. Déploiement via SFTP (Scriptable)

SFTP (SSH File Transfer Protocol) est une méthode sécurisée pour transférer des fichiers. Elle peut être scriptée, ce qui est la première étape vers l'automatisation.

* **Principe** : Un script va se connecter au serveur SFTP d'OVHcloud et transférer le contenu du dossier `public/`.
* **Outils en ligne de commande** :
  * `sftp` : Un client SFTP en ligne de commande disponible sur Linux et MacOS. Peut être utilisé en mode batch avec un fichier de commandes.
  * `lftp` : Un client de transfert de fichiers en ligne de commande très puissant, supportant FTP, SFTP, et des fonctionnalités de miroir avancées.
  * `psftp` : Fait partie de la suite PuTTY pour Windows.
* **Configuration OVHcloud** : Assurez-vous que l'accès SFTP est activé pour votre utilisateur FTP. Le port est généralement 22.
* **Sécurité** : La gestion des mots de passe dans les scripts est un point sensible. L'utilisation de clés SSH est préférable si l'accès SSH complet est disponible (voir point suivant). Si vous devez utiliser un mot de passe, évitez de le coder en dur dans le script. Utilisez des variables d'environnement, des fichiers de configuration sécurisés (avec des permissions restreintes) ou des outils de gestion de secrets.

Nous développerons un exemple de script utilisant SFTP (ou `rsync` sur SSH) dans la section suivante.

### 3. Déploiement via `rsync` sur SSH (Recommandé)

> **Conseil**  
> Si votre hébergement OVHcloud permet l'accès SSH, `rsync` est l'outil de choix pour un déploiement efficace et rapide.

* **Principe** : `rsync` (Remote Sync) est un utilitaire qui synchronise les fichiers et répertoires entre deux emplacements (local et distant) de manière très efficiente. Il ne transfère que les parties modifiées des fichiers, ce qui rend les mises à jour très rapides.

* **Commande typique** :
  ```bash
  rsync -avz --delete -e "ssh -p 22" public/ votreutilisateur@votreserveur.ovh.net:/home/votreutilisateur/www/
  ```
  * `-a` : Mode archive (conserve permissions, dates, etc.).
  * `-v` : Verbeux (affiche les détails).
  * `-z` : Compresse les données pendant le transfert.
  * `--delete` : Supprime les fichiers sur la destination qui n'existent plus dans la source (le dossier `public/`). C'est crucial pour que les anciens fichiers soient nettoyés.
  * `-e "ssh -p 22"` : Spécifie d'utiliser SSH sur le port 22.
  * `public/` : Le contenu de votre dossier de build local (le `/` final est important pour copier le *contenu* du dossier et non le dossier lui-même).
  * `votreutilisateur@votreserveur.ovh.net:/home/votreutilisateur/www/` : Votre login SSH, le serveur SSH d'OVHcloud, et le chemin absolu vers votre répertoire de destination.

* **Authentification par Clé SSH** : Pour une automatisation complète et sécurisée, configurez une authentification par clé SSH. Cela vous permet de vous connecter sans avoir à entrer de mot de passe.
  1. Générez une paire de clés SSH sur votre machine locale si vous n'en avez pas (`ssh-keygen`).
  2. Copiez votre clé publique (`~/.ssh/id_rsa.pub` ou similaire) sur votre serveur OVHcloud dans le fichier `~/.ssh/authorized_keys`. OVHcloud fournit généralement une interface dans l'espace client pour gérer les clés SSH autorisées pour votre hébergement (si l'option est disponible).

* **Avantages** : Très rapide, efficace, sécurisé (avec clés SSH), et gère bien le nettoyage des anciens fichiers.

### 4. Déploiement via Git (Approche Git-Push)

Cette méthode est plus avancée et implique généralement que votre serveur d'hébergement (ou un service intermédiaire) puisse réagir à un `git push` pour déclencher une action de build et/ou de déploiement.

#### Option A : Git Push vers un Dépôt sur le Serveur OVH

Si vous disposez d'un VPS/Dédié ou d'un accès SSH avancé :

1. Vous configurez un dépôt Git nu (`bare repository`) sur votre serveur OVH.
2. Vous mettez en place un "hook" Git (par exemple, `post-receive`) sur ce dépôt serveur.
3. Lorsque vous faites un `git push` de votre machine locale vers ce dépôt serveur, le hook se déclenche.
4. Le script du hook peut alors : cloner le code dans un répertoire temporaire, exécuter `hugo` pour builder le site, puis copier les fichiers de `public/` vers votre répertoire `www/`.

> **Attention**  
> Cette approche est plus complexe à mettre en place, surtout sur un hébergement mutualisé où vous n'avez pas un contrôle total du serveur. Elle est mieux adaptée aux VPS ou serveurs dédiés.

#### Option B : Utilisation d'un Service CI/CD

1. Votre code source Hugo est hébergé sur une plateforme comme GitHub, GitLab ou Bitbucket.
2. Vous configurez un service CI/CD (GitHub Actions, GitLab CI, Netlify, Vercel, etc.).
3. À chaque `git push` vers votre dépôt principal, le service CI/CD :
   a. Récupère le code.
   b. Installe Hugo et les dépendances.
   c. Exécute `hugo` pour builder le site.
   d. Déploie les fichiers statiques vers votre hébergement OVHcloud (par exemple, en utilisant `rsync` ou `lftp` avec des identifiants SFTP/SSH stockés de manière sécurisée dans les secrets du CI/CD).

**Avantages** : Automatisation complète, builds reproductibles, gestion des secrets. C'est une approche très moderne et robuste.

#### Option C : Déploiement Git simple

Une variante plus simple consiste à avoir un dépôt Git qui ne contient *que* les fichiers du dossier `public/`. Votre script de déploiement local ferait :

```bash
hugo
cd public
git add . && git commit -m "Nouveau build"
git push ovh_production main
```

où `ovh_production` est un remote pointant vers un dépôt sur OVH qui est directement servi, ou qui déclenche une simple synchronisation.

> **Note**  
> Pour un hébergement mutualisé OVHcloud standard, le déploiement par `rsync` sur SSH (si disponible) ou un script SFTP robuste sont les options les plus directes et efficaces pour l'automatisation.

## Considérations de Sécurité pour le Déploiement

* **Mots de passe** : Évitez de les stocker en clair dans vos scripts. Utilisez des variables d'environnement, des fichiers de configuration avec des permissions strictes, des outils de gestion de secrets (comme HashiCorp Vault, Ansible Vault si vous utilisez Ansible, ou les secrets des systèmes CI/CD), ou des invites de saisie de mot de passe sécurisées.

* **Clés SSH** : Privilégiez l'authentification par clé SSH chaque fois que possible. Protégez votre clé privée avec une passphrase.

* **Permissions des fichiers** : Assurez-vous que les fichiers déployés sur le serveur ont des permissions appropriées (généralement 644 pour les fichiers et 755 pour les répertoires).

* **SFTP plutôt que FTP** : Utilisez toujours SFTP (ou FTPS) au lieu de FTP simple, car FTP transfère les données (y compris les identifiants) en clair, ce qui est un risque de sécurité majeur.

* **Accès limités** : Si vous créez des utilisateurs FTP/SSH spécifiques pour le déploiement, ne leur donnez que les permissions strictement nécessaires.

## Exemple de Script de Déploiement Automatisé

Voici un exemple de script shell qui automatise le déploiement de votre site Hugo vers OVHcloud en utilisant `rsync` sur SSH :

```bash
#!/bin/bash

# Configuration
HUGO_ENV="production"  # Environnement Hugo (production, development, etc.)
SSH_HOST="votreserveur.ovh.net"
SSH_USER="votreutilisateur"
SSH_PORT="22"
REMOTE_DIR="/home/votreutilisateur/www/"
LOCAL_DIR="public/"

# Couleurs pour les messages
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Démarrage du déploiement du site Hugo vers OVHcloud...${NC}"

# 1. Nettoyage du dossier public existant
echo -e "${YELLOW}Nettoyage du dossier public...${NC}"
rm -rf ${LOCAL_DIR}

# 2. Build du site avec Hugo
echo -e "${YELLOW}Construction du site avec Hugo...${NC}"
HUGO_ENV=${HUGO_ENV} hugo --minify

if [ $? -ne 0 ]; then
    echo -e "${RED}Erreur lors de la construction du site avec Hugo.${NC}"
    exit 1
fi

# 3. Déploiement vers OVHcloud avec rsync
echo -e "${YELLOW}Déploiement vers OVHcloud avec rsync...${NC}"
rsync -avz --delete -e "ssh -p ${SSH_PORT}" ${LOCAL_DIR} ${SSH_USER}@${SSH_HOST}:${REMOTE_DIR}

if [ $? -ne 0 ]; then
    echo -e "${RED}Erreur lors du déploiement vers OVHcloud.${NC}"
    exit 1
fi

echo -e "${GREEN}Déploiement terminé avec succès !${NC}"
echo -e "${GREEN}Votre site est maintenant en ligne à l'adresse : https://votredomaine.com${NC}"
```

Pour utiliser ce script :

1. Sauvegardez-le dans un fichier (par exemple, `deploy.sh`) à la racine de votre projet Hugo.
2. Modifiez les variables de configuration en haut du script pour correspondre à votre environnement.
3. Rendez le script exécutable : `chmod +x deploy.sh`.
4. Exécutez-le : `./deploy.sh`.

Si vous préférez utiliser SFTP au lieu de `rsync` (par exemple, si vous n'avez pas d'accès SSH complet), voici un exemple alternatif utilisant `lftp` :

```bash
#!/bin/bash

# Configuration
HUGO_ENV="production"
FTP_HOST="ftp.votreserveur.ovh.net"
FTP_USER="votreutilisateur"
# Utilisation d'une variable d'environnement pour le mot de passe
# Définissez-la avant d'exécuter le script avec : export FTP_PASSWORD="votremotdepasse"
FTP_PASS="${FTP_PASSWORD}"
FTP_PORT="21"  # 21 pour FTP, 22 pour SFTP
REMOTE_DIR="/www/"
LOCAL_DIR="public/"
USE_SFTP=true  # true pour SFTP, false pour FTP

# Couleurs pour les messages
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Vérification de la présence du mot de passe
if [ -z "${FTP_PASS}" ]; then
    echo -e "${RED}Erreur : La variable d'environnement FTP_PASSWORD n'est pas définie.${NC}"
    echo -e "${YELLOW}Définissez-la avec : export FTP_PASSWORD=\"votremotdepasse\"${NC}"
    exit 1
fi

echo -e "${YELLOW}Démarrage du déploiement du site Hugo vers OVHcloud...${NC}"

# 1. Nettoyage du dossier public existant
echo -e "${YELLOW}Nettoyage du dossier public...${NC}"
rm -rf ${LOCAL_DIR}

# 2. Build du site avec Hugo
echo -e "${YELLOW}Construction du site avec Hugo...${NC}"
HUGO_ENV=${HUGO_ENV} hugo --minify

if [ $? -ne 0 ]; then
    echo -e "${RED}Erreur lors de la construction du site avec Hugo.${NC}"
    exit 1
fi

# 3. Déploiement vers OVHcloud avec lftp
echo -e "${YELLOW}Déploiement vers OVHcloud avec lftp...${NC}"

# Création du script lftp
LFTP_SCRIPT=$(mktemp)
echo "open -u ${FTP_USER},${FTP_PASS} -p ${FTP_PORT} ${USE_SFTP:+sftp://}${USE_SFTP:+}${FTP_HOST}" > ${LFTP_SCRIPT}
echo "set ssl:verify-certificate no" >> ${LFTP_SCRIPT}
echo "mirror --reverse --delete --verbose ${LOCAL_DIR} ${REMOTE_DIR}" >> ${LFTP_SCRIPT}
echo "bye" >> ${LFTP_SCRIPT}

# Exécution du script lftp
lftp -f ${LFTP_SCRIPT}

if [ $? -ne 0 ]; then
    echo -e "${RED}Erreur lors du déploiement vers OVHcloud.${NC}"
    rm ${LFTP_SCRIPT}
    exit 1
fi

# Nettoyage
rm ${LFTP_SCRIPT}

echo -e "${GREEN}Déploiement terminé avec succès !${NC}"
echo -e "${GREEN}Votre site est maintenant en ligne à l'adresse : https://votredomaine.com${NC}"
```

> **Attention**  
> Dans le script SFTP ci-dessus, nous utilisons une variable d'environnement pour le mot de passe, ce qui est plus sécurisé que de l'inclure directement dans le script. Assurez-vous de définir cette variable avant d'exécuter le script.

## Intégration avec le Workflow Hugo

Pour une expérience encore plus fluide, vous pouvez intégrer votre script de déploiement directement dans votre workflow Hugo. Voici comment :

### Utilisation des Commandes Personnalisées Hugo

Hugo permet de définir des commandes personnalisées dans votre fichier `config.toml` (ou `config.yaml`/`config.json`). Vous pouvez ajouter une commande de déploiement comme ceci :

```toml
[deployment]
  [[deployment.targets]]
    name = "OVHcloud"
    URL = "ssh://votreutilisateur@votreserveur.ovh.net:/home/votreutilisateur/www/"
    
  [[deployment.matchers]]
    # Matcher pour les fichiers à déployer
    pattern = "^.+\\.(html|css|js|xml|json|txt|md|png|jpg|gif|svg|webp|woff|woff2|ttf|eot|ico)$"
    
  # Commandes à exécuter avant et après le déploiement
  [[deployment.commands.before]]
    command = "hugo --minify"
    
  [[deployment.commands.after]]
    command = "echo 'Site déployé avec succès sur OVHcloud !'"
```

Avec cette configuration, vous pouvez déployer votre site avec la commande :

```bash
hugo deploy
```

### Automatisation avec GitHub Actions

Si vous utilisez GitHub pour héberger votre code source Hugo, vous pouvez automatiser le déploiement avec GitHub Actions. Créez un fichier `.github/workflows/deploy.yml` dans votre dépôt :

```yaml
name: Deploy to OVHcloud

on:
  push:
    branches:
      - main  # ou master, selon votre branche principale

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v3
        with:
          submodules: true  # Pour récupérer les thèmes Hugo si nécessaire
          fetch-depth: 0    # Pour récupérer l'historique complet

      - name: Setup Hugo
        uses: peaceiris/actions-hugo@v2
        with:
          hugo-version: 'latest'
          extended: true  # Si vous utilisez Hugo Extended

      - name: Build
        run: hugo --minify

      - name: Deploy to OVHcloud
        uses: burnett01/rsync-deployments@5.2.1
        with:
          switches: -avzr --delete
          path: public/
          remote_path: /home/votreutilisateur/www/
          remote_host: ${{ secrets.DEPLOY_HOST }}
          remote_user: ${{ secrets.DEPLOY_USER }}
          remote_key: ${{ secrets.DEPLOY_KEY }}
```

N'oubliez pas de configurer les secrets GitHub (`DEPLOY_HOST`, `DEPLOY_USER`, `DEPLOY_KEY`) dans les paramètres de votre dépôt.

## Conclusion

Le déploiement automatisé de votre site Hugo sur OVHcloud vous permet de gagner du temps et de réduire les erreurs humaines. Selon votre niveau de confort technique et les fonctionnalités disponibles sur votre hébergement OVHcloud, vous pouvez choisir parmi plusieurs méthodes, allant du simple script SFTP à des solutions CI/CD complètes.

Pour un hébergement mutualisé standard, la méthode `rsync` sur SSH (si disponible) ou un script SFTP robuste offre un bon équilibre entre simplicité et efficacité. Pour des besoins plus avancés ou si vous utilisez déjà des plateformes comme GitHub ou GitLab, l'intégration avec un service CI/CD peut offrir une solution encore plus automatisée et sécurisée.

N'oubliez pas de toujours prendre en compte les considérations de sécurité, en particulier la gestion des identifiants et des mots de passe dans vos scripts de déploiement.

## Ressources Complémentaires

- [Documentation officielle de Hugo sur le déploiement](https://gohugo.io/hosting-and-deployment/)
- [Documentation OVHcloud sur l'accès FTP/SFTP](https://docs.ovh.com/fr/hosting/connexion-espace-stockage-ftp-hosting-web/)
- [Guide sur l'utilisation de rsync](https://www.digitalocean.com/community/tutorials/how-to-use-rsync-to-sync-local-and-remote-directories-fr)
- [Documentation GitHub Actions](https://docs.github.com/fr/actions)
