class Property
  include Mongoid::Document
  field :name, type: String # a human readable name for this property
  field :code, type: String # a unique code to identify this property
  field :description, type: String
  field :datatype, type: String # data type, including string/integer/decimal/enum/location
  embedded_in :topic
end
