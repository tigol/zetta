Fabricator(:topic) do
  name { Facker::Name.name }
end

Fabricator(:dining, from: :topic) do
  name { 'Dining Everyday' }
  properties {[
    Property.new(name: 'Location', code: 'location', datatype: 'string'),
    Property.new(name: 'Amount', code: 'amount', datatype: 'double')
  ]}
end

Fabricator(:billing, from: :topic) do
  name { 'Billing Statement' }
  properties {[
    Property.new(name: 'Billing Month', code: 'billing_month', datatype: 'integer'),
    Property.new(name: 'Billing Type', code: 'billing_type', datatype: 'string'),
    Property.new(name: 'Amount', code: 'amount', datatype: 'double')
  ]}
end
