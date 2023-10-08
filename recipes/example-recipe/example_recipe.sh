#!/bin/bash

example_recipe()
{

  local env=$1
  local wd=$(pwd)

  echo "Hello from example_recipe with ENV: ${env}"

  # Sourcing spellpouch from working directory (user grimoire)
  source "${wd}/spells/spellpouch.sh"

  # Making use of spellpouch, invoking example_pouch with spell example_spell_1
  # (external function #1)
  spellpouch -p "example_pouch" -s "example_spell_1" -e "example_recipe_arg1" "example_recipe_arg2" "example_recipe_arg3"

  # Making use of spellpouch, invoking example_pouch with spell example_spell_2
  # (external function #2)
  spellpouch -p "example_pouch" -s "example_spell_2" -e "example_recipe_arg1" "example_recipe_arg2" "example_recipe_arg3"

  # Making use of spellpouch, invoking example_standalone_pouch (single external function)
  spellpouch -p "example_standalone_pouch" -e "example_recipe_arg1" "example_recipe_arg2" "example_recipe_arg3"

  # Mixing example-reagent from example-recipe along with the mandatory env
  # defined in .witchesbrew.env and one or more optional arguments
  witchesbrew mix example-reagent -e "${env}" "optional_arg1"
    
}
