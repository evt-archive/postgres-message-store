# message_store-postgres-database

Message store PostgreSQL database definition

## Usage

### Install the Message Store Database
```
evt-pg-create-db
```

### Delete the Message Store Database
```
evt-pg-delete-db
```

### Recreate the Message Store Database
```
evt-pg-recreate-db
```

### Print the Messages Stored the Message Store Database
```
evt-pg-print-messages
```

## Database Definition Script Files

The database is defined by raw SQL scripts. You can examine them, or use them directly with the `psql` command line tool, at:

[https://github.com/eventide-project/message-store-postgres-database/tree/master/database](https://github.com/eventide-project/message-store-postgres-database/tree/master/database)

## License

The `message_store-postgres-database` library is released under the [MIT License](https://github.com/eventide-project/message-store-postgres-database/blob/master/MIT-License.txt).