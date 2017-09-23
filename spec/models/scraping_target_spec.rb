require 'rails_helper'

RSpec.describe ScrapingTarget::MonsterDetailPage, type: :model do
  let(:target_page) do
    create(:monster_detail_page, url: '/m010')
  end
  describe '#scraping' do
    it 'can store monster' do
      target_page.scraping
      expect(Monster.find_by(uid: 10).name).to eq 'ブラッキオ'
    end
  end
end
