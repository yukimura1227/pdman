require 'rails_helper'

RSpec.describe ScrapingTarget::MonsterListPage, type: :model do
  let(:target_page) do
    create(:monster_list_page, url: '/ml1')
  end
  describe '#scraping' do
    it 'can store monster' do
      target_page.scraping
      expect(Monster.count).to eq 100
      expect(ScrapingTarget::MonsterListPage.count).to eq 40
      expect(ScrapingTarget::MonsterDetailPage.count).to eq 100
    end
  end
end
