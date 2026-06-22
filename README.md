# docker-unit

Docker image založený na [FreeUnit](https://github.com/freeunitorg/freeunit) (PHP 8.5) s předinstalovanými nástroji (Composer, supervisor, sendmail, …) a PHP rozšířeními (`intl`, `pdo_mysql`, `sockets`, `zip`).

Image je publikován na Docker Hubu jako [`appsdevteam/unit`](https://hub.docker.com/r/appsdevteam/unit) pro platformy `linux/amd64` a `linux/arm64`. Dostupné tagy: `latest`, `8.5` a `8.4`.

## Build

Pro build multi-arch image (amd64 + arm64) se používá [`docker buildx`](https://docs.docker.com/build/building/multi-platform/).

### 1. Vytvoření builderu (jednorázově)

```sh
docker buildx create --name multiplatform --driver docker-container --use
docker buildx inspect --bootstrap
```

### 2. Build a push na Docker Hub

Je potřeba být přihlášen k Docker Hubu s právy do organizace `appsdevteam`:

```sh
docker login
```

Build pro obě architektury a push:

```sh
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t appsdevteam/unit:latest \
  -t appsdevteam/unit:8.5 \
  --push .
```

> Multi-arch image nelze pouze `--load` do lokálního Dockeru – musí se rovnou pushnout do registru (`--push`).

### 3. Ověření

```sh
docker buildx imagetools inspect appsdevteam/unit:latest
```

Ve výpisu musí být obě platformy `linux/amd64` i `linux/arm64`.

## Lokální build pro jednu architekturu

Pokud potřebuješ image jen pro otestování na aktuálním stroji:

```sh
docker build -t appsdevteam/unit:latest .
```
