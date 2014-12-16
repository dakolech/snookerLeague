class Frame < ActiveRecord::Base
  belongs_to :match
  has_many :breaks
  has_one :player_1, :class_name => 'Player', :foreign_key => 'player_1_id'
  has_one :player_2, :class_name => 'Player', :foreign_key => 'player_2_id'

  validates :player_1_points, presence: true
  validates :player_2_points, presence: true
end
