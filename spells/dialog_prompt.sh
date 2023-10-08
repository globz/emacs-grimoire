#!/bin/bash

dialog_prompt()
{

  local message=$@;

  read -n 1 -s -r -p "${message} `echo $'\n> '`"

}
