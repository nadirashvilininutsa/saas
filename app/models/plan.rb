class Plan < ApplicationRecord

  def self.options_for_select
    all.map { |plan| ["#{plan.name} - $#{'%.2f' % plan.price}", plan.id] }
  end
end
