## Contacts Importer

This application uploads csv files that contains contacts, then process in a background job to import the contacts to the database. The system makes several validations and if a record not pass the validation it will be send to the Log.

This app uses Active Storage in local environment for upload the csv files.

Before anything action you must sign up in the app.

### Instalation Requirements

- Ruby 3.1.1
- PostgreSQL 14.2
- Rails 7.0.3.1
- Redis 7.0.2

## Csv example files
In the root directory you will find two csv files.
contacts-example1.csv
contacts-example2.csv

## Installation

Clone the repo locally:

```sh
git clone https://github.com/jsalguero94/contacts-importer-rails.git
cd contacts-importer-rails
```

Use develop branch:

```sh
git checkout develop
```
Bundle install:

```sh
bundle
```

Create database

```sh
rails db:create
```

Migrate tables

```sh
rails db:migrate
```
Run tests

```sh
rspec
```
See the coverage

```sh
open coverage/index.html
```
Run server

```sh
bin/dev
```
Run sidekiq
*in other terminal*
```sh
bundle exec sidekiq
```

