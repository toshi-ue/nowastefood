# frozen_string_literal: true

FactoryBot.define do
  factory :foodstuff do
    association :cuisine
    association :rawmaterial

    sequence(:quantity, &:to_s)
    # sequence(:row_order) {|n| "#{n}" }

    trait :full_width_fraction do
      quantity { '１／２' }
    end

    trait :full_width_fraction_with_space do
      quantity { '　１ ／ ２ ' }
    end

    trait :half_size_fraction do
      quantity { '1/2' }
    end

    trait :only_full_width_number do
      quantity { '１' }
    end

    trait :only_half_size_number do
      quantity { '1' }
    end

    trait :only_half_size_number_with_space do
      quantity { ' 1　' }
    end
  end
end
