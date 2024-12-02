# Life Lens

Lifestyle Checker is a web application that allows users to check their lifestyle and get a score.

Built using the latest version of Ruby (3.3.6) and Rails (8.0.0).

## Getting started

Create a `.env` file containing `RAILS_MASTER_KEY` in order to access the API token.

### Installation

Recommended install with `Docker`, `docker-compose` and `ASDF`. 

### Development

1. `$ asdf install ruby latest` 
1. `$ bundle install` 
1. `$ docker-compose up db`
1. `$ rails db:prepare`
1. `$ rails db:seed` - replace questions
1. `$ rails server`
1. `$ rails notes -a WIP` - read inline notes
1. `$ bundle exec yard` - compile HTML documentation open `doc/index.html`

### Test

1. `$ rspec`

### Production

1. `$ docker-compose up`

## ADRs

- [ADR 0001](file.0001-use-docker-compose.html)
- [ADR 0002](file.0002-use-rspec-for-testing.html)
- [ADR 0003](file.0003-use-slim-for-templates.html)
- [ADR 0004](file.0004-use-factory-bot-for-testing.html)

---

## Candidate

Peter Hamilton

> FYI there is a spelling mistake of "eligble" in the problem README.