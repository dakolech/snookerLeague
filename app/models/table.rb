class Table < ActiveRecord::Base
  belongs_to :league
  belongs_to :player

  validates :position, presence: true
  validates :number_of_matches, presence: true
  validates :points, presence: true
  validates :number_of_wins, presence: true
  validates :number_of_loss, presence: true
  validates :number_of_win_frames, presence: true
  validates :number_of_lose_frames, presence: true
  validates :number_of_win_small_points, presence: true
  validates :number_of_lose_small_points, presence: true


end
