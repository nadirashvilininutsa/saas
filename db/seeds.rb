# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

if Plan.count.zero? && PlanDescription.count.zero? && PlanDescriptionPlan.count.zero?
  free_plan = Plan.create!( name: "Free", price: 0 )
  premium_plan = Plan.create!( name: "Premium", price: 10 )

  plan_common_descriptions = ["Unlimited file uploads", "Responsive design", "Access anywhere"]

  plan_common_descriptions.each do |description|
    plan_description = PlanDescription.create!(content: description)
    free_plan.plan_descriptions << plan_description
    premium_plan.plan_descriptions << plan_description
  end

  free_plan.plan_descriptions.create!(content: "1 project")
  premium_plan.plan_descriptions.create!(content: "Unlimited projects")
end
