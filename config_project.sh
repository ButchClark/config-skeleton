#!/bin/bash

########################################
# Author: Butch Clark
# Git Project: 
#
# Asks user for input for several
#  different settings.  These are then
#  used to update file/directory names,
#  and also searches all source files
#  for occurrences of tags, and replaces
#  them with the input values.
########################################

source ./term_helper.sh

echo -e "${Clear}"
showTitle
#echo -e "${esc}[48;5;0m"
printf "Enter your ${Orange}git project name ${NC}(i.e. service-somethin-here): "; read gitproject
printf "Enter your ${Orange}User Friendly project name ${NC}(i.e. Serice Something Here): "; read userfriendly
printf "Enter your ${Orange}Pascal-case project name ${NC}(i.e. ServiceSomethingHere): "; read pascalcase
printf "Enter your ${Orange}Java package name ${NC}(i.e. myFeature): "; read pkgname
printf "Enter your ${Orange}Ruby-friendly project name ${NC}(i.e. service_something_here): "; read rubyfriendly
printf "Enter your ${Orange}system env friendly name ${NC}(i.e. SERVICE_SOMETHING_HERE): "; read uppercased
printf "Enter your ${Orange}port number ${NC}(i.e. 8033): "; read portnumber
printf "Enter your ${Orange}simulator port number ${NC}(i.e. 9033): "; read simulatorport
printf "Enter your ${Orange}REST Endpoint ${NC}(i.e. lookupCommitment): "; read restendpoint
printf "Enter your ${Orange}REST Success Msg ${NC}(i.e. Lookup of customer commitments Successful): "; read restsuccess
printf "Enter your ${Orange}REST Endpoint suffix${NC}(i.e. lookupCommitment): "; read restsuffix

echo -e "---------------------------------------"
echo -e " Using the following values:"
echo -e " ${Orange}Git Project name  ${NC}:  ${Yellow}$gitproject${NC}"
echo -e " ${Orange}User Friendly name${NC}:  ${Yellow}$userfriendly${NC}"
echo -e " ${Orange}Pascal-case name  ${NC}:  ${Yellow}$pascalcase${NC}"
echo -e " ${Orange}Java package name ${NC}:  ${Yellow}$pkgname${NC}"
echo -e " ${Orange}Ruby Friendly name${NC}:  ${Yellow}$rubyfriendly${NC}"
echo -e " ${Orange}System Env name   ${NC}:  ${Yellow}$uppercased${NC}"
echo -e " ${Orange}Port Number       ${NC}:  ${Yellow}$portnumber${NC}"
echo -e " ${Orange}Simulator Port    ${NC}:  ${Yellow}$simulatorport${NC}"
echo -e " ${Orange}REST Endpoint     ${NC}:  ${Yellow}$restendpoint${NC}"
echo -e " ${Orange}REST Success Msg  ${NC}:  ${Yellow}$restsuccess${NC}"
echo -e " ${Orange}REST Endpt Suffix ${NC}:  ${Yellow}$restsuffix${NC}"
echo -e "---------------------------------------"

read -p "Continue? (y/n): " contin
uc="$(echo -e "$contin" | tr '[:lower:]' '[:upper:]')"
if [[ "${uc:0:1}" == "N" ]];
then 
	echo -e "Aborting config..."
	exit 0
fi

echo -e "Well, okay, let's do it..."
rm -rf ./.git
rm -rf ./.idea
echo -e "${Green}Removed git and idea Directories.${NC}"

pushd src/main/java/com/dish/ofm/service/PACKAGE_NAME/config
mv APPLICATION_NAMEConfig.java ${pascalcase}Config.java
popd

pushd src/main/java/com/dish/ofm/service
mv APPLICATION_NAMEApplication.java ${pascalcase}Application.java
popd

pushd src/main/java/com/dish/ofm/service/PACKAGE_NAME/controller
mv APPLICATION_NAMEController.java ${pascalcase}Controller.java
popd
echo -e "${Green}Renamed java files...${NC}"
mv src/main/java/com/dish/ofm/service/PACKAGE_NAME src/main/java/com/dish/ofm/service/${pkgname}
echo -e "${Green}Renamed source Directory to ${pkgname}...${NC}"

pushd src/test/java/com/dish/ofm/service/PACKAGE_NAME/controller
mv APPLICATION_NAMEControllerTest.java ${pascalcase}ControllerTest.java
popd
echo -e "${Green}Renamed java test files...${NC}"
mv src/test/java/com/dish/ofm/service/PACKAGE_NAME src/test/java/com/dish/ofm/service/${pkgname}
echo -e "${Green}Renamed source Directory to ${pkgname}...${NC}"

pushd acceptance/spec/helpers
mv LOWER_UNDERSCORE_NAME_server.rb ${rubyfriendly}_server.rb
echo -e "${Green}Renamed ruby test files...${NC}"
popd

for file in $(find . -type f)
do
    sed -i.sedTmp \
	-e s/SERVICE_GIT_PROJECT_NAME/${gitproject}/g \
	-e s/PROJECT_TITLE/"${userfriendly}"/g \
	-e s/SIMULATOR_PORT_NUMBER/"${simulatorport}"/g \
	-e s/PORT_NUMBER/"${portnumber}"/g \
	-e s/REST_ENDPOINT_CAMEL_CASE/"${restendpoint}"/g \
	-e s/REST_ENDPOINT_SUCCESS_MESSAGE/"${restsuccess}"/g \
	-e s/REST_ENDPOINT/"${restsuffix}"/g \
	-e s/APPLICATION_NAME/"${pascalcase}"/g \
	-e s/PACKAGE_NAME/"${pkgname}"/g \
	-e s/UPPER_UNDERSCORE_NAME/"${uppercased}"/g \
	-e s/LOWER_UNDERSCORE_NAME/"${rubyfriendly}"/g \
	$file
done
echo -e "${Green}Replaced tags in all source files...${NC}" 
echo -e "Updates complete.  "
gradle clean build
echo -e "gradle complete.  "
thumbsUp
echo -e "Exiting..."
open -a /Applications/IntelliJ\ IDEA.app .
