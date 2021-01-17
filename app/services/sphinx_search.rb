class SphinxSearch
  def self.search_results(search_text)
    query_escape = ThinkingSphinx::Query.escape(search_text.to_s)
    ThinkingSphinx.search query_escape
  end
end
