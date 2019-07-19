#!/bin/bash

# 1.1 start ghost local
cd ghost
ghost start
echo "Ghost start successfully."
cd ..

# start ghost-static-site-generator to fetch from working
gssg --url https://elrakabawi.github.io/entropie
if 
    [ -d "static" ] 
then 
    echo "Directory static/ exists."
else 
    echo "Directory static/ does not exist. script stopped."
fi

# move ghost static generated site to the github pages repo
shopt -s dotglob nullglob
if
    [ -d "entropie" ]
then
    echo "Directory entropie/ exists."
    mv static/* entropie
else
    git clone https://github.com/elrakabawi/entropie.git
    mv static/* entropie
fi

# push updates to git
cd entropie
git add ..
git commit -m "blog update"
git push
open https://elrakabawi.github.io/entropie