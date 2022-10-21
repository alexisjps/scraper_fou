require "nokogiri"
require "open-uri"
require 'csv'
filepath = "data/number.csv"
num = 0
array = []
array2 = []
browser = 'Safari/5.0 (Macintosh; Intel Mac OS X 10_8_4)
AppleWebKit/536.30.1 (KHTML, like Gecko) Version/6.0.5 Safari/536.30.1'

until num == 55
    url = "https://musiquesactuelles.net/annuaire-des-artistes-structures-musiques-actuelles-du-grand-est/pg/#{num}/"
    num += 1
    html_file = URI.open(url).read
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