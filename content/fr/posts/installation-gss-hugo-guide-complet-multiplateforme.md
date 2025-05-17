---
date: '2025-05-16T10:49:46+02:00'
draft: false
title: 'Installation de Hugo : Le Guide Complet Multiplateforme'
tags: ["hugo", "web", "blog", "static", "installation", "guide"]
categories: ["Tutoriel", "Adoption"]
series: ["Hugo Introduction"]
ShowPostNavLinks: true
cover:
  image: "/jcnm/images/fr/installation-hugo-complet-guide.png"
  alt: "Installation de Hugo le moteur generateur de site"
---

Maintenant que nous avons [exploré les raisons d'utiliser un outil comme Hugo](https://sylorion.com/jcnm/posts/publier-son-contenu-en-ligne-avec-hugo), passons à l'étape cruciale : son installation. Hugo est réputé pour sa simplicité d'installation. Il est distribué sous forme d'un unique fichier binaire exécutable, ce qui signifie qu'il n'y a généralement pas de dépendances complexes à gérer si vous utilisez les versions précompilées. Nous allons couvrir les méthodes d'installation les plus courantes pour MacOS, Windows et Linux, afin que vous puissiez démarrer rapidement, quel que soit votre environnement de travail.

Nous nous baserons sur les dernières versions stables de Hugo. Vous pouvez toujours vérifier la dernière version disponible sur la page [Releases de Hugo sur GitHub](https://github.com/gohugoio/hugo/releases).

## Prérequis Généraux d'Installation de Hugo

Pour la plupart des utilisateurs, télécharger le binaire précompilé pour votre système d'exploitation est la méthode la plus simple et ne nécessite aucune dépendance supplémentaire. Cependant, si vous envisagez de compiler Hugo depuis les sources ou si vous utilisez des fonctionnalités avancées qui pourraient en dépendre (ce qui est rare pour une utilisation standard), vous aurez besoin d'installer le langage de programmation **Go**. Nous mentionnerons cette option, mais pour débuter, les binaires suffisent amplement.

## Installation sur MacOS

Sur MacOS, vous avez principalement deux options : utiliser le gestionnaire de paquets Homebrew ou télécharger le binaire manuellement.

### Option 1 : Via Homebrew (Recommandé)

Homebrew est un gestionnaire de paquets populaire pour MacOS qui simplifie l'installation et la mise à jour de logiciels.

1.  **Installer Homebrew** (si vous ne l'avez pas déjà) :
    Ouvrez votre Terminal (Applications > Utilitaires > Terminal) et collez la commande suivante :
    ```bash
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```
    Suivez les instructions à l'écran.

2.  **Installer Hugo** :
    Une fois Homebrew installé, tapez la commande suivante dans votre Terminal :
    ```bash
    brew install hugo
    ```
    Homebrew téléchargera et installera la dernière version stable de Hugo.
    > **_NOTE:_**  Il bon de mettre à jour brew apres l'installation et régulièrement si c'est votre machine personnel avec `brew upgrade`.
3.  **Mettre à jour Hugo** (plus tard) :
    ```bash
    brew upgrade hugo
    ```

### Option 2 : Installation Manuelle du Binaire

1.  Rendez-vous sur la page [Releases de Hugo sur GitHub](https://github.com/gohugoio/hugo/releases).
2.  Téléchargez l'archive `hugo_extended_X.Y.Z_darwin-universal.tar.gz` (où X.Y.Z est le numéro de version). La version "extended" est recommandée car elle supporte des fonctionnalités comme le traitement des fichiers SASS/SCSS.
3.  Extrayez l'archive. Vous obtiendrez un fichier binaire nommé `hugo`.
    ```bash
    # tar -zxvf hugo_extended_X.Y.Z_macOS-universal.tar.gz
    tar -zxvf hugo_extended_0.147.3_darwin-universal.tar.gz
    ```
   > ?**_NOTE:_** Si ce n'est pas `darwin` qui est listé propablement `macOS` ou `silicon` le sera pour les architectures MacOS.
4.  Déplacez ce fichier binaire dans un répertoire inclus dans votre PATH système, par exemple `/usr/local/bin` :
    ```bash
    sudo mv hugo /usr/local/bin/
    ```
    Vous pourriez avoir besoin de créer le répertoire `/usr/local/bin` s'il n'existe pas, ou choisir un autre répertoire de votre PATH (comme `~/bin` si configuré).

## Installation sur Windows

Sur Windows, vous pouvez utiliser des gestionnaires de paquets comme Chocolatey ou Scoop, ou installer le binaire manuellement.

### Option 1 : Via Chocolatey (Recommandé)

Chocolatey est un gestionnaire de paquets pour Windows.

1.  **Installer Chocolatey** (si vous ne l'avez pas déjà) :
    Suivez les instructions sur le [site officiel de Chocolatey](https://chocolatey.org/install).
    Généralement, cela implique d'ouvrir PowerShell en tant qu'administrateur et d'exécuter une commande.

2.  **Installer Hugo** :
    Ouvrez PowerShell en tant qu'administrateur et tapez :
    ```powershell
    choco install hugo-extended -y
    ```
    Nous installons `hugo-extended` pour bénéficier de toutes les fonctionnalités.

3.  **Mettre à jour Hugo** (plus tard) :
    ```powershell
    choco upgrade hugo-extended -y
    ```

### Option 2 : Via Scoop

Scoop est une autre excellente alternative pour gérer les paquets en ligne de commande sur Windows.

1.  **Installer Scoop** (si vous ne l'avez pas déjà) :
    Ouvrez PowerShell et exécutez :
    ```powershell
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser # Nécessaire si pas déjà fait
    irm get.scoop.sh | iex
    ```
2.  **Installer Hugo** :
    ```powershell
    scoop install hugo-extended
    ```
3.  **Mettre à jour Hugo** (plus tard) :
    ```powershell
    scoop update hugo-extended
    ```

### Option 3 : Installation Manuelle du Binaire

1.  Allez sur la page [Releases de Hugo sur GitHub](https://github.com/gohugoio/hugo/releases).
2.  Téléchargez l'archive de la forme `hugo_extended_X.Y.Z_windows-amd64.zip`: `hugo_extended_0.147.3_windows-amd64.zip` par exemple.
3.  Extrayez l'archive. Vous trouverez un fichier `hugo.exe`.
4.  Créez un dossier (par exemple `C:\Hugo\bin`) et copiez `hugo.exe` à l'intérieur.
5.  Ajoutez ce dossier à votre variable d'environnement PATH :
    *   Recherchez "variables d'environnement" dans le menu Démarrer et sélectionnez "Modifier les variables d'environnement système".
    *   Cliquez sur "Variables d'environnement...".
    *   Dans la section "Variables système", trouvez la variable `Path` et sélectionnez-la.
    *   Cliquez sur "Modifier...", puis "Nouveau", et ajoutez le chemin vers votre dossier (ex: `C:\Hugo\bin`).
    *   Validez par OK sur toutes les fenêtres.
    Vous devrez peut-être redémarrer votre session ou votre machine pour que les modifications prennent effet, ou au moins redémarrer tout terminal ouvert.

## Installation sur Linux

Sur Linux, la méthode d'installation peut varier légèrement en fonction de votre distribution. Vous pouvez utiliser un gestionnaire de paquets ou installer le binaire manuellement.

### Option 1 : Via un Gestionnaire de Paquets

*   **Debian/Ubuntu** (peut ne pas être la dernière version) :
    ```bash
    sudo apt update
    sudo apt install hugo
    ```
    Pour obtenir une version plus récente, vous pourriez avoir besoin de télécharger le `.deb` depuis la page des Releases GitHub ou d'utiliser Snap.

*   **Fedora** :
    ```bash
    sudo dnf install hugo
    ```

*   **Arch Linux** :
    ```bash
    sudo pacman -S hugo
    ```

*   **Snap** (disponible sur de nombreuses distributions et souvent à jour) :
    ```bash
    sudo snap install hugo --channel=extended
    ```
    Pour mettre à jour : `sudo snap refresh hugo`

### Option 2 : Installation Manuelle du Binaire

1.  Visitez la page [Releases de Hugo sur GitHub](https://github.com/gohugoio/hugo/releases).
2.  Téléchargez l'archive appropriée pour votre architecture (généralement `hugo_extended_X.Y.Z_linux-amd64.tar.gz`).
3.  Extrayez l'archive :
    ```bash
    tar -zxvf hugo_extended_0.147.3_linux-arm64.tar.gz
    ```
    Cela créera un fichier binaire `hugo`.
4.  Déplacez ce fichier dans un répertoire de votre PATH, comme `/usr/local/bin` :
    ```bash
    sudo mv hugo /usr/local/bin/
    ```

## Option Avancée : Installation depuis les Sources (Nécessite Go)

Si vous souhaitez la toute dernière version de développement ou si vous avez des besoins spécifiques, vous pouvez compiler Hugo depuis les sources. Cela nécessite une installation fonctionnelle de Go (version 1.19 ou supérieure recommandée).

1.  **Installer Go** :
    Suivez les instructions sur le [site officiel de Go](https://golang.org/doc/install). Assurez-vous que votre `GOPATH` et `GOROOT` sont correctement configurés et que le répertoire `bin` de Go est dans votre PATH.
    Sur Linux, par exemple :
    ```bash
    # Télécharger et extraire Go (vérifier la dernière version)
    wget https://golang.org/dl/go1.22.3.linux-amd64.tar.gz
    sudo tar -C /usr/local -xzf go1.22.3.linux-amd64.tar.gz
    # Ajouter au PATH (par exemple dans ~/.bashrc ou ~/.zshrc)
    export PATH=$PATH:/usr/local/go/bin
    source ~/.bashrc # ou ~/.zshrc
    ```

2.  **Cloner le dépôt Hugo** :
    ```bash
    git clone https://github.com/gohugoio/hugo.git
    cd hugo
    ```

3.  **Compiler Hugo** :
    ```bash
    go install --tags extended
    ```
    Le binaire `hugo` sera installé dans votre répertoire `$GOPATH/bin` (ou `$HOME/go/bin` par défaut avec les versions récentes de Go).

## Vérification de l'Installation

Quelle que soit la méthode utilisée, vous pouvez vérifier que Hugo est correctement installé et connaître sa version en ouvrant un nouveau terminal et en tapant :

```bash
hugo version
```

Vous devriez voir quelque chose comme :

```bash
# Forme générale
# hugo v0.125.7-phk۷۷۷۷۷۷۷+extended linux/amd64 BuildDate=YYYY-MM-DDTHH:MM:SSZ VendorInfo=gohugoio
# Exemple : 
# hugo v0.147.2+extended+withdeploy darwin/amd64 BuildDate=2025-05-06T11:18:55Z VendorInfo=brew
```

L'important est de voir une version s'afficher et, idéalement, la mention `extended` si vous avez installé cette variante (recommandée pour le thème PaperMod qui peut utiliser SASS/SCSS).

Vous êtes maintenant prêt à créer votre premier site Hugo ! Dans la section suivante, nous allons initialiser un nouveau projet et y intégrer le thème PaperMod.

