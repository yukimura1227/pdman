class ScrapingTarget
  # モンスター一覧ページの解析を担う
  class MonsterListPage < ScrapingTarget
    def scraping
      return if last_scraping_at.present? && last_scraping_at > 1.day.ago
      sleep 1
      update(last_scraping_at: Time.zone.now, is_success_last: false)
      doc = parse_target
      extract_monster_list_pages(doc)
      extract_monster_pages(doc)
      update(is_success_last: true)
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

    def extract_monster_pages(doc)
      doc.xpath("//ul[contains(@class,'list-box')]").each do |node|
        node.xpath('li//a').each do |a_tag_node|
          monster_no_trim, monster_name =
            extract_monster_detail_link(a_tag_node)
          update_monster(monster_no_trim, monster_name)
        end
      end
    end

    def extract_monster_detail_link(a_tag)
      href = a_tag[:href]
      page = ScrapingTarget::MonsterDetailPage.where(url: href).first_or_create
      monster_no = a_tag.xpath("div[contains(@class,'num')]").first.inner_html
      monster_no_trim = monster_no.sub('No.', '')
      monster_name =
        a_tag.xpath("div[contains(@class,'name')]").first.inner_html
      page.update(link_name: "#{monster_no} #{monster_name}")
      logger.info "遷移先： #{href} モンスターNo: #{monster_no} 名前: #{monster_name}"
      [monster_no_trim, monster_name]
    end

    def update_monster(monster_no_trim, monster_name)
      m = Monster.find_or_create_by(uid: monster_no_trim)
      Skill.first_or_create!(id: 1, name: :hoge) # TODO: dummy
      m.update!(
        uid: monster_no_trim, name: monster_name,
        skill_id: 1, element_id: 1, sub_element_id: 2, monster_species_id: 1
      ) # TODO: element and species is dummy!!!!
    end
  end
end
