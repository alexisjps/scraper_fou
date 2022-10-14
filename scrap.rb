require "nokogiri"
require "open-uri"
require 'csv'
filepath = "data/number.csv"
num = 0
array = []
until num == 55
    url = "https://musiquesactuelles.net/annuaire-des-artistes-structures-musiques-actuelles-du-grand-est/pg/#{num}/"
    num += 1
    html_file = URI.open(url).read
    html_doc = Nokogiri::HTML(html_file)
    html_doc.search(".phone-number-block .value").each do |element|
        array << element.text.strip
    end
    p array

    CSV.open(filepath, "wb") do |csv|
        csv << array
    end
end