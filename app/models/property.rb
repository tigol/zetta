class Property
  include Mongoid::Document
  field :name, type: String
  field :code, type: String
  field :description, type: String
  field :datatype, type: String
  embedded_in :topic
end
