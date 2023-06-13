!/bin/bash

url="https://webscraper.io/test-sites/e-commerce/allinone/computers/laptops"

# Télécharger la page
page=$(curl -s "$url")

# Extraction des noms
laptop_name=$( echo "$page" | grep -oP '<a class="title" href="/test-sites/e-commerce/allinone/product/[^"]+">\>

# Extraction des prix
laptop_prix=$( echo "$page" | grep -oP '<h4 class="pull-right price">\K[^<]+')

# Exctraction des descriptions
laptop_desc=$( echo "$page" | grep -oP '<p class="description">\K[^<]+')

# Création du fichier
file="web_scraping.csv"
echo "Nom;Prix;Description" > "$file"

# Éxécution du script et enregistrement
for ((i=0; i<${#laptop_name[@]}; i++)); do
        echo "${laptop_name[$i]};${laptop_prix[$i]};${laptop_desc[$i]}" >> "$file"
done

echo "Les données ont été enregistrées avec succèes dans le fichier $file"
