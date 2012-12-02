require 'mongoid/variable_sessions'

class Tot
  include ActiveModel::Conversion
  include ActiveModel::MassAssignmentSecurity
  include ActiveModel::Naming
  include ActiveModel::Observing
  include ActiveModel::Serializers::JSON
  include ActiveModel::Serializers::Xml

  include Mongoid::Atomic
  include Mongoid::Dirty
  include Mongoid::VariableSessions

  attr_accessor :collection_name
  attr_accessor :topic
  attr_accessor :properties
  attr_accessor :id

  def initialize(topic, tot_id = nil)
    @topic = topic
    @collection_name = "#{topic.code}"
    if tot_id
      @properties = collection.find(_id: tot_id)
    else 
      @id = Moped::BSON::ObjectId.new
      @properties = {'_id' => @id, 'created_at' => Time.now}
    end
  end

  def create(properties)
    @properties.merge!(properties).merge!({ 'updated_at' => Time.now })
    @this = collection.insert(@properties)
    @properties = @properties.with_indifferent_access
    self
  end

  def [](name)
    @properties[name]
  end

  def []=(name, value)
    @properties = @properties || {}
    @properties[name] = value
  end

  def save!
    Rails.logger.debug "save object with properties #{@properties}"
    collection.find({'_id' => @id }).upsert(@properties.merge!({ 'updated_at' => Time.now }))
  end

end
