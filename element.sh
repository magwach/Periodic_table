#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
elif [[ ! -z $1 ]]
then
  input="$1"
  if [[ "$1" =~ ^[0-9]+$ ]]
  then
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements FULL JOIN properties USING(atomic_number) WHERE atomic_number = $1;")
    NAME=$($PSQL "SELECT name FROM elements FULL JOIN properties USING(atomic_number) WHERE atomic_number = $1;")
    SYMBOL=$($PSQL "SELECT symbol FROM elements FULL JOIN properties USING(atomic_number) WHERE atomic_number = $1;")
    TYPE=$($PSQL "SELECT type FROM properties FULL JOIN types USING (type_id) WHERE atomic_number = $1;")
    MASS=$($PSQL "SELECT atomic_mass FROM properties FULL JOIN elements USING(atomic_number) WHERE atomic_number = $1;")
    MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties FULL JOIN elements USING(atomic_number) WHERE atomic_number = $1;")
    BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties FULL JOIN elements USING(atomic_number) WHERE atomic_number = $1;")

    if [[ -z $ATOMIC_NUMBER ]]
    then
      echo "I could not find that element in the database."
    else
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    fi

  elif [[ ${#input} -gt 1 || ${#input} -eq 1 ]]
  then
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements FULL JOIN properties USING(atomic_number) WHERE name = '$1';")
    NAME=$($PSQL "SELECT name FROM elements FULL JOIN properties USING(atomic_number) WHERE name = '$1';")
    SYMBOL=$($PSQL "SELECT symbol FROM elements FULL JOIN properties USING(atomic_number) WHERE name = '$1';")
    TYPE=$($PSQL "SELECT type FROM properties FULL JOIN types USING (type_id) FULL JOIN elements USING(atomic_number) WHERE name = '$1';")
    MASS=$($PSQL "SELECT atomic_mass FROM properties FULL JOIN elements USING(atomic_number) WHERE name = '$1';")
    MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties FULL JOIN elements USING(atomic_number) WHERE name = '$1';")
    BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties FULL JOIN elements USING(atomic_number) WHERE name = '$1';")

    if [[ -z $ATOMIC_NUMBER ]]
    then
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements FULL JOIN properties USING(atomic_number) WHERE symbol = '$1';")
    NAME=$($PSQL "SELECT name FROM elements FULL JOIN properties USING(atomic_number) WHERE symbol = '$1';")
    SYMBOL=$($PSQL "SELECT symbol FROM elements FULL JOIN properties USING(atomic_number) WHERE symbol = '$1';")
    TYPE=$($PSQL "SELECT type FROM properties FULL JOIN types USING (type_id) FULL JOIN elements USING(atomic_number) WHERE symbol = '$1';")
    MASS=$($PSQL "SELECT atomic_mass FROM properties FULL JOIN elements USING(atomic_number) WHERE symbol = '$1';")
    MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties FULL JOIN elements USING(atomic_number) WHERE symbol = '$1';")
    BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties FULL JOIN elements USING(atomic_number) WHERE symbol = '$1';")
    fi
  
    if [[ -z $ATOMIC_NUMBER ]]
      then
        echo "I could not find that element in the database."
      else
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    fi
  fi

else
  echo "I could not find that element in the database."

fi
