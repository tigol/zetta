require 'test_helper'

class TotTest < ActiveSupport::TestCase
	test 'create tot' do
    billing_topic = Fabricate(:billing)
    
    billing_tot = billing_topic.new_tot

    count = billing_tot.collection.find.count
    billing_tot.create({
      "billing_type" => "IPTV",
      "billing_month" => 10,
      "amount" => 101.5
    })
    assert_equal count + 1, billing_tot.collection.find.count
	end

  test 'all tots for a topic' do
    billing_topic = Fabricate(:billing)
    
    billing_tot = billing_topic.new_tot

    count = billing_tot.collection.find.count
    billing_tot.create({
      "billing_type" => "IPTV",
      "billing_month" => 10,
      "amount" => 101.5
    })
    assert_equal count + 1, billing_tot.collection.find.count

    assert_not_nil billing_topic.code
    assert_equal 1, billing_topic.tots.length
  end
end