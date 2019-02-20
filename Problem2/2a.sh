awk -F "," '{if ($7 =="2012")country[$1]+=$10;}END{for (i in country)print i", "country[i];}' WA_Sales_Products_2012-14.csv | sort -t, -nk2 -r | awk 'NR==1'

