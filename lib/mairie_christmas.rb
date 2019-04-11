require 'rubygems'
require 'nokogiri'
require 'open-uri'


def get_townhall_email(townhall_url)
  mail_sample = []
  townhall_url.each do |url|
    code_html = Nokogiri::HTML(open(url))
    mail_sample << code_html.css("td")[7].text
  end
  puts mail_sample.length
  print mail_sample
  return mail_sample
end



def get_townhall_urls (page)
  val_doise = page.css("a.lientxt")
  townhall_url = []
  val_doise.each do |ville|
      townhall_url << "http://annuaire-des-mairies.com#{ville['href'][1..-1]}"
  end
  return townhall_url
end

def perform
  page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
  url_array = get_townhall_urls(page)
  get_townhall_email(url_array)
end

perform
