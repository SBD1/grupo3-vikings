#!/bin/bash
# Basta colocar a nova procedure e/ou trigger na pasta src/scripts
psql -U $POSTGRES_USER -d $POSTGRES_DB -a -f /scripts/ddl.sql

for FILE in /scripts/trigger_functions/*.sql; do 
  psql -U $POSTGRES_USER -d $POSTGRES_DB -a -f $FILE
done

for FILE in /scripts/procedures/*.sql; do 
  psql -U $POSTGRES_USER -d $POSTGRES_DB -a -f $FILE
done

psql -U $POSTGRES_USER -d $POSTGRES_DB -a -f /scripts/dml.sql