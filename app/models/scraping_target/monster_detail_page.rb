class ScrapingTarget
  # モンスター詳細ページの解析を担う
  class MonsterDetailPage < ScrapingTarget
    def scraping
      html, charset = extract_html_and_charset(extract_target_url)
      doc = Nokogiri::HTML.parse(html, nil, charset)
      puts doc.to_html
    end
  end
end
