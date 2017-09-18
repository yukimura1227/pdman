require 'nokogiri'
require 'open-uri'

class DataCollector
  def self.sample(url = 'http://pd.appbank.net/ml1')
    html, charset = extract_html_and_charset(url)

    doc = Nokogiri::HTML.parse(html, nil, charset)
    extract_monster_list_pages(doc)
    extract_monster_pages(doc)
  end

  def self.extract_html_and_charset(url)
    charset = nil
    html = open(url) do |f|
      charset = f.charset
      f.read
    end
    [html, charset]
  end
  private_class_method :extract_html_and_charset

  def self.extract_monster_list_pages(doc)
    doc.xpath("//ul[contains(@class,'list-round-rect')]").each do |node|
      node.xpath('li//a').each do |a_tag_node|
        page = ScrapingTarget::MonsterListPage.where(
          url: a_tag_node[:href]
        ).first_or_create
        page.update(link_name: a_tag_node.inner_html)
      end
    end
  end
  private_class_method :extract_monster_list_pages

  def self.extract_monster_pages(doc)
    doc.xpath("//ul[contains(@class,'list-box')]").each do |node|
      node.xpath('li//a').each do |a_tag_node|
        page = ScrapingTarget::MonsterDetailPage.where(
          url: a_tag_node[:href]
        ).first_or_create
        monster_no =
          a_tag_node.xpath("div[contains(@class,'num')]").first.inner_html
        monster_no_trim = monster_no.sub('No.', '')
        monster_name =
          a_tag_node.xpath("div[contains(@class,'name')]").first.inner_html
        page.update(link_name: "#{monster_no} #{monster_name}")
        puts "遷移先： #{a_tag_node[:href]} モンスターNo: #{monster_no} 名前: #{monster_name}"
        next if Monster.find_by(uid: monster_no_trim)
        # TODO: dummy skill (remove!!!)
        Skill.first_or_create!(id: 1, name: :hoge)
        # TODO: element and species is dummy!!!!
        m = Monster.new(
          uid: monster_no_trim,
          name: monster_name,
          skill_id: 1,
          element_id: 1,
          sub_element_id: 2,
          monster_species_id: 1
        )
        m.save!
      end
    end
  end
  private_class_method :extract_monster_pages
end
