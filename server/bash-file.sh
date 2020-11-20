#!/bin/bash
echo "1-restart"
echo "2-start"
read n1

if [ $n1 -eq 1 ]
then
    
    cd dependencies
    sudo docker-compose up -d
    python3 restart.py
    cd ..
    cd starter
    sudo docker-compose up

    
    
    
elif [ $n1 -eq 2 ]
then
    cd dependencies
    sudo docker-compose up -d
    cd..
    cd starter
    sudo docker-compose up
    
fi