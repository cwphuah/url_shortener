module ApplicationHelper
    def short_url(short_code)
        "#{request.base_url}/#{short_code}"
    end
end