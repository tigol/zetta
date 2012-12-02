require 'forgery'

class Topic
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :code, type: String

  validates_presence_of :name
  validates_uniqueness_of :code
  attr_readonly :code

  before_destroy :destroy_tot_collection

  embeds_many :properties

  before_create :generate_code
  
  def new_tot
    tot = Tot.new(self)
  end

  def tot(tot_id)
    tot = Tot.new(self, tot_id)
  end

  def tots
    tots = []
    if self.code
      session = Topic.mongo_session
      collection = session[self.code]
      collection.find.each do |t|
        tots << t
      end
    end
    tots
  end

  private
  def generate_code
    color = Forgery::Basic.color
    street = Forgery::Address.street_name.split(" ").first
    time_stamp = Time.now.strftime("%Y%m%d_%H%M%S%L")

    self.code = [color, street, time_stamp].join("_").downcase
    logger.debug "generate #{self.code} for topic #{name}"
  end

  def destroy_tot_collection
    session = Topic.mongo_session
    collection = session[self.code]
    collection.drop
  end
end
