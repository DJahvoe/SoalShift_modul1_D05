PASSWORD=$(< /dev/urandom tr -dc A-Za-z0-9 |head -c 12 )

name=password
i=1
while [[ -e "$name""$i".txt ]] ; do
 while IFS='' read -r line || [[ -n "$line" ]]; do
  if [ "$line" = "$PASSWORD" ]
  then
  PASSWORD=$(< /dev/urandom tr -dc A-Za-z0-9 |head -c 12 )
  #PASSWORD=$(echo "ganti pwd")
  #echo $PASSWORD
  fi
 done < logpwd.txt
 let i++
done
echo $PASSWORD >> logpwd.txt
echo $PASSWORD >> "$name""$i".txt
