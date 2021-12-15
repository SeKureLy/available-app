# frozen_string_literal: true

# Page object for home page
class HomePage
  include PageObject

  page_url 'http:localhost:9090'
  h1(:home_page_title)
  text_field(:search_bar_input)
  button(:search_button)
  table(:search_result_table)

  def num_results
    search_result_table_element.rows - 1
  end

  def search(keyword)
    self.search_bar_input = keyword
    search_button
  end

  # index : which table row
  # concat full row content text
  def table_content(index)
    search_result_table_element.trs[index].text
  end

  # index : which table row
  # column_index : which column
  def table_cell_content(index, column_index)
    search_result_table_element.trs[index][column_index].text
  end
end
