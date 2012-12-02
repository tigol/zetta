require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  test 'load all topics' do
    assert Topic.all.length > 0
  end

  test 'read topic fixture' do
    dining_topic = Fabricate(:dining)
    assert_equal 'Dining Everyday', dining_topic.name
    assert_not_nil dining_topic.created_at
    assert_not_nil dining_topic.updated_at
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
    assert_not_nil starbucks.code
    assert_not_nil starbucks.created_at
    assert_not_nil starbucks.updated_at
    assert_equal count + 1, Topic.count
  end

  test 'create topic without name should fail' do
    starbucks = Topic.new(
      properties: [
        Property.new(
          name: 'People',
          code: 'people',
          datatype: 'Array'
        )
      ]
    )
    
    assert_raise(Mongoid::Errors::Validations) do
      starbucks.save!
    end
  end

  test 'update topic code should fail' do
    billing_topic = Fabricate(:billing)
    topic = Topic.find(billing_topic.id)
    old_code = topic.code
    topic.code = 'new-code'
    topic.save! 
    assert_equal old_code, topic.code, "the change to the code attribute should be ignored"
    assert_raise(Mongoid::Errors::ReadonlyAttribute) do
      topic.update_attribute(:code, 'new-code')
    end
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
    topic_hash = HashWithIndifferentAccess.new(topic_hash)
    assert_not_nil topic_hash[:properties]
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

  test 'destroy a topic should destroy its tots collection' do
    billing_topic = Fabricate(:billing)
    session = billing_topic.mongo_session
    assert collection_exist?(session, billing_topic.code)
    billing_topic.destroy
    assert !collection_exist?(session, billing_topic.code)
  end

  private 
  def collection_exist?(session, collection_name) 
    session.collection_names.include? collection_name
  end
end
