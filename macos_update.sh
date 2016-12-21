#!/bin/sh

echo "****Starting Brew Update****"
brew update

echo "****The following packages will be updated****"
brew outdated

read -p "Press [Enter] key to continue with Brew upgrade"

brew upgrade

echo "****Documenting installed packages****"
#OSX_DIR is an environment variable defined in my shell
brew leaves > $OSX_DIR/brew_installed.txt
brew cask list > $OSX_DIR/cask_installed.txt

echo "****Starting Brew Cleanup****"
brew cleanup
brew cask cleanup

echo "****Starting RVM Update****"
rvm get stable

# Be careful updating all gems system-wide!
#rvm gemset update

#echo "****Starting Gem Update****"
#sudo gem update --system
#sudo gem update
#sudo gem cleanup

#echo "****Starting NPM Update****"
#npm outdated -g

#read -p "Press [Enter] key to continue with NPM upgrade"

# Remember packages can be upgraded globally and locally to a project
# Are the following redundant?
# This script should only be used to update npm and system-wide packages
# MB alternative: https://github.com/mathiasbynens/dotfiles/pull/430/files#diff-1
#npm install npm@latest -g

# And update gems
#npm update -g

echo "****Starting PIP Update****"
pip install --upgrade pip
pip install --upgrade setuptools
echo "The following packages will have to be manually updated using 'pip install --upgrade <package>'"
pip list --outdated --format columns
# No built-in command to update all packages but the following line works.
# Add/remove 'sudo' as needed
# pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U

echo "****Starting PIP3 Update****"
pip3 install --upgrade pip
pip3 install --upgrade setuptools
echo "The following packages will have to be manually updated using 'pip3 install --upgrade <package>'"
pip3 list --outdated --format columns

echo "****Documenting installed pip packages****"
pip list --format freeze > $OSX_DIR/pip_installed.txt
pip3 list --format freeze > $OSX_DIR/pip3_installed.txt

echo "****Checking for OS X updates****"
sudo softwareupdate --list
read -p "Press [Enter] key to continue with system updates"
sudo softwareupdate -i -a --verbose

# Verify disk. Change disk1 to whatever your disk is.
diskutil verifyDisk /dev/disk0
diskutil verifyVolume /dev/disk1

echo "****Finished****"
