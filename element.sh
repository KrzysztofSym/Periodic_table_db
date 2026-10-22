#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
ATOMIC_NO=$1
if [[ -z $1 ]]
  then
    echo Please provide an element as an argument.
else
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    #echo -e "\n$1"
    ATOMIC_INFO=$($PSQL "SELECT atomic_number, symbol, name, genre, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements LEFT JOIN properties USING(atomic_number) WHERE atomic_number = $1;")
    IFS='|' read ATOMIC_NUMBER SYMBOL NAME GENRE ATOMIC_MASS MELTING_POINT BOILING_POINT <<< $ATOMIC_INFO
      echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $GENRE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  #elif [[ $1 =~ ^[A-Z][a-z]+$ ]]
  else
    #then
    ATOMIC_INFO=$($PSQL "SELECT atomic_number, symbol, name, genre, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements LEFT JOIN properties USING(atomic_number) WHERE symbol = '$1' OR name = '$1'")
    IFS='|' read ATOMIC_NUMBER SYMBOL NAME GENRE ATOMIC_MASS MELTING_POINT BOILING_POINT <<< $ATOMIC_INFO
    if [[ -z $ATOMIC_INFO ]]
    then
      echo I could not find that element in the database.
    else
      echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $GENRE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    fi
  fi
fi
