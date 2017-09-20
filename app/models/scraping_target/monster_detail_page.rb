class ScrapingTarget
  # モンスター詳細ページの解析を担う
  class MonsterDetailPage < ScrapingTarget
    def scraping
      return if last_scraping_at.present? && last_scraping_at > 1.day.ago
      sleep 1
      update(last_scraping_at: Time.zone.now, is_success_last: false)
      html, charset = extract_html_and_charset(extract_target_url)
      doc = Nokogiri::HTML.parse(html, nil, charset)
      extract_monster_detail_page(doc)
      update(is_success_last: true)
    end

    private

    def extract_monster_detail_page(doc)
      monster_div = doc.xpath("//div[contains(@class, 'monster')]").first
      monster_types_area_div =
        monster_div.xpath("div[contains(@class, 'spacer')]").first
      uid, name = extract_moster_id_an_name(monster_div)

      monster_types_tag =
        monster_types_area_div.xpath("p[contains(@class, 'icon-mtype')]").first
      monster_types_tag.xpath('a').each do |node|
        puts node.inner_html
      end
      update_monster(uid, name)
    end

    def extract_moster_id_an_name(monster_div)
      target =
        monster_div.xpath("h2[contains(@class, 'title-bg')]").first.inner_html
      /No\.(?<capture_uid>\d+)\s(?<capture_name>.+)/ =~ target
      [capture_uid, capture_name]
    end

    def update_monster(uid, name)
      m = Monster.find_or_initialize_by(uid: uid)
      Skill.first_or_create!(id: 1, name: :hoge) # TODO: dummy
      m.update!(
        uid: uid, name: name,
        skill_id: 1, element_id: 1, sub_element_id: 2, monster_species_id: 1
      ) # TODO: element and species is dummy!!!!
    end
  end
end
