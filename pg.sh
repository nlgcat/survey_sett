#!/bin/bash
rake db:drop
rake db:create
PGPASSWORD=voodoo13 pg_restore -U postgres -d barts_development -Fc ~/db487.bak  -h 127.0.0.1
PGPASSWORD=voodoo13 psql -U postgres -d barts_development -a -f trim.sql -h 127.0.0.1
PGPASSWORD=voodoo13 psql -U postgres -d barts_development -a -f discard.sql -h 127.0.0.1
