class Topic
  include Mongoid::Document
  field :name, type: String
  embeds_many :properties
end
