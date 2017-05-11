# == Schema Information
#
# Table name: polls
#
#  id            :integer          not null, primary key
#  title         :string           not null
#  description   :text             not null
#  closing_date  :date             not null
#  users_id       :integer
#  totals        :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  poll_image    :string
#  active        :boolean          default(TRUE)
#  poll_document :string
#

FactoryGirl.define do
  factory :poll do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    closing_date { Date.tomorrow }
    totals "{1=>#{Faker::Number.number(3)}, 2=>#{Faker::Number.number(3)}}"
    to_create { |instance| instance.save(validate: false) }

    factory :poll_with_votes do
      after(:create) do |poll|
        5.times do
          poll.votes << FactoryGirl.create(:vote)
        end
      end
    end
    factory :poll_with_votes_and_debates do
      after(:create) do |poll|
        5.times do
          poll.votes << FactoryGirl.create(:vote)
          poll.debates << FactoryGirl.create(:debate_with_questions)
        end
      end
    end
  end
end
