class Match < ActiveRecord::Base
  belongs_to :round
  has_many :frames, dependent: :destroy
  belongs_to :player_1, :class_name => 'Player', :foreign_key => 'player_1_id'
  belongs_to :player_2, :class_name => 'Player', :foreign_key => 'player_2_id'

  default_scope { order('id ASC') }

  #validates :player_1_frames, presence: true
  #validates :player_2_frames, presence: true
  #validates :date, presence: true

  def update_frames
    self.player_1_frames = 0
    self.player_2_frames = 0

    self.frames.each do |frame|
      if frame.player_1_points > frame.player_2_points
        self.player_1_frames += 1
      elsif frame.player_1_points < frame.player_2_points
        self.player_2_frames += 1
      end
    end

    self.save
  end
end
