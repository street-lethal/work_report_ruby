require 'nokogiri'

class JiraParser
  attr_reader :works

  def initialize
    @works = []
    input_file_path = '/app_root/jira/input.html'
    return unless File.exist? input_file_path

    @doc = Nokogiri::HTML5(File.open(input_file_path))
    parse
  end

  def merged_works
    @_merged_works ||= works.map { |work| work.join('%2C+')}
  end

  private

  def parse
    @doc.css('.fixedDataTableRowLayout_rowWrapper').each do |ticket|
      title_tags, hour_tags = ticket.css('.fixedDataTableCellGroupLayout_cellGroupWrapper').to_a
      title =  title_tags.css('.public_fixedDataTableCell_cellContent')[1].content.gsub(/\s/, '')
      next if title.empty?
      next if title == 'キー'

      hour_tags.css('.public_fixedDataTableCell_cellContent').each_with_index do |tag, i|
        works[i] ||= []
        works[i] << title unless tag.content.empty?
      end
    end
  end
end
