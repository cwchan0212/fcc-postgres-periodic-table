#! /bin/bash
# begin of code
PSQL="psql --username=freecodecamp --dbname=periodic_table --no-align --tuples-only -c"

if [[ $1 ]]
then
  if [[ ! $1 =~ ^[0-9]+$ ]]  
  then
    ELEMENT=$($PSQL "SELECT elements.atomic_number, elements.name, elements.symbol, properties.type_id, types.type, properties.atomic_mass, properties.melting_point_celsius, boiling_point_celsius FROM properties INNER JOIN elements ON elements.atomic_number = properties.atomic_number INNER JOIN types ON types.type_id = properties.type_id where elements.symbol like '%$1%' OR elements.name like '%$1%' ORDER BY elements.atomic_number limit 1;")
    if [[ -z $ELEMENT ]]
    then
      echo "I could not find that element in the database."
    else
      echo $ELEMENT | while IFS=\| read ATOMIC_NUMBER NAME SYMBOL TYPE_ID TYPE MASS MELTING_POINT BOILING_POINT
      do
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
      done
    fi
  else
    ELEMENT=$($PSQL "SELECT elements.atomic_number, elements.name, elements.symbol, properties.type_id, types.type, properties.atomic_mass, properties.melting_point_celsius, boiling_point_celsius FROM properties INNER JOIN elements ON elements.atomic_number = properties.atomic_number INNER JOIN types ON types.type_id = properties.type_id where elements.atomic_number = '$1' ORDER BY elements.atomic_number limit 1;")
    if [[ -z $ELEMENT ]]
    then
      echo "I could not find that element in the database."
    else
      echo $ELEMENT | while IFS=\| read ATOMIC_NUMBER NAME SYMBOL TYPE_ID TYPE MASS MELTING_POINT BOILING_POINT
      do
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
      done
    fi
  fi
else
    echo "Please provide an element as an argument."
fi
# end of code
