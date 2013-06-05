require "faker" unless defined? Faker

FactoryGirl.define do
  sequence :random_id do
    Kernel.rand(4000000000).to_s
  end

  factory :school do
    name { Faker::Company.name }
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip { Faker::Address.zip }
    coordinates { [Faker::Address.longitude, Faker::Address.latitude] }
    type_enum { 1 }
    state_enum { 1 }
  end

  factory :user do
    first_name { Faker::Name.first_name }
    email { Faker::Internet.email }
    salt { "asdasdastr4325234324sdfds" }
    password { "secret" }
    phone_number { Faker::PhoneNumber.cell_phone[0,20] }
    crypted_password { Sorcery::CryptoProviders::BCrypt.encrypt(password, salt) }
    school
  end
end
