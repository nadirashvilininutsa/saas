class Plan < ApplicationRecord
  has_and_belongs_to_many :plan_descriptions
  
  # def self.options_for_select
  #   all.map { |plan| ["#{plan.name} - $#{'%.2f' % plan.price}", plan.id] }
  # end
end
