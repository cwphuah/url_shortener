require "test_helper"

class UrlTest < ActiveSupport::TestCase
  test "should not save url without original_url" do
    url = Url.new
    assert_not url.save, "Saved the url without an original_url"
  end

  test "should save url with valid attributes" do
    url = Url.new(original_url: "https://example.com", short_url: "exmpl")
    assert url.save, "Could not save the url with valid attributes"
  end
end
