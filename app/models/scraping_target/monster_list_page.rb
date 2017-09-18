class ScrapingTarget
  class MonsterListPage < ScrapingTarget
    def scraping
      html, charset = extract_html_and_charset('http://pd.appbank.net' + url)
      doc = Nokogiri::HTML.parse(html, nil, charset)
      extract_monster_list_pages(doc)
    end

    private

    def extract_monster_list_pages(doc)
      doc.xpath("//ul[contains(@class,'list-round-rect')]").each do |node|
        node.xpath('li//a').each do |a_tag_node|
          page = ScrapingTarget::MonsterListPage.where(
            url: a_tag_node[:href]
          ).first_or_create
          page.update(link_name: a_tag_node.inner_html)
        end
      end
    end
  end
end
