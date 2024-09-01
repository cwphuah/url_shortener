require "test_helper"

class UrlsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @url = urls(:one)
  end

  test "should get index" do
    get urls_url
    assert_response :success
  end

  test "should create url" do
    assert_difference('Url.count') do
      post urls_url, params: { url: { original_url: 'https://example.com', short_url: 'exmpl' } }
    end
    assert_redirected_to url_url(Url.last)
  end

  test "should show url" do
    get url_url(@url)
    assert_response :success
  end
end
