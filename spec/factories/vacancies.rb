FactoryGirl.define do

  factory :vacancy do
    name         { Faker::Company.profession + ' at ' + Faker::Company.name }
    expires_at   { Faker::Date.between(20.days.since, Date.today)           }
    salary       { Faker::Number.between(5_000, 50_000)                     }
    contact_info { Faker::Address.street_address                            }
  end

  after(:build) do |vacancy|
    skills_ = rand(1..5)
    0.upto(skills_) { |i| vacancy.skills[i] = Faker::Job.key_skill }
  end

  factory :invalid_vacancy do
    name nil
  end

  factory :vacancy_unordered do
    name         { Faker::Company.profession + ' at ' + Faker::Company.name }
    expires_at   { Faker::Date.between(20.days.since, Date.today)           }
    salary       { Faker::Number.between(5_000, 50_000)                     }
    contact_info { Faker::Address.street_address                            }

    after(:build) do |vacancy|
      vacancy.skills[0] = 1
      vacancy.skills[1] = 4
      vacancy.skills[2] = 3
      vacancy.skills[3] = 2
    end
  end
end