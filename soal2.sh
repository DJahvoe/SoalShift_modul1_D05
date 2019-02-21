echo "Soal 2a"
awk -F "," '{if ($7 =="2012")country[$1]+=$10;}END{for (i in country)print i", "country[i];}' WA_Sales_Products_2012-14.csv | sort -t, -nk2 -r | awk 'NR==1'

echo "Soal 2b"
awk -F "," '{if ($1 =="United States" && $7 =="2012")productline[$4]+=$10;}END{for (i in productline)print i", "productline[i];}' WA_Sales_Products_2012-14.csv | sort -t, -nk2 -r | head -3

echo "Soal 2c"
awk -F "," '{if ($1 =="United States" && $4 =="Personal Accessories" && $7 =="2012")product[$6]+=$10}END{for (i in product)print "Personal Accessories, " i": "product[i];}' WA_Sales_Products_2012-14.csv | sort -t: -nk2 -r | head -3
awk -F "," '{if ($1 =="United States" && $4 =="Camping Equipment" && $7 =="2012")product[$6]+=$10}END{for (i in product)print "Camping Equipment, " i": "product[i];}' WA_Sales_Products_2012-14.csv | sort -t: -nk2 -r | head -3
awk -F "," '{if ($1 =="United States" && $4 =="Outdoor Protection" && $7 =="2012")product[$6]+=$10}END{for (i in product)print "Outdoor Protection, " i": "product[i];}' WA_Sales_Products_2012-14.csv | sort -t: -nk2 -r | head -3
