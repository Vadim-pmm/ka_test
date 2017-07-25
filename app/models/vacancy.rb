class Vacancy < ApplicationRecord
  scope :not_expired, -> { where('expires_at >= ?', Date.today).order(id: :desc) }

  has_many :comments

  def self.get_vacancies (kind_of_search_, search_string_)
    case kind_of_search_
    when 'exact'
      @search_result = not_expired.reject { |item| item.skills != search_string_ }
    when 'not_exact'
      get_data = not_expired
      @search_result = []
      get_data.each do |item|
        @search_result << item if ((item.skills & search_string_).length != 0)
      end
    else
      @search_result = not_expired.map
    end
  end
end
