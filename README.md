# SoalShift_modul1_D5

Keterangan : pastikan seluruh file .sh untuk tiap jawaban telah mendapatkan chmod, dengan syntax chmod +x [NamaFile].sh untuk memungkinkan jalannya crontab<br>

----------SOAL1------------
- Source Code soal1.sh

#!/bin/bash

counter=0
for fname in ./nature/*.jpg;
do
        base64 "$fname" -d | xxd -r > ~/FotoNature/fotonature"$counter".jpg
        let "counter++" 
done

Target penyelesaian :
- Melakukan konversi file yang tersedia dengan decode base64 (didapatkan hex dump)
- Melakukan konversi file hexdump dan mendapatkan output .jpg

Penjelasan :
1) counter hanya digunakan untuk memberikan nama spesifik untuk tiap file bernama "fotonature"
2) loop (for fname. .) digunakan untuk mengiterasi seluruh filename yang terdapat pada folder yang sama dengan file bash script, yaitu (./nature/*jpg <- seluruh file mentah dengan extensi .jpg)
3) bagian dalam loop,
	- base64 "$fname" -d (dilakukan untuk mengkonversi file raw didecode dalam base64 dan didapatkan hexdump)
	- xxd -r (hasil sebelumnya dimasukkan ke fungsi xxd yang berfungsi untuk mengubah file menjadi hexdump, namun karena ada option -r melakukan proses sebaliknya, yaitu melakukan decode file hexdump)
	- ~/FotoNature/fotonature"$counter".jpg (hasil decode hexdump disimpan ke dalam folder dengan extensi .jpg sesuai dengan nama fotonature diikuti dengan counter)
	- let "counter++" (increment counter)
4) pada bagian crontab -e
	- 14 14 14 2 5 [Direktori File.sh] -> menunjukkan tiap pukul 14:14 14 Februari, atau tiap Jum'at akan dijalankan


----------SOAL2------------
- Source Code soal2.sh

	1) awk -F "," '{if (condition)storage[group]+=target;}END{for (x in storage)print x":"storage[x]}' namafile | sort -t, -nk'x' -r | awk 'NR==1'
	2) $(echo $hasilawk | cut -d':' -f'x')

Target penyelesaian :
- Melakukan konversi file yang tersedia dengan decode base64 (didapatkan hex dump)
- Melakukan konversi file hexdump dan mendapatkan output .jpg

Penjelasan tiap syntax :
1)
- -F "," -> Field Separator dipisahkan dengan koma (,)
- if (condition) -> condition sesuai dengan soal
- storage[group]+=target -> array yang menyimpan key berupa group dengan isi target, contoh: jika ingin menjumlah total Quantity pada kolom ke 10 pada file, dan dikelompokkan berdasarkan Retailer Country pada kolom ke 1 pada file, maka syntaxnya
	storage[$1]+=$10 #storage hanyalah nama array
- for (x in storage) -> mengiterasi semua hasil nilai yang sudah disimpan di dalam array key-value di atas
- print x":"storage[x] -> melakukan print 'nama group' dan 'value group
- sort -t, -nk'x' -r -> melakukan sort, keterangan OPTION
	-t, -> berfungsi sebagai penanda separator (field separator) dengan tanda koma
	-nk'x' -> -n memberikan option 'numerical', yaitu diurutkan berdasarkan jumlah. -k'x' option diurutkan berdasarkan kolom x (x diisi nomor kolom, contoh -nk2 berarti diurutkan sesuai dengan kolom ke 2)
	-r -> berfungsi untuk reverse, sort yang awalnya ASCENDING berubah menjadi DESCENDING
- awk 'NR==1' -> mengambil record sebanyak x teratas (NR==1 mengambil record paling atas)

2) 
- echo $hasilawk -> mendapatkan hasil dari awk
- cut -d':' -> memotong string hasilawk, dipisahkan dengan titik dua
- -f'x' -> mengambil nilai ke x (contoh string "Test:Hello:World", untuk -f1 akan terambil Test, -f2 Hello)

Langkah Program :
- Untuk soal 2a, sesuai dengan penjelasan syntax di atas:
	condition : $7 memenuhi 2012
	if condition true : jumlahkan Quantity groupby Retailer Country
- Untuk soal 2b, penambahan syarat:
	condition : $7 memenuhi 2012 dan $1 memenuhi Jawaban2a
	if condition true : jumlahkan Quantity groupby Product Line
- Untuk soal 2c, penambahan syarat:
	condition : $7 memenuhi 2012 dan $1 memenuhi Jawaban2a dan $4 memenuhi Jawaban2b
	if condition true : jumlahkan Quantity groupby Product

----------SOAL3------------<br>
- Source Code soal1.sh

#!/bin/bash
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

- Target penyelesaian:
1) Generate random password 12 karakter dengan ketentuan huruf besar, kecil, dan angka
2) Cek File yang sudah ada
3) Cek Password yang sudah pernah tergenerate sebelumnya

Penjelasan
1) Generate random password, dihandle dengan cara
	- PASSWORD=$(< /dev/urandom tr -dc A-Za-z0-9 |head -c 12)
		- /dev/urandom -> merupakan direktori library berisi random character
		- tr -dc A-Za-z0-9 -> delete dari directory di atas, complement dari set A-Za-z0-9
		- head -c 12 -> mengambil dari directory sebanyak 12 characters
2) Cek File
	- while [[ -e "$name""$i".txt ]] ... let i++;
		- mengecek apakah nama file sudah ada atau tidak
		- jika tidak, kode angka pada nama file akan bertambah 1
3) Cek Password
	-  while IFS='' read -r line || [[ -n "$line" ]]; do if [ "$line" = "$PASSWORD" ] then [PASSWORD=$(< /dev/urandom tr -dc A-Za-z0-9 |head -c 12)
		- while IFS='' read -r line -> berfungsi untuk melakukan iterasi ke tiap file yang ada
		- [[ -n "$line" ]] -> mengextract line dalam tiap file yang diiterasi
		- if[ "$line" = $PASSWORD" ] ..... -> jika ditemukan password yang sama, maka akan digenerate password baru
		
----------SOAL4------------<br>
Syntax fokus utama untuk soal4

1) ${namaarray[*]}
2) ${namaarray[@]:(-(x))}
3) ${namaarray[@]:0:x}
4) date + (%H / %M / %d / %m / %Y)
5) tr [SET1] [SET2]

Penjelasan tiap syntax
1) ${namaarray[*]} -> mengambil seluruh value di dalam array
2) ${namaarray[@]:(-(x))} -> mengambil isi array sebanyak x dari belakang
	- contoh arrayX berisi 1 2 3 4 5
	- maka ${arrayX[@]:(-2)} mengambil nilai 4 dan 5 dari arrayX
3) ${namaarray[@]:0:x} -> mengambil isi array sebanyak x dimulai dari index 0
	- contoh arrayX berisi 1 2 3 4 5
	- maka ${arrayX[@]:0:2} mengambil nilai 1 dan 2 dari arrayX
4) date + (value) -> mengextract nilai date sesuai value
	- "%H" -> mengambil Hour (Jam)
	- "%M" -> mengambil Minute (Menit)
	- "%d" -> mengambil dayofthemonth (Tanggal)
	- "%m" -> mengambil month (Bulan)
	- "%Y" -> mengambil Year (Tahun)
5) tr [SET1] [SET2] -> mengubah pattern SET1 menjadi sesuai dengan SET2
	- misal tr [ABCDE] [CDEAB] untuk string ACE, akan berubah menjadi CEB

Langkah Program :
1) Inisialisasi array alphabet lower dan upper-case
2) Menggabungkan 2 array tersebut ke dalam 1 array baru
3) Mengextract value 'Hour' dan disimpan pada variabel 'geser'
4) Inisialisasi array yang akan digunakan sebagai SET2
5) Extract lower-case dan upper-case array dengan ketentuan
	- ${inisial[@]:(-(26-geser))} -> untuk mengambil isi array sebanyak 26-geser alphabet dari belakang
	- jika value geser adalah 2, maka akan terambil alphabet c sampai dengan z
	- ${inisial[@]:0:$geser} -> untuk mengambil isi array sebanyak geser alphabet dari index 0
	- jika value geser adalah 2, maka akan terambil alphabet a dan b

	- sehingga isi dari array SET2 menjadi C-ZAB

6) Extract attribute date yang dibutuhkan untuk penamaan file
7) Merubah syslog dengan translate tiap huruf dalam syslog
	- tr "${inisialkombi[*]}" "${cipher[*]}"
	- misal untuk value geser adalah 5, maka akan didapatkan
	- insialkombi = [abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ]
	- cipher = [fghijklmnopqrstuvwxyzabcdeFGHIJKLMNOPQRSTUVWXYZABCDE]
8) Membuat syarat crontab per jam
	- 0 * * * * [Direktori File.sh] -> eksekusi file per jam

----------SOAL5------------<br>
Fokus soal5 :
- Mengubah setting dari system untuk mendapatkan log dari command user
- Mencari syslog yang memenuhi syarat
- Membuat crontab

- Mengubah setting log :
1) Mengubah setting config file dengan menulis 'sudo -e /etc/bash.bashrc'
2) Masukkan password user
3) Memasukkan command pada bagian bawah file tersebut, yaitu
	- export PROMPT_COMMAND='RETRN_VAL=$?;logger -p local6.debug "$(whoami) [$$]: $(history 1 | sed "s/^[ ]*[0-9]\+[ ]*//" ) [$RETRN_VAL]"'
4) Melakukan setting logging untuk local6 dengan membuka 'sudo -e /etc/rsyslog.d/bash.conf'
5) Menambahkan 'local6.* /var/log/commands.log' di dalam file tersebut
6) Restart rsyslog dengan 'sudo service rsyslog restart'
7) Relog-in Linux
8) Cek log rotation di dalam 'sudo -e /etc/logrotate.d/rsyslog'
9) Menambahkan /var/log/commands.log
9) Dengan menjalankan seluruh perintah di atas, tiap command yang dimasukkan oleh user akan direcord di dalam /var/log/commands.log

- Mencari syslog dengan syarat, Source code:

#!/bin/bash
 awk '{if(!/[Ss][Uu][Dd][Oo]/ && /[Cc][Rr][Oo][Nn]/ && NF<13)print;}' /var/log/commands.log > ~/modul1/log.txt

- *Penjelasan
	- !/[Ss][Uu][Dd][Oo]/ -> Pattern regex yang memastikan tidak ada kombinasi upper-case maupun lower-case dari string 'sudo'
	- /[Cc][Rr][Oo][Nn]/ -> Pattern regex yang memastikan didapatkannya kombinasi upper-case maupun lower-case dari string 'cron'
	- NF<13 -> Memastikan panjang Field berjumlah kurang dari 13

- Membuat crontab :
	- 2-30/6 * * * * [Direktori File .sh] -> menjalankan tiap 6 menit dalam rentang menit ke 2-30

