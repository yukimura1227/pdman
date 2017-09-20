class ScrapingTarget
  # モンスター詳細ページの解析を担う
  class MonsterDetailPage < ScrapingTarget
    def scraping
      html, charset = extract_html_and_charset(extract_target_url)
      doc = Nokogiri::HTML.parse(html, nil, charset)
      # puts doc.to_html
      extract_monster_detail_page(doc)
    end

    private

    def extract_monster_detail_page(doc)
      monster_div = doc.xpath("//div[contains(@class, 'monster')]").first
      monster_types_area_div =
        monster_div.xpath("div[contains(@class, 'spacer')]").first
      monster_types_tag =
        monster_types_area_div.xpath("p[contains(@class, 'icon-mtype')]").first
      monster_types_tag.xpath('a').each do |node|
        puts node.inner_html
      end
    end
  end
end
