class ParserService
	def render_data
		url = "https://rubysec.com/advisories"
		unparsed_page = HTTParty.get(url)
		parsed_page = Nokogiri::HTML(unparsed_page)
		rows = Array.new
		table_head = parsed_page.css('th')
		table_rows = parsed_page.css('tr')	
		page = 1
		per_page = table_rows.count 
		page_count = parsed_page.css('li').count
		last_page = page_count - 1
		total_gems = last_page.to_i * per_page.to_i
		while page <= last_page
			pagination_url = "https://rubysec.com/advisories?page=#{page}"
			pafination_unparsed_page = HTTParty.get(url)
			pagination_parsed_page = Nokogiri::HTML(unparsed_page)
			pagination_table_rows = parsed_page.css('tr')	
			pagination_table_rows.each do |table_rows|
				row = {
					date: table_rows.css('td')[0].text.gsub(/[\n]/,'' ).strip,
					ruby_gem: table_rows.css('td')[1].text.gsub(/[\n]/,'' ).strip,
					url: "https://rubysec.com" + table_rows.css('a')[0].attributes["href"].value,
					cve: table_rows.css('td')[3].text.gsub(/[\n]/,'' ).strip
				}
			end	
		end
	end


end