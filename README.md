# Mah-entrainement

Projet d'entraînement personnel - Application Ruby MVC.

## Structure du projet

```
project_name/
├── bin/                    # CLI et exécutables
│   └── console             # Point d'entrée CLI principal
├── app/
│   ├── controllers/        # Gestionnaires de requêtes
│   ├── models/             # Logique métier
│   └── views/              # Templates (ERB)
├── config/
│   ├── environment.rb      # Charge toutes les dépendances
│   ├── routes.rb           # Routage URL
│   └── database.yml        # Configuration base de données
├── db/
│   ├── migrate/            # Migrations base de données
│   └── seeds.rb            # Données initiales
├── lib/
│   ├── services/           # Logique métier réutilisable
│   ├── helpers/            # Utilitaires views/controllers
│   └── tasks/              # Rake tasks
├── public/                 # Assets statiques
├── spec/                   # Tests RSpec
├── Gemfile                 # Dépendances Ruby
└── .env                    # Variables d'environnement
```

## Démarrage

1. Installer les dépendances:
```bash
bundle install
```

2. Configurer l'environnement:
```bash
cp .env.example .env
# Éditer .env avec vos paramètres
```

3. Configurer la base de données:
```bash
bin/console db:migrate
bin/console db:seed
```

## Utilisation

### Commandes CLI

```bash
# Démarrer le serveur
bin/console server

# Ouvrir la console interactive
bin/console console

# Exécuter les migrations
bin/console db:migrate

# Peupler la base de données
bin/console db:seed

# Afficher les routes
bin/console routes

# Aide
bin/console help
```

### Lancer les tests

```bash
bundle exec rspec
```

### Style de code

```bash
bundle exec rubocop
```

## Architecture

### Controllers
Gèrent les requêtes HTTP et coordonnent entre models et views.

### Models
Contiennent la logique métier et la validation des données.

### Views
Templates ERB pour le rendu HTML.

### Services
Encapsulent les opérations métier complexes (email, paiements, etc.).

### Helpers
Méthodes utilitaires pour le formatage et les opérations communes.

## Auteur

Emje26

## Licence

MIT
