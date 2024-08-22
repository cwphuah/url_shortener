class Url < ApplicationRecord
    has_many :visits, dependent: :destroy
    validates :original_url, presence: true, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])
    before_create :generate_short_url
    after_create :fetch_title
  
    private
  
    def generate_short_url
        loop do
            self.short_url = SecureRandom.urlsafe_base64(8)
            break unless Url.exists?(short_url: short_url)
        end
    end
  
    def fetch_title
        response = Net::HTTP.get_response(URI.parse(self.original_url))
        self.title = Nokogiri::HTML(response.body).title
        self.save
    rescue
        self.title = "N/A"
        self.save
    end
end
