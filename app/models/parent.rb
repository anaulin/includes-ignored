class Parent < ApplicationRecord
  has_many :children_parents
  has_many :children, through: :children_parents
end
