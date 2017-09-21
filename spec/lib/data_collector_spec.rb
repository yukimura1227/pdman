require 'rails_helper'

RSpec.describe DataCollector do
  describe '#sample' do
    let(:collector) { DataCollector.new }
    before do
      # テストで全件スクレイピングしたくないので、制御するようメソッドをモック化
      allow(collector).to(
        receive(:all_monster_list_page)
          .and_return(ScrapingTarget::MonsterListPage.limit(2))
      )
      allow(collector).to(
        receive(:all_monster_detail_page)
          .and_return(ScrapingTarget::MonsterDetailPage.limit(2))
      )
    end
    it 'can store monsters' do
      collector.sample
      expect(Monster.find(10).name).to eq 'ブラッキオ'
      expect(Monster.count).to eq 100
      expect(ScrapingTarget::MonsterListPage.count).to eq 40
      expect(ScrapingTarget::MonsterDetailPage.count).to eq 100
    end
  end
end
