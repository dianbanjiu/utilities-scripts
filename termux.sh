#!/bin/bash
# before ./termux.sh, you need "pkg upgrade && pkg install git" first
# enable two level keyboard, and disable bell and shock
cd
if [ ! -d ".termux" ]
then
    mkdir .termux
    if ! grep extra-key $HOME/.termux/termux.properties  
    then
        echo "extra-keys = [['ESC','/','-','HOME','UP','END','PGUP'],['TAB','CTRL','ALT','LEFT','DOWN','RIGHT','PGDN']]" >> .termux/termux.properties
        echo "bell-character = ignore" >> .termux/termux.properties 
    fi
fi

# change repo mirrors to ustc
# ustc && tuna termux mirror has some problems,
# so you can enable it as your wish.
# to do that, you just delete the "#" below 5 line.

# echo "change mirrors to ustc"
# if ! grep ustc $PREFIX/etc/apt/sources.list
# then 
#     echo "deb https://mirrors.ustc.edu.cn/termux stable main" >> $PREFIX/etc/apt/sources.list
# fi

pkg install -y git openssh cowsay tree zsh wget curl build-essential cmake python vim ctags

# set cowsay "Don't do anything stupid" to launch welcome
cowsay "Don't do anything stupid" > ../usr/etc/motd
#echo -e "\n\n\n\n" >> $PERFIX/etc/motd

# install oh my zsh and it's plugin zsh-syntax-highlight
cd
echo "begin to get oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting

sed -i 's/plugins=(git)/plugins=(git zsh-syntax-highlighting)/g' .zshrc

# enable phone internal storage for termux
# and link the internal downloads/termux to the home directory.
# for storage termux data to here
termux-setup-storage
sleep 10
if [! -d "$HOME/storage/downloads/termux"]
then
	mkdir $PREFIX/home/storage/downloads/termux
	echo "storage/downloads/termux created"
fi
ln -sf storage/downloads/termux termux

# downloads the simple vim script
git clone https://github.com/dianbanjiu/.vimrc vimrc 
mv vimrc/.vimrc ~/.vimrc
rm -rf vimrc 

# vim "-c PlugInstall"
# change default shell to zsh
chsh -s zsh
