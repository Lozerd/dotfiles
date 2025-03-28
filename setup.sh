export $HOME = /home/$(whoami)

mkdir -p $HOME/.config/
mkdir -p $HOME/.local/bin/

mkdir -p $HOME/databases
mkdir -p $HOME/projects

mkdir -p $HOME/Pictures
mkdir -p $HOME/Downloads

cp ./upload_dump.sh $HOME/databases/
