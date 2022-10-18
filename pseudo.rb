require "nokogiri"
require "open-uri"
require 'csv'

# file path de la DB
filepath = "data/number.csv"
# variable pour le nombre de pages
num = 0
# un array vide de stockage
array = []
# boucle pour le programme en fonction du nombre de pages
until num == 55
    # stocker l'url dans une variable
    url = "https://musiquesactuelles.net/annuaire-des-artistes-structures-musiques-actuelles-du-grand-est/pg/#{num}/"
    # incrémenter le nombre de pages
    num += 1
    # Accéder à l'url
    html_file = URI.open(url).read
    # parser le html / le récupérer
    html_doc = Nokogiri::HTML(html_file)
    # chercher sur le document, les class css
    html_doc.search(".phone-number-block .value").each do |element|
        # incrémenter l'array avec les résultats
        array << element.text.strip
    end
    # afficher l'array
    p array
    # persister les données dans la DB
    CSV.open(filepath, "ab") do |csv|
        csv << array
    end
end