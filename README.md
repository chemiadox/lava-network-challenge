# Coding challenge
## Task
Build a microservice that periodically fetches, caches, and serves cryptocurrency prices
from a public API, with the option to use either Node.js or Golang.
## Resources
- Node.js / Typescript / Express https://expressjs.com/
- Docker / Compose https://docs.docker.com/compose/
- Dragonfly https://www.dragonflydb.io/
- PostreSQL https://www.postgresql.org/
- Prisma https://www.prisma.io/
- CoinGecko public API https://www.coingecko.com/api/documentation

## Results
### `Endpoints`
  - [x] `GET /coins` returns information from the CoinGecko but limited with tracked currencies (see `trackedCoins.ts`). A complete list of ~8000 coins/tokens is far out of the scope of this task
  - [x] `GET /coins/<symbol>` returns detailed information about tracked coin from CoinGecko
  - [x] `GET /coins/<symbol>/history` returns historical data for selected coin. Historical data is being returned from the CoinGecko API as well as this service database has not enough history.
  - [x] `GET /coins/<symbol>/subscribe` subscribes a mocked user to track the price change on specific coin.
  - [ ] `GET /convert/<from>/<to>` is not finished, but the endpoint exists, returning false data

### `Datasource`
  CoinGecko public API is being used as a source of truth. Unfortunately it supports enormous amount of existing tokens, many of them have the same `symbol` (trash-coins etc.). To avoid coincidences it works with coin id, thus id mapping was introduced, and amount of tracked coins was limited

### `Caching`
  To reduce the number if requests to the limited API endpoints, Dragonfly (Redis) was used with timeouts set according to the GoinGeco official documentation.

### `Database`
  Simple schema was used to store history and subscriptions in the PostgreSQL instance. Prisma is used as a declarative ORM. 

### `Error handling`
  Partial error handling with custom logger implemented. However it looks more like boilerplate and needs to be implemented with more serious instruments

### `Rate limiting`
  Implemented as simple limiting middleware. User is mocked and static, so limits currently apply to all requests to the service. Current limit is set via configuration and equals to 3 requests per minute within sliding window.

### Bonus
- [x] Simple notification is implemented with the fixed threshold set to 10%. Notification is being printed to the console
- [x] Application is fully containerized with `Docker`/`Compose`
- [ ] Units test are not implemented
- [ ] Convert endpoint is provided, but not implemented

## Requirements:
- installed Docker with Compose plugin

### Run
```bash
# need to install dependencies in order to get prisma working
npm i
# run postgres container
docker compose up postgres -d 
# init prisma (creates database and runs migrations)
prisma migrate dev --name init
# run containers
docker compose up
```

### Rebuild
```bash
docker compose up --build
```

### Run on the host machine (however services should run containerized)
```bash
# Run Postgres instance
docker compose up posgres -d
# Run Dragonfly instance
docker compose up
# Run project in watch mode
npm run dev 
```