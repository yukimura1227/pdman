require 'rails_helper'

RSpec.describe ScrapingTarget::SkillListPage, type: :model do
  let(:target_page) do
    create(:skill_list_page, url: ScrapingTarget::SkillListPage::DEFAULT_URL)
  end
  describe '#scraping' do
    it 'can store skills' do
      target_page.scraping
      expect(ScrapingTarget::SkillDetailPage.count).to be > 200
    end
  end
end
