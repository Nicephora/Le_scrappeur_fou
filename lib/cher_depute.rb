require 'rubygems'
require 'nokogiri'
require 'open-uri'


def get_data
page = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))
noms_deputes = []
page.css("div#deputes-list li a").each do | depute |
  noms_deputes << depute.text
end
return noms_deputes
end

def variables (noms_deputes)
first_names = Array.new
last_names = Array.new
emails_deputes = Array.new

noms_deputes.each do | depute |
first_names << depute.split[1]
last_names << depute.split[2..-1].join(" ")
emails_deputes << "#{depute.split[1].downcase.gsub(/[èéêë]/, "e").gsub(/[òóôõö]/,'o').gsub(/[ùúûü]/,'u').gsub(/[éàôêë]/, "").gsub(/ç/, 'c').gsub(/[àáâãäå]/,'a')}#{depute.split[2..-1].join("-").downcase.gsub(/[èéêë]/, "e").gsub(/[òóôõö]/,'o').gsub(/[ùúûü]/,'u').gsub(/[éàôêë]/, "").gsub(/ç/, 'c').gsub(/[àáâãäå]/,'a')}@assemblee-nationale.fr"
end
array_of_arrays = []

for n in (0..577) do
  array_of_arrays << first_names[n]
  array_of_arrays << last_names[n]
  array_of_arrays << emails_deputes[n]
end

array_slice =  array_of_arrays.each_slice(3).to_a
array_final_result = []
array_slice.each { |info| array_final_result << {'first_name' => info[0], 'last_names' => info[1], 'email' => info[2]} }
print array_final_result
end

def perform
  noms_deputes = get_data
  variables(noms_deputes)
end

perform
