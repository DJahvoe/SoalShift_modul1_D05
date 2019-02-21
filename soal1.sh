#!/bin/bash

counter=0
for fname in ./nature/*.jpg;
do
	base64 "$fname" -d | xxd -r > ~/FotoNature/fotonature"$counter".jpg
	let "counter++" 
done
