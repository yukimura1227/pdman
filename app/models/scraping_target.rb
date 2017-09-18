require 'nokogiri'
require 'open-uri'

class ScrapingTarget < ApplicationRecord
  private

  def extract_html_and_charset(url)
    charset = nil
    html = open(url) do |f|
      charset = f.charset
      f.read
    end
    [html, charset]
  end
end
