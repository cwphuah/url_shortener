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
    end
  
    def redirect
        @url = Url.find_by(short_url: params[:short_url])
        if @url
            track_visit(@url)
            redirect_to @url.original_url
        else
            render plain: "URL not found", status: 404
        end
    end
  
    private
  
    def url_params
        params.require(:url).permit(:original_url)
    end
  
    def track_visit(url)
        url.visits.create(geolocation: request.location.country, clicked_at: Time.current)
    end

    def report
        @url = Url.find(params[:id])
        @visits = @url.visits.order(clicked_at: :desc)
    end
end
  