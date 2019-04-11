require 'rubygems'
require 'nokogiri'
require 'open-uri'
page = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))

noms_deputes = []
page.css("div#deputes-list li a").each do | depute |
  noms_deputes << depute.text
end

first_names = Array.new
last_names = Array.new
emails_deputes = Array.new

noms_deputes.each do | depute |
first_names << depute.split[1]
last_names << depute.split[2..-1].join(" ")
emails_deputes << "#{depute.split[1].downcase.gsub(/[èéêë]/, "e").gsub(/[òóôõö]/,'o').gsub(/[ùúûü]/,'u').gsub(/[éàôêë]/, "").gsub(/ç/, 'c').gsub(/[àáâãäå]/,'a')}#{depute.split[2..-1].join("-").downcase.gsub(/[èéêë]/, "e").gsub(/[òóôõö]/,'o').gsub(/[ùúûü]/,'u').gsub(/[éàôêë]/, "").gsub(/ç/, 'c').gsub(/[àáâãäå]/,'a')}@assemblee-nationale.fr"
end
