class ChildrenParent < ApplicationRecord
  self.ignored_columns = [:ignored]

  belongs_to :child
  belongs_to :parent
end
