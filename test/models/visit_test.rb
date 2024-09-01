require "test_helper"

class VisitTest < ActiveSupport::TestCase
  test "should not save visit without url" do
    visit = Visit.new
    assert_not visit.save, "Saved the visit without a url"
  end

  test "should save visit with valid attributes" do
    url = urls(:one)
    visit = Visit.new(url: url, geolocation: "MyString", clicked_at: Time.now)
    assert visit.save, "Could not save the visit with valid attributes"
  end
end
