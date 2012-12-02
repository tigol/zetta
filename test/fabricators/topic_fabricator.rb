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

  after_create do |billing|
    nov_water_billing_tot = billing.new_tot
    nov_water_billing_tot['billing_month'] = 11
    nov_water_billing_tot['billing_type'] = 'water'
    nov_water_billing_tot['amount'] = 23
    nov_water_billing_tot.save!

    dec_water_billing_tot = billing.new_tot
    dec_water_billing_tot['billing_month'] = 12
    dec_water_billing_tot['billing_type'] = 'water'
    dec_water_billing_tot['amount'] = 30
    dec_water_billing_tot.save!
  end
end

