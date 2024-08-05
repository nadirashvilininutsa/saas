class PlanDescriptionPlan < ApplicationRecord
  belongs_to :plan, optional: false
  belongs_to :plan_description, optional: false
end
