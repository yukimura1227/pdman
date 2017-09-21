# パズドラのモンスター情報を収集する
class DataCollector
  def sample(default_url = '/ml1')
    if ScrapingTarget::MonsterListPage.count.zero?
      ScrapingTarget::MonsterListPage.where(url: default_url).first_or_create
    end
    all_monster_list_page.each(&:scraping)
    all_monster_detail_page.each(&:scraping)
  end

  private

  def all_monster_list_page
    ScrapingTarget::MonsterListPage.all
  end

  def all_monster_detail_page
    ScrapingTarget::MonsterDetailPage.all
  end
end
