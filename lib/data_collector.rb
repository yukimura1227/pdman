require 'nokogiri'
require 'open-uri'

class DataCollector
  def self.sample
    url = 'http://pd.appbank.net/ml1'
    charset = nil
    html = open(url) do |f|
      charset = f.charset
      f.read
    end

    doc = Nokogiri::HTML.parse(html, nil, charset)
    doc.xpath("//ul[contains(@class,'list-round-rect')]").each do |node|
      node.xpath('li//a').each do |a_tag_node|
        puts "遷移先： #{a_tag_node[:href]} リンク名: #{a_tag_node.inner_html}"
      end
    end
  end
end
