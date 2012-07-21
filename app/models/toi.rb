require 'mongoid/variable_sessions'

class Toi
  include Mongoid::Threaded
  include Mongoid::VariableSessions

  attr_accessor :collection_name
  attr_accessor :topic

  def initialize(topic)
    @topic = topic
    @collection_name = "#{topic.name}_#{topic._id}"
  end
end
