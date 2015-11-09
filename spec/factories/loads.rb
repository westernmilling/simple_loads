FactoryGirl.define do
  factory :load, class: Load do
    customer_name { Faker::Company.name }
    customer_location do
      [
        Faker::Address.street_address,
        Faker::Address.city,
        Faker::Address.state,
        Faker::Address.zip,
        'United States'
      ].join(' ')
    end
    order_number { Faker::Number.number(6) }
    origin_location { "#{Faker::Address.city} #{Faker::Address.state}" }
    product_description { Faker::Commerce.product_name }
    requested_date { Date.current }
    status :new
  end
end
