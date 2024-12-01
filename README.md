# README

## Getting started

Create `.env` file containing `RAILS_MASTER_KEY`

### Installation

Install `Docker`, `docker-compose` and `ASDF`. 

### Development

1. `$ asdf install ruby latest` (3.3.6)
1. `$ bundle install` 
1. `$ docker-compose up db`
1. `$ rails db:prepare`
1. `$ rails server`

### Test

1. `$ rspec`

### Production

1. `$ docker-compose up`

## ADRs

- [ADR 0001](adr/0001-use-docker-compose.md)
- [ADR 0002](adr/0002-use-rspec-for-testing.md)
- [ADR 0003](adr/0003-use-slim-for-templates.md)
- [ADR 0004](adr/0004-use-factory-bot-for-testing.md)