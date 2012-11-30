require 'mongoid/variable_sessions'

class Tot
  include ActiveModel::Serializers::JSON
  include Mongoid::Atomic

  include Mongoid::Attributes
  include Mongoid::Persistence
  include Mongoid::Serialization
  include Mongoid::State

  include Mongoid::Threaded
  include Mongoid::VariableSessions

  attr_accessor :collection_name
  attr_accessor :topic
  attr_accessor :this

  def initialize(topic, id = nil)
    @topic = topic
    @collection_name = "#{topic.code}"
    @this = collection.find(_id: id) if id
  end

  def create(properties)
    @this = collection.insert(properties)
  end

  def destroy

  end

end
