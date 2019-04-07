
if [ ! -L "workspace" ]; then
    #rm workspace
    ln -s ~/workspace workspace
fi

if [ ! -L "downloads" ]; then
    #rm downloads
    ln -s ~/Downloads downloads
fi

if [ ! -L "documents" ]; then
    #rm documents
    ln -s ~/Documents documents
fi

if [ -f "output.txt" ]; then
:   rm output.txt
fi

#vagrant box update
vagrant destroy
vagrant up > output.txt
tail output.txt

vagrant halt
vagrant up
