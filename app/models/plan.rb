class Plan < ApplicationRecord
  has_many :plan_description_plans
  has_many :plan_descriptions, through: :plan_description_plans
end
