FactoryGirl.define do
  factory :scraping_target do
    type 'ScrapingTarget::MonsterListPage'
    url 'MyString'
    link_name 'MyString'
    last_scraping_at '2017-09-18 01:24:59'
    is_success_last false
    log_message 'MyText'
  end
  factory :monster_list_page, parent: :scraping_target, class: 'ScrapingTarget::MonsterListPage' do
    type 'ScrapingTarget::MonsterListPage'
  end
  factory :monster_detail_page, parent: :scraping_target, class: 'ScrapingTarget::MonsterDetailPage' do
    type 'ScrapingTarget::MonsterDetailPage'
  end
end
