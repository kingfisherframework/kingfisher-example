# Twitter Clone in Kingfisher

## Setup Database

```
$ sqlite3 data/repo.sql
```

create user table:

```sql
CREATE TABLE user(id integer PRIMARY KEY, email text NOT NULL, password_digest text NOT NULL);
```

## Start Server

```
$ bin/kingfisher s
```
