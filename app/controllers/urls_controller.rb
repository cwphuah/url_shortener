class UrlsController < ApplicationController
    before_action :set_url, only: [:show, :destroy]

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
        @url = Url.find(params[:id])
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

    def destroy
        @url.destroy
        puts "Current urls_path: #{urls_path}"  # This will print the urls_path to the console
        respond_to do |format|
            format.html { redirect_to urls_path, notice: 'URL was successfully deleted.' }
            format.json { head :no_content }
        end
    end

    private

    def set_url
        @url = Url.find(params[:id])
    end
    
    def url_params
        params.require(:url).permit(:original_url)
    end
  
    def track_visit(url)
        location = Geocoder.search(request.remote_ip).first
        country = location ? location.country : "Unknown"
        url.visits.create(geolocation: country, clicked_at: Time.current)
    end
end
