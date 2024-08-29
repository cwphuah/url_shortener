class UrlsController < ApplicationController
    def new
        @url = Url.new
        @urls = Url.order(created_at: :desc)
    end
  
    def create
        @url = Url.new(url_params)
        if @url.save
            redirect_to new_url_path, notice: 'URL was successfully shortened.'
        else
            @urls = Url.order(created_at: :desc)
            render :new
        end
    end
  
    def show
        @url = Url.find_by(short_url: params[:short_url])
        if @url.nil?
            render plain: "URL not found", status: 404
        else
            @location = Geocoder.search(request.remote_ip).first
        end
    end
  
    def redirect
        @url = Url.find_by(short_url: params[:short_url])
        if @url
            track_visit(@url)
            redirect_to @url.original_url, allow_other_host: true
        else
            render plain: "URL not found", status: 404
      end
    end
  
    def report
        @url = Url.find(params[:id])
        @visits = @url.visits.order(clicked_at: :desc)
    end
  
    private
  
    def url_params
        params.require(:url).permit(:original_url)
    end
  
    def track_visit(url)
        location = Geocoder.search(request.remote_ip).first
        country = location ? location.country : "Unknown"
        url.visits.create(geolocation: country, clicked_at: Time.current)
    end
end
