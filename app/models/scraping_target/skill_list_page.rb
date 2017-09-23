# frozen_string_literal: true

class ScrapingTarget
  # スキル一覧ページの解析を担う
  class SkillListPage < ScrapingTarget
    DEFAULT_URL = '/skill/list'.freeze
    def scraping
      return if last_scraping_at.present? && last_scraping_at > 1.day.ago
      sleep 1
      update(last_scraping_at: Time.zone.now, is_success_last: false)
      doc = parse_target
      extract_skill_list_page(doc)
      update(is_success_last: true)
    end

    private

    def extract_skill_list_page(doc)
      doc.xpath("//ul[contains(@class, 'list-item')]").each do |ul_tag|
        ul_tag.xpath('li').each do |li_tag|
          a_tag_node = detect_a_tag_for_skill(li_tag)
          next if a_tag_node.blank?
          page = ScrapingTarget::SkillDetailPage.where(
            url: a_tag_node[:href]
          ).first_or_create
          page.update(link_name: a_tag_node.inner_html)
        end
      end
    end

    def detect_a_tag_for_skill(li_tag_node)
      a_tag_node = li_tag_node.xpath('a').first
      if a_tag_node.present? && a_tag_node[:href].start_with?('/skill')
        return a_tag_node
      else
        return
      end
    end
  end
end
