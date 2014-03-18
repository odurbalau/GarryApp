class Rating < ActiveRecord::Base
  attr_accessible :rating, :user, :interest
  belongs_to :user
  belongs_to :interest

  validates :user_id, presence: true
  validates :interest_id, presence: true

end
