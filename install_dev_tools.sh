#!/bin/bash

# Colors
GREEN='\033[0;92m'
BLUE='\033[0;36m'
YELLOW='\033[0;33m'
PINK='\033[0;95m'
NC='\033[0m'

sudo apt-get update

# 1. and 2. Docker and Docker Compose
PACKAGES="docker.io docker-compose python3 python3-venv python3-pip"
for prog in $PACKAGES; do 
  if dpkg -s $prog > /dev/null 2>&1; then
      echo -e "${GREEN}$prog is already installed.${NC}"
  else
      echo -e "${BLUE}Installing $prog...${NC}"
      sudo apt-get install -y $prog
  fi
done

# 3. Check Python version
if command -v python3 &> /dev/null; then
  MINOR_VERSION=$(python3 -V | cut -d' ' -f2 | cut -d'.' -f2)
  if [[ "$MINOR_VERSION" -ge 9 ]]; then
    echo -e "${GREEN}Python 3.9 or newer is already installed.${NC}"
  else
    echo -e "${BLUE}Installed Python is older than 3.9, installing python3...${NC}"
    sudo apt-get install -y python3
  fi
else
  echo -e "${BLUE}Python3 not found, installing python3...${NC}"
  sudo apt-get install -y python3
fi

# Create and activate virtual environment
if [ ! -d "devtools_venv" ]; then
  echo -e "${BLUE}Creating virtual environment...${NC}"
  python3 -m venv devtools_venv
fi

source devtools_venv/bin/activate

# Upgrade pip inside venv
echo -e "${BLUE}Upgrading pip inside virtual environment...${NC}"
pip install --upgrade pip

# 4. Install Django inside venv
if pip show django > /dev/null 2>&1; then
  echo -e "${GREEN}Django is already installed in virtual environment.${NC}"
else
  echo -e "${BLUE}Installing Django inside virtual environment...${NC}"
  pip install django
fi

echo -e "${PINK}All done!${NC}"
echo -e "${YELLOW}To start using Django, activate virtual environment with:${NC}"
echo "source devtools_venv/bin/activate"

