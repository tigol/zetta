require 'test_helper'

class TotsControllerTest < ActionController::TestCase
  test "get tots list for JSON format" do
    get_all_tots(:json)
  end

  test "get tots list for Atom format" do
    get_all_tots(:atom)
  end

  test "get tots list for Excel format" do
    get_all_tots(:xlsx)
  end

  private
  def get_all_tots(format)
    billing_topic = Fabricate(:billing)
    get :index, :format => format, :topic_id => billing_topic.id
    assert_response :success
    tots = assigns(:tots)
    assert_not_nil tots
    assert tots.length > 0
  end
end
