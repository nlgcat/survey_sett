#!/bin/bash

if [ -t 0 ]; then stty -echo -icanon -icrnl time 0 min 0; fi

count=1
keypress=''
while [ "x$keypress" = "x" ]; do
  if (( $count % 2 == 0 ))           # no need for brackets
  then
    date
    #PGPASSWORD=voodoo13 psql -U postgres -d barts_development -a -f trim.sql -h 127.0.0.1
    #PGPASSWORD=voodoo13 psql -U postgres -d barts_development -a -f discard.sql -h 127.0.0.1
  fi
  echo "--running $count"
  rm -f log/development.log
  rake evaluation:generate
  let count+=1
  echo -ne $count'\r'
  keypress="`cat -v`"
done

if [ -t 0 ]; then stty sane; fi

# PGPASSWORD=voodoo13 psql -U postgres -d barts_development -a -f trim.sql -h 127.0.0.1
# PGPASSWORD=voodoo13 psql -U postgres -d barts_development -a -f discard.sql -h 127.0.0.1

echo "You pressed '$keypress' after $count loop iterations"
echo "Thanks for using this script."

exit 0
