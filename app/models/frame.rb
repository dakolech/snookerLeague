class Frame < ActiveRecord::Base
  belongs_to :match
  has_many :breaks, dependent: :destroy
  belongs_to :player_1, :class_name => 'Player', :foreign_key => 'player_1_id'
  belongs_to :player_2, :class_name => 'Player', :foreign_key => 'player_2_id'

  default_scope { order('id ASC') }

  validates :player_1_points, presence: true
  validates :player_2_points, presence: true
end
