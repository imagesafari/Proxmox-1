#!/usr/bin/env bash
set -e
RD=`echo "\033[01;31m"`
BL=`echo "\033[36m"`
CM='\xE2\x9C\x94\033'
GN=`echo "\033[1;92m"`
CL=`echo "\033[m"`
clear
echo -en "${GN} Stopping Dashy... "
systemctl stop dashy
sleep 1
echo -e "${CM}${CL} \r"

echo -en "${GN} Backup conf.yml... "
cp -R /dashy/public/conf.yml conf.yml
sleep 1
echo -e "${CM}${CL} \r"

echo -en "${GN} Updating Dashy... "
cd /dashy
git merge &>/dev/null
git pull origin master &>/dev/null
yarn &>/dev/null
yarn build &>/dev/null
echo -e "${CM}${CL} \r"

echo -en "${GN} Restoring conf.yml... "
cd ~
cp -R conf.yml /dashy/public
sleep 1
echo -e "${CM}${CL} \r"

echo -en "${GN} Cleaning... "
rm -rf conf.yml
sleep 1
echo -e "${CM}${CL} \r"

echo -en "${GN} Starting Dashy... "
systemctl start dashy
sleep 1
echo -e "${CM}${CL} \r"

echo -e "${GN} Finished ${CL}\n"
