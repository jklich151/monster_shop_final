class Discount < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :percentage_off
  validates_presence_of :minimum_quantity

  belongs_to :merchant
end
