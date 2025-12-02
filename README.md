# Mah-entrainement

Application Ruby on Rails 7.1 - Projet d'entraînement personnel.

## Prérequis

- Ruby >= 3.0.0
- SQLite3 (développement) / PostgreSQL (production)
- Node.js (pour les assets)

## Installation

1. Cloner le dépôt:
```bash
git clone <repository-url>
cd Mah-entrainement
```

2. Installer les dépendances:
```bash
bundle install
```

3. Configurer l'environnement:
```bash
cp .env.example .env
# Éditer .env avec vos paramètres
```

4. Configurer la base de données:
```bash
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed
```

## Démarrage

```bash
# Démarrer le serveur de développement
bin/rails server

# Ou avec foreman (pour le développement complet)
bin/dev
```

L'application sera disponible sur http://localhost:3000

## Commandes utiles

```bash
# Console Rails
bin/rails console

# Migrations
bin/rails db:migrate
bin/rails db:rollback
bin/rails db:seed

# Routes
bin/rails routes

# Tests
bundle exec rspec

# Linting
bundle exec rubocop
```

## Structure du projet

```
Mah-entrainement/
├── app/
│   ├── assets/           # CSS, JS, images
│   ├── channels/         # Action Cable
│   ├── controllers/      # Contrôleurs
│   ├── helpers/          # Helpers de vues
│   ├── javascript/       # JavaScript (Stimulus)
│   ├── jobs/             # Active Job
│   ├── mailers/          # Action Mailer
│   ├── models/           # Modèles ActiveRecord
│   └── views/            # Vues ERB
├── bin/                  # Exécutables
├── config/               # Configuration Rails
│   ├── environments/     # Config par environnement
│   ├── initializers/     # Initializers
│   └── locales/          # I18n (fr, en)
├── db/
│   ├── migrate/          # Migrations
│   ├── schema.rb         # Schéma DB
│   └── seeds.rb          # Données initiales
├── lib/
│   ├── services/         # Services métier
│   ├── helpers/          # Helpers partagés
│   └── tasks/            # Rake tasks
├── public/               # Fichiers statiques
├── spec/                 # Tests RSpec
├── storage/              # Active Storage
├── Gemfile               # Dépendances Ruby
└── config.ru             # Configuration Rack
```

## Fonctionnalités

- **Authentification** : Système de login/logout avec bcrypt
- **Utilisateurs** : CRUD complet avec validation
- **Articles** : Gestion d'articles avec publication
- **Internationalisation** : Support français/anglais
- **Hotwire** : Turbo + Stimulus pour l'interactivité

## Tests

```bash
# Tous les tests
bundle exec rspec

# Tests spécifiques
bundle exec rspec spec/models/
bundle exec rspec spec/controllers/
bundle exec rspec spec/requests/
```

## Déploiement

1. Configurer les variables d'environnement de production
2. Compiler les assets: `bin/rails assets:precompile`
3. Migrer la base de données: `bin/rails db:migrate`

## Identifiants de test (après db:seed)

- **Admin**: admin@example.com / password123
- **User**: alice@example.com / password123

## Auteur

Emje26

## Licence

MIT
