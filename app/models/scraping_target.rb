# frozen_string_literal: true
require 'nokogiri'
require 'open-uri'

# あるページをスクレイピングするための基底クラス
class ScrapingTarget < ApplicationRecord
  SITE_BASE_URL = 'http://pd.appbank.net'.freeze

  def scraping
    fail NotImplementedError, 'please implement scraping!!'
  end

  private

  def parse_target
    html, charset = extract_html_and_charset(extract_target_url)
    Nokogiri::HTML.parse(html, nil, charset)
  end

  def extract_target_url
    "#{SITE_BASE_URL}#{url}"
  end

  def extract_html_and_charset(url)
    charset = nil
    html = open(url) do |f|
      charset = f.charset
      f.read
    end
    [html, charset]
  end
end
