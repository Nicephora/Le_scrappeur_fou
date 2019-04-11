require 'rubygems'
require 'nokogiri'
require 'open-uri'



def scrap_name(page)
  monnaie = Array.new
monnaie_nom = page.css("td.no-wrap.currency-name")
monnaie_nom.each do |crypto_monnaie|
  monnaie <<  crypto_monnaie.css('a.link-secondary')[0].text
end
return monnaie
end

def scrap_cours(monnaie, page)
cours = Array.new
monnaie_cours = page.css('td > a.price')
monnaie_cours.each do |cour|
 cours << "%f" % cour.text[1..-1].to_f # [1..-1] permet d'enlever le dollar # "%f" % enleve lecriture scientifique
end
result = Hash[monnaie.zip(cours)]
final_result = []
final_result << result
print final_result
end

def perform
  page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/#"))
  devise = scrap_name(page)
  scrap_cours(devise, page)
end

perform
