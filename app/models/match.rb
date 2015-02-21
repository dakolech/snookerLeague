class Match < ActiveRecord::Base
  belongs_to :round
  has_many :frames, dependent: :destroy
  belongs_to :player_1, :class_name => 'Player', :foreign_key => 'player_1_id'
  belongs_to :player_2, :class_name => 'Player', :foreign_key => 'player_2_id'

  default_scope { order('id ASC') }

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

  def generate_frames(best_of)
    best_of.times do
      frame = Frame.create!(player_1_points: 0,
                            player_2_points: 0)

      self.frames << frame
    end
  end

end
