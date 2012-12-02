require 'test_helper'

class TopicsControllerTest < ActionController::TestCase
  test "get empty topic list" do
    Topic.destroy_all
    get :index, :format => :json
    assert_response :success
    topics = assigns(:topics)
    assert_not_nil topics
    assert_equal 0, topics.length
  end

  test "get topic list" do
    Fabricate(:billing)
    get :index, :format => :json
    assert_response :success
    topics = assigns(:topics)
    assert_not_nil topics
    assert topics.length > 0
  end

  test "show topic" do
    billing_topic = Fabricate(:billing)
    get :show, :id => billing_topic.id, :format => :json
    assert_response :success
    topic = assigns(:topic)
    assert_not_nil topic
    assert_equal billing_topic.id, topic.id
  end

  test "get topic list without json format" do
    Fabricate(:billing)
    get :index
    assert_response 406
  end

  test "create topic with JSON" do
    count = Topic.count
    billing_topic = Fabricate.build(:billing)
    json = billing_topic.to_json
    topic_hash = ActiveSupport::JSON.decode(json)
    post :create, :format => :json, :topic => topic_hash
    assert_response :success
    assert_equal count + 1, Topic.count
    assert_equal billing_topic.name, assigns(:topic).name
  end

  test "update topic with JSON" do
    billing_topic = Fabricate(:billing)
    json = billing_topic.to_json
    json.gsub!(/Billing Statement/, 'Billing Notice')
    topic_hash = ActiveSupport::JSON.decode(json)
    put :update, :id => billing_topic.id, :format => :json, :topic => topic_hash
    assert_response :success
    assert_equal billing_topic.id, assigns(:topic).id
    assert_equal 'Billing Notice', assigns(:topic).name
  end
end
