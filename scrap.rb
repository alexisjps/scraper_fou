require "nokogiri"
require "open-uri"
require 'csv'
filepath = "data/number.csv"
num = 0
array = []
array2 = []

until num == 55
    url = "https://musiquesactuelles.net/annuaire-des-artistes-structures-musiques-actuelles-du-grand-est/pg/#{num}/"
    num += 1
    html_file = URI.open(url, "User-Agent" => "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/97.0.4692.99 Safari/537.36").read
    html_doc = Nokogiri::HTML(html_file)
    html_doc.search(".phone-number-block .value").each do |element|
        array << element.text.strip
    end
    html_doc.search(".cn-contact-block").each do |element|
        array2 << element.text.strip
    end
    p array
    p array2

    CSV.open(filepath, "wb") do |csv|
        csv << array2
        csv << array
    end
end