class Match < ActiveRecord::Base
  belongs_to :round
  has_many :frames#, dependent: :destroy
  belongs_to :player_1, :class_name => 'Player', :foreign_key => 'player_1_id'
  belongs_to :player_2, :class_name => 'Player', :foreign_key => 'player_2_id'

  #validates :player_1_frames, presence: true
  #validates :player_2_frames, presence: true
  #validates :date, presence: true
end
