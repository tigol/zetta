require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  test 'load all topics' do
    assert Topic.all.length > 0
  end

  test 'read topic fixture' do
    dining_topic = Fabricate(:dining)
    assert_equal 'Dining Everyday', dining_topic.name
    assert_equal 2, dining_topic.properties.size
  end

  test 'create topic' do
    starbucks = Topic.new(
      name: 'Starbucks',
      properties: [
        Property.new(
          name: 'People',
          code: 'people',
          datatype: 'Array'
        ),
        Property.new(
          name: 'When',
          code: 'when',
          datatype: 'String'
        )
      ]
    )
    count = Topic.count
    starbucks.save
    assert_equal count + 1, Topic.count
  end

  test 'topic to json' do
    dining_topic = Fabricate(:dining)
    assert_not_nil dining_topic.to_json
  end

  test 'update topic property attributes via JSON' do
    billing_topic = Fabricate(:billing)
    json = billing_topic.to_json
    json.gsub!(/Billing Month/, "When")
    
    topic_hash = ActiveSupport::JSON.decode(json)
    topic = Topic.find(billing_topic.id)
    topic.update_attributes!(topic_hash)

    assert_equal 3, topic.properties.length
    assert_equal 'When', topic.properties[0].name
  end

  test 'update topic attributes via JSON' do
    billing_topic = Fabricate(:billing)
    json = billing_topic.to_json
    json.gsub!(/Billing Statement/, 'Billing Notice')
    topic_hash = ActiveSupport::JSON.decode(json)
    topic = Topic.find(billing_topic.id)
    topic.update_attributes!(topic_hash)
    assert_equal 'Billing Notice', topic.name
  end
end
