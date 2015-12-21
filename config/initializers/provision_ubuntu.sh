#!/bin/sh
sudo apt-get update

RCol='\e[0m'    # Text Reset
Gre='\e[0;32m';
log() {
  echo -e "\n\n${Gre}[Info] => $1${RCol}"
}

## nginx
log "Installing git and nginx"
sudo apt-get install git nginx -y

## RBENV
log "Installing rbenv dependencies"
sudo apt-get install -y build-essential libssl-dev libreadline-dev zlib1g-dev libsqlite3-dev sqlite3

log "Installing rbenv"
cd
git clone git://github.com/sstephenson/rbenv.git .rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile

git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bash_profile
source ~/.bash_profile

## ruby
log "Installing ruby"
rbenv install -v 2.2.3
rbenv global 2.2.3
echo "gem: --no-document --no-ri --no-rdoc" >> ~/.gemrc

## gems
log "Installing Bundler and Rails"
gem install bundler
gem install rails
rbenv rehash

## node -- get latest node 5.x
log "Installing node 5"
curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
sudo apt-get install nodejs -y

## Shake hands with github
log "Generating ssh rsa key"
ssh -T git@github.com
## Generate a rsa public key for github's deploy keys
ssh -t rsa
## add ~/.ssh/id_rsa.pub to the repo's deployment keys
