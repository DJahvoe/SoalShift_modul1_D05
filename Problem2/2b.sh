awk -F "," '{if ($1 =="United States" && $7 =="2012")productline[$4]+=$10;}END{for (i in productline)print i", "productline[i];}' WA_Sales_Products_2012-14.csv | sort -t, -nk2 -r | head -3
