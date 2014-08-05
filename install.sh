git pull origin master;

rsync --exclude ".git/" --exclude "install.sh" --exclude "README.md" -avh --no-perms . ~;

source ~/.zprofile;
