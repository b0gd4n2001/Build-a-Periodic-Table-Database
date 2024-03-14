#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
if [[ -z $1 ]]
then
  echo Please provide an element as an argument.
elif [[ $1 =~ ^[0-9]+$ ]]
then
  ANR=$(echo $($PSQL "SELECT atomic_number FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE atomic_number = $1") | sed 's/|/ /')
  SYN=$(echo $($PSQL "SELECT symbol FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE atomic_number = $1") | sed 's/|/ /')
  NAM=$(echo $($PSQL "SELECT name FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE atomic_number = $1") | sed 's/|/ /')
  TYP=$(echo $($PSQL "SELECT type FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE atomic_number = $1") | sed 's/|/ /')
  AMS=$(echo $($PSQL "SELECT atomic_mass FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE atomic_number = $1") | sed 's/|/ /')
  MPC=$(echo $($PSQL "SELECT melting_point_celsius FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE atomic_number = $1") | sed 's/|/ /')
  BPC=$(echo $($PSQL "SELECT boiling_point_celsius FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE atomic_number = $1") | sed 's/|/ /')
  if [[ -z $ANR ]]
  then
    echo "I could not find that element in the database."
  else
    echo "The element with atomic number $ANR is $NAM ($SYN). It's a $TYP, with a mass of $AMS amu. $NAM has a melting point of $MPC celsius and a boiling point of $BPC celsius."
  fi
else
  ANR=$(echo $($PSQL "SELECT atomic_number FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE symbol = '$1' OR name = '$1'") | sed 's/|/ /')
  SYN=$(echo $($PSQL "SELECT symbol FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE symbol = '$1' OR name = '$1'") | sed 's/|/ /')
  NAM=$(echo $($PSQL "SELECT name FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE symbol = '$1' OR name = '$1'") | sed 's/|/ /')
  TYP=$(echo $($PSQL "SELECT type FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE symbol = '$1' OR name = '$1'") | sed 's/|/ /')
  AMS=$(echo $($PSQL "SELECT atomic_mass FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE symbol = '$1' OR name = '$1'") | sed 's/|/ /')
  MPC=$(echo $($PSQL "SELECT melting_point_celsius FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE symbol = '$1' OR name = '$1'") | sed 's/|/ /')
  BPC=$(echo $($PSQL "SELECT boiling_point_celsius FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE symbol = '$1' OR name = '$1'") | sed 's/|/ /')
  if [[ -z $ANR ]]
  then
    echo "I could not find that element in the database."
  else
    echo "The element with atomic number $ANR is $NAM ($SYN). It's a $TYP, with a mass of $AMS amu. $NAM has a melting point of $MPC celsius and a boiling point of $BPC celsius."
  fi
fi