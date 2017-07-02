# Twitter Clone in Kingfisher

## Setup Database

Install PostgreSQL then creates a database for development:

```
$ createdb twitter_dev
```

create user table:

```
$ psql -d twitter_dev

twitter_dev=# CREATE TABLE "user" (
  id bigint primary key,
  email varchar(255) not null,
  password_digest varchar(255) not null
);
```

## Start Server

```
$ bin/kingfisher s
```

## Run Tests

```
$ createdb twitter_test
```

```
$ psql -d twitter_test

twitter_test=# CREATE TABLE "user" (
  id bigint primary key,
  email varchar(255) not null,
  password_digest varchar(255) not null
);
```

```
$ rspec
```
