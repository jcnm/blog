---
date: '2025-05-16T16:27:28+02:00'
draft: false
title: 'Configuration de Votre Site avec Hugo et le Thème PaperMod'
tags: ["hugo", "web", "blog", "static", "exploration"]
categories: ["Tutoriel", "Adoption"]
series: ["Hugo Introduction"]
ShowPostNavLinks: true
cover:
  image: "/jcnm/initialisation-configuration-hugo-site.png"
  alt: "Configuration de Hugo le moteur generateur de site"
---

## Configuration de Votre Site avec Hugo et le Thème PaperMod

Avec Hugo installé, nous pouvons maintenant créer la structure de notre nouveau site et y intégrer le thème PaperMod. Ce thème est apprécié pour sa simplicité, sa rapidité, son design épuré et ses nombreuses fonctionnalités, y compris un bon support pour le multilinguisme.

### 1. Initialisation d'un Nouveau Site Hugo

Ouvrez votre terminal ou invite de commandes, naviguez jusqu'au répertoire où vous souhaitez créer votre site (par exemple, `~/Sites` ou `C:\Users\VotreNom\Documents\Sites`), puis exécutez la commande suivante pour créer un nouveau site Hugo. Remplacez `mon-nouveau-site` par le nom que vous souhaitez donner à votre projet :

```bash
hugo new site mon-nouveau-site --format yaml # l'option format permet de fixer le format yaml
```

Cette commande crée un nouveau dossier nommé `mon-nouveau-site` (ou le nom que vous avez choisi) avec la structure de base d'un projet Hugo :

```
mon-nouveau-site/
├── archetypes/
│   └── default.md
├── assets/
├── content/
├── data/
├── i18n/
├── layouts/
├── static/
├── themes/
└── hugo.toml  # (ou config.toml / config.yaml selon la version de Hugo et vos préférences)
```

Naviguez dans le répertoire de votre nouveau site :

```bash
cd mon-nouveau-site
```

**Note sur le fichier de configuration :** Les versions récentes de Hugo utilisent `hugo.toml` par défaut. Si vous voyez `config.toml`, c'est également correct. La syntaxe TOML, YAML (`config.yaml` ou `hugo.yaml`) ou JSON (`config.json` ou `hugo.json`) peut être utilisée. 
Pour la suite de cet article, nous utiliserons principalement la syntaxe YAML dans un fichier nommé `hugo.yaml` pour sa lisibilité, mais les exemples seront facilement adaptables en TOML si vous préférez `hugo.toml`.
Si votre site a été créé avec `hugo.toml`, vous pouvez le renommer en `hugo.yaml` et adapter la syntaxe, ou continuer avec TOML.

### 2. Installation du Thème PaperMod

Il existe deux méthodes principales pour installer un thème Hugo : en tant que submodule Git (recommandé si votre projet est sous Git) ou par téléchargement manuel.

#### Option 1 : Installation via Submodule Git (Recommandé)

Cette méthode est la plus propre si vous prévoyez d'utiliser Git pour gérer votre projet. Elle facilite les mises à jour du thème.

1.  **Initialisez un dépôt Git** dans le répertoire de votre site (si ce n'est pas déjà fait) :
    ```bash
    git init
    ```

2.  **Ajoutez le thème PaperMod comme submodule** :
    Exécutez la commande suivante à la racine de votre projet Hugo (`mon-nouveau-site`) :
    ```bash
    git submodule add --depth=1 https://github.com/adityatelange/hugo-PaperMod.git themes/PaperMod
    ```
    Cela clone le thème dans le dossier `themes/PaperMod`.

3.  **Mettre à jour le thème** (plus tard) :
    Pour récupérer la dernière version du thème, vous pourrez utiliser :
    ```bash
    git submodule update --remote --merge
    ```
  Si vous n'êtes pas à l'aise avec les submodule, téléchargez et installez manuellement.

#### Option 2 : Installation Manuelle (Téléchargement)

Si vous n'utilisez pas Git, vous pouvez télécharger le thème manuellement.

1.  Allez sur la page GitHub du thème PaperMod : [https://github.com/adityatelange/hugo-PaperMod](https://github.com/adityatelange/hugo-PaperMod).
2.  Cliquez sur le bouton "Code" puis "Download ZIP".
3.  Extrayez l'archive ZIP.
4.  Renommez le dossier extrait (par exemple, `hugo-PaperMod-master`) en `PaperMod`.
5.  Copiez ce dossier `PaperMod` dans le répertoire `themes/` de votre site Hugo.
    Vous devriez avoir `themes/PaperMod/`.

### 3. Configuration de Base du Thème

Nous allons opter pour une structure de configuration modulaire, comme vu dans nos notes sur le multilinguisme, en utilisant un dossier `config/_default/`.

Créez les dossiers et fichiers suivants si ce n'est pas déjà fait :

```
mon-nouveau-site/
├── config/
│   └── _default/
│       ├── config.yaml
│       ├── languages.yaml
│       └── params.yaml
│       └── menus.fr.yaml # Pour le menu français
│       └── menus.en.yaml # Pour le menu anglais
├── content/
├── themes/
│   └── PaperMod/
└── hugo.yaml  # Fichier principal, peut être minimal
```

Une fois le thème installé, vous devez indiquer à Hugo de l'utiliser. Ouvrez votre fichier de configuration principal (par exemple, `hugo.yaml` ou `hugo.toml` à la racine de votre site) et ajoutez/modifiez les lignes suivantes.

**Contenu de `hugo.yaml` (fichier principal à la racine) :**

```yaml
# hugo.yaml
baseURL: "https://sylorion.com/jcnm" # Remplacez par votre URL finale
title: Mon Super Site

# Active la configuration depuis le dossier config/_default
# Pas besoin de ligne explicite, Hugo le fait par défaut si le dossier existe
# et si ce fichier est minimaliste.

# Si vous n'utilisez pas la structure de config éclatée, mettez tout ici.
# Par exemple, pour juste activer le thème :
# theme: "PaperMod"
```

**Contenu de `config/_default/config.yaml` :**

```yaml
# config/_default/config.yaml

theme: "PaperMod"
enableRobotsTXT: true
buildFuture: false
buildExpired: false
paginator:
  pagesToKeepInMemory: 10 # Ajustez selon vos besoins
  paginate: 5 # Nombre d'articles par page pour les listes

defaultContentLanguage: "fr" # Langue par défaut
defaultContentLanguageInSubdir: false # true si vous voulez /fr/ pour la langue par défaut

# Active les langues que nous allons définir dans languages.yaml
languages:
  fr:
    disabled: false
  en:
    disabled: false

# Configuration pour la sortie HTML (nécessaire pour certains shortcodes ou fonctionnalités)
outputs:
  home: ["HTML", "RSS", "JSON"] # JSON pour la recherche PaperMod
  page: ["HTML"]
  section: ["HTML", "RSS"]
  taxonomy: ["HTML", "RSS"]
  term: ["HTML", "RSS"]

# Configuration du moteur de rendu Markdown (Goldmark)
markup:
  goldmark:
    renderer:
      unsafe: true # Nécessaire pour permettre les iframes (ex: Google Form)
  highlight:
    noClasses: false
    # codeFences: true
    # guessSyntax: true
    # lineNos: true
    # style: monokai # Choisissez un style de coloration syntaxique
```

**Contenu de `config/_default/languages.yaml` :**
(Nous reprendrons et affinerons cette partie dans la section dédiée au multilinguisme, mais voici une base)

```yaml
# config/_default/languages.yaml

fr:
  languageName: "Français"
  languageCode: "fr-FR"
  weight: 1
  title: "Mon Site PaperMod"
  params:
    description: "Description de mon site en français."
    label:
      text: "Accueil"
      # icon: /assets/img/home_fr.png # Optionnel
      # iconHeight: 35
  # Les menus seront dans menus.fr.yaml

en:
  languageName: "English"
  languageCode: "en-US"
  weight: 2
  title: "My PaperMod Site"
  params:
    description: "My site description in English."
    label:
      text: "Home"
      # icon: /assets/img/home_en.png # Optionnel
      # iconHeight: 35
  # Les menus seront dans menus.en.yaml
```

**Contenu de `config/_default/params.yaml` (paramètres globaux du thème PaperMod) :**

```yaml
# config/_default/params.yaml

env: production # Mettre à "development" pour le développement local si besoin

# Profil (barre latérale)
profileMode:
  enabled: true # Mettre à false pour désactiver le mode profil
  title: "Mon Nom / Nom du Site"
  subtitle: "Ma Super Devise ou Description Courte"
  imageUrl: "/images/profile.png" # Placez une image dans static/images/profile.png
  imageWidth: 120
  imageHeight: 120
  imageTitle: "Mon image de profil"
  buttons:
    - name: Articles
      url: "/posts"
    - name: À Propos
      url: "/about"

# Paramètres généraux du thème
ShowReadingTime: true
ShowShareButtons: true
ShowPostNavLinks: true
ShowBreadCrumbs: true
ShowCodeCopyButtons: true
ShowWordCount: true
ShowRssButtonInSectionTermList: true
UseHugoToc: true # Table des matières générée par Hugo

# Pour le sélecteur de langue
ShowLanguageSwitcher: true

# Favicons, etc.
assets:
  favicon: "/images/favicon.ico"
  favicon16x16: "/images/favicon-16x16.png"
  favicon32x32: "/images/favicon-32x32.png"
  apple_touch_icon: "/images/apple-touch-icon.png"
  safari_pinned_tab: "/images/safari-pinned-tab.svg"

# Paramètres pour la recherche (si activée dans PaperMod)
outputs:
  home: ["HTML", "RSS", "JSON"] # Nécessaire pour la recherche

# Paramètres pour les commentaires (exemple avec Disqus, à adapter)
# disqusShortname: "votreshortnamedisqus"

# Icônes sociales (exemple)
socialIcons:
  - name: "github"
    url: "https://github.com/votreprofil"
  - name: "twitter"
    url: "https://twitter.com/votreprofil"
  - name: "linkedin"
    url: "https://linkedin.com/in/votreprofil"

# Analytics (exemple avec Google Analytics)
# googleAnalytics: 'UA-XXXXXXXX-X'

# Paramètres pour la page d'accueil
homeInfoParams:
  Title: "👋 Bonjour !"
  Content: "Bienvenue sur mon nouveau site propulsé par Hugo et PaperMod. Explorez mes articles et n'hésitez pas à me contacter."

# D'autres paramètres spécifiques à PaperMod peuvent être ajoutés ici.
# Consultez la documentation de PaperMod pour une liste exhaustive.
# https://github.com/adityatelange/hugo-PaperMod/wiki/Variables
```

N'oubliez pas de créer les images référencées (profile.png, favicons) et de les placer dans le dossier `static/images/`.

### 4. Création d'un Premier Article (Test)

Pour vérifier que tout fonctionne, créons un premier article.

```bash
hugo new posts/mon-premier-article.md
```

Ouvrez le fichier `content/posts/mon-premier-article.md` et modifiez-le :

```markdown
---
title: "Mon Premier Article avec PaperMod"
date: 2025-05-14T14:00:00+02:00
draft: false # Mettez à true pour ne pas le publier tout de suite
tags: ["hugo", "premier article"]
categories: ["Débuts"]
summary: "Ceci est un résumé de mon tout premier article utilisant Hugo et PaperMod."
---

Bienvenue sur mon blog ! Ceci est mon premier article. Hugo est **rapide** et PaperMod est *élégant*.

## Une sous-section

Un peu de contenu ici.
```

### 5. Lancement du Serveur de Développement Hugo

À la racine de votre projet, lancez le serveur de développement Hugo :

```bash
hugo server
```

Ou, si vous voulez inclure les brouillons (articles avec `draft: true`) :

```bash
hugo server -D
```

Hugo va compiler votre site et le rendre disponible localement, généralement à l'adresse `http://localhost:1313/`. Ouvrez cette URL dans votre navigateur. Vous devriez voir votre site avec le thème PaperMod et votre premier article.

### 6. Création de la Page de Contact Multilingue avec Google Form

Comme demandé, nous allons créer une page de contact qui intègre un formulaire Google Form, avec une version pour chaque langue.

1.  **Créez vos Google Forms** :
    *   Allez sur [Google Forms](https://docs.google.com/forms) et créez deux formulaires : un en français et un en anglais.
    *   Personnalisez-les selon vos besoins (champs, questions, etc.).
    *   Une fois un formulaire créé, cliquez sur le bouton "Envoyer" (ou "Send").
    *   Choisissez l'onglet `< >` (Intégrer HTML).
    *   Copiez le code `<iframe>` fourni. Faites cela pour les deux formulaires.

2.  **Créez les fichiers de contenu pour les pages de contact** :

    *   Pour le français : `content/fr/contact.md`
        Créez ce fichier et ajoutez le contenu suivant, en remplaçant `URL_GOOGLE_FORM_FRANCAIS` par le code iframe de votre formulaire français :

        ```markdown
        ---
        title: "Contactez-nous"
        layout: "page" # Utilise le layout de page par défaut de PaperMod
        slug: "contact"
        # Vous pouvez ajouter d'autres métadonnées si nécessaire
        # Par exemple, pour ne pas l'inclure dans les listes d'articles classiques :
        # menu: "main"
        # weight: -10 # Pour le placer à la fin du menu si vous l'ajoutez au menu principal
        # headless: true # Si vous ne voulez pas qu'elle apparaisse dans les listes de pages
        ---

        ## Nous Contacter

        N'hésitez pas à nous laisser un message en utilisant le formulaire ci-dessous.

        <!-- Intégrez ici le code iframe de votre Google Form Français -->
        <div class="google-form-container">
          <iframe src="URL_GOOGLE_FORM_FRANCAIS_CORRECTE_EXTRAITE_DE_L_IFRAME" width="100%" height="800" frameborder="0" marginheight="0" marginwidth="0">Chargement…</iframe>
        </div>
        ```

    *   Pour l'anglais : `content/en/contact.md`
        Créez ce fichier et ajoutez le contenu suivant, en remplaçant `URL_GOOGLE_FORM_ANGLAIS` par le code iframe de votre formulaire anglais :

        ```markdown
        ---
        title: "Contact Us"
        layout: "page"
        slug: "contact"
        ---

        ## Get in Touch

        Feel free to leave us a message using the form below.

        <!-- Intégrez ici le code iframe de votre Google Form Anglais -->
        <div class="google-form-container">
          <iframe src="URL_GOOGLE_FORM_ANGLAIS_CORRECTE_EXTRAITE_DE_L_IFRAME" width="100%" height="800" frameborder="0" marginheight="0" marginwidth="0">Loading…</iframe>
        </div>
        ```

    **Important concernant l'iframe** : Google Forms vous donne un code `<iframe src="URL_ICI" ...></iframe>`. Vous devez extraire uniquement l'URL qui est dans l'attribut `src` et la mettre dans l'exemple ci-dessus. Assurez-vous que `markup.goldmark.renderer.unsafe: true` est bien dans votre `config/_default/config.yaml` pour que l'iframe s'affiche.

3.  **Ajoutez les pages de contact aux menus** (optionnel, mais recommandé) :
    Modifiez `config/_default/menus.fr.yaml` :
    ```yaml
    # config/_default/menus.fr.yaml
    main:
      - identifier: contact
        name: Contact
        url: /contact/
        weight: 50
      # ... autres entrées de menu pour le français
    ```
    Modifiez `config/_default/menus.en.yaml` :
    ```yaml
    # config/_default/menus.en.yaml
    main:
      - identifier: contact
        name: Contact
        url: /en/contact/ # Notez le /en/ ici si defaultContentLanguageInSubdir est false
        weight: 50
      # ... autres entrées de menu pour l'anglais
    ```
    Si `defaultContentLanguageInSubdir` est `true`, l'URL pour l'anglais serait `/en/contact/` et pour le français `/fr/contact/`.
    Si `defaultContentLanguageInSubdir` est `false` (comme dans notre exemple), l'URL pour le français est `/contact/` et pour l'anglais `/en/contact/`.

    Relancez `hugo server` si besoin. Vous devriez maintenant avoir des pages de contact fonctionnelles dans les deux langues, accessibles via les menus (si configurés) ou directement par leur URL (par exemple, `http://localhost:1313/contact/` et `http://localhost:1313/en/contact/`).

Vous avez maintenant un site Hugo fonctionnel avec le thème PaperMod, une configuration de base, un premier article, et une page de contact multilingue. Dans la section suivante, nous allons approfondir la configuration multilingue pour l'ensemble du site.

