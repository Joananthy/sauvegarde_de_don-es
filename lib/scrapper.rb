require 'nokogiri'
require 'open-uri'
require 'json'

class Scrapper
  
  def get_mail_commune(url)
    page = Nokogiri::HTML(URI.open(url))
    adress_mail_commune = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text 
    return adress_mail_commune
  end
  
  def get_townhall_email(url)
    page = Nokogiri::HTML(URI.open(url))  
    liens_communes = page.xpath('//p/a')
    name_communes = []  
    mail_communes = [] 
    name_mail_communes = {}
  
    liens_communes.each do |lien|
  
      name_communes.push(lien.text)
  
      mail_communes.push(get_mail_commune("http://annuaire-des-mairies.com#{lien["href"].delete_prefix(".")}"))
  
      name_mail_communes[lien.text] = (get_mail_commune("http://annuaire-des-mairies.com#{lien["href"].delete_prefix(".")}"))
      
      
    end
    return name_mail_communes
  end
  
  def save_as_JSON
    emails = perform
    File.open("db/emails.JSON","w") do |f|
      f.write(emails.to_json)
    end
  end

  def perform
    get_townhall_email("http://annuaire-des-mairies.com/val-d-oise.html")
  end
end