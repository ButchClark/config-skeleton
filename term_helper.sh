#!/bin/bash

esc="\033"
Clear="${esc}\0143" # Clear screen
NC="${esc}[m"  # Color Reset

#  Colors
Red="${esc}[0;31m"
Green="${esc}[0;32m"
Blue="${esc}[0;34m"
Yellow="${esc}[38;5;226m"
Orange="${esc}[38;5;208m"
LBlue="${esc}[1;34m"


function thumbsUp(){
echo -e "${Orange}     _      "
echo -e "   _| |     "
echo -e " _| | |     "
echo -e "| | | |     "
echo -e "| | | | __  "
echo -e "| | | |/  \\ "
echo -e "|       /\\ \\"
echo -e "|      /  \\/"
echo -e "|      \\  /\\"
echo -e "|       \\/ /"
echo -e " \\        / "
echo -e "  |     /   "
echo -e "  |    |    "
echo -e "            ${NC}"
}

function column {
  for i in {16..21} {20..16} {17..21} {20..16} {17..21} {20..16} {17..21} {20..16}; do echo -en "${esc}[48;5;${i}m ${esc}[0m" ; done ; echo
}

function showTitle(){
  column
  echo -e "${LBlue}    .-.       "
  echo -e "   (${Red}o${LBlue}.${Red}o${LBlue})      "
  echo -e "    |=|       "
  echo -e "   __|__      "
  echo -e " //.=|=.\\    "
  echo -e "// .=|=. \\   "
  echo -e " \\ .=|=. //   "
  echo -e "  \\(_=_)//    "
  echo -e "  (:| |:)     "
  echo -e "   || ||      "
  echo -e "   () () ------------------------------"
  echo -e "   || || ${Orange}Config Beacon Skeleton Project${LBlue}"
  echo -e "   || || ------------------------------"
  echo -e "  ==' '==     "
  column
  echo -e "${NC}"
}



