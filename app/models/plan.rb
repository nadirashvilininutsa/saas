class Plan < ApplicationRecord
  has_many :plan_description_plans, dependent: :destroy
  has_many :plan_descriptions, through: :plan_description_plans

  has_many :organizations

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true

  def self.options_for_select
    all.map { |plan| ["#{plan.name} - $#{'%.2f' % plan.price}", plan.id] }
  end
end
