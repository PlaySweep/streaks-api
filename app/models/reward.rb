class Reward < ApplicationRecord
  ELIGIBILITY_LIST = [1, 2, 4, 6]

  belongs_to :user
  belongs_to :prize, optional: true
end
