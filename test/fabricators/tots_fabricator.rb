Fabricator(:nov_water_billing, from: :tot) do
  initialize_with { Fabricate(:billing).new_tot }
  
  after_build { |tot|
    tot['billing_month'] = 11

    tot['billing_type'] = 'water'

    tot['amount'] = 23
  }

end

Fabricator(:dec_water_billing, from: :tot) do
  initialize_with { Fabricate(:billing).new_tot }

  after_build { |tot|
    tot['billing_month'] = 12

    tot['billing_type'] = 'water'

    tot['amount'] = 30
  }
end
