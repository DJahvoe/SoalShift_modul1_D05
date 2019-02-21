#!/bin/bash
#echo "${source[@]:x:y' -> mengambil elemen mulai dari x sebanyak y
#echo "${source[@]:(-y)' -> mengambil elemen y dari belakang

inisial=({a..z})
inisialkapital=({A..Z})
inisialkombi="${inisial[@]}"" ""${inisialkapital[@]}"
geser=$(date +"%H")
cipher=()
cipher+=( "${inisial[@]:(-(26-geser))}" )
cipher+=( "${inisial[@]:0:$geser}" )
cipher+=( "${inisialkapital[@]:(-(26-geser))}" )
cipher+=( "${inisialkapital[@]:0:$geser}" )

jam=$(date +"%H")
menit=$(date +"%M")
tanggal=$(date +"%d")
bulan=$(date +"%m")
tahun=$(date +"%Y")

cat /var/log/syslog | tr "${inisialkombi[*]}" "${cipher[*]}" > ~/Syslog/"$jam:$menit $tanggal-$bulan-$tahun"
