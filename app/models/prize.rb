class Prize < ApplicationRecord
  enum is_type: [ :physical, :digital ]
end
