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


  def reset_all
    self.position = 0
    self.number_of_matches = 0
    self.points = 0
    self.number_of_wins = 0
    self.number_of_loss = 0
    self.number_of_win_frames = 0
    self.number_of_lose_frames = 0
    self.number_of_win_small_points = 0
    self.number_of_lose_small_points = 0

    self.save
  end

  def win_match(points)
    self.number_of_matches += 1
    self.number_of_wins += 1
    self.points += points

    self.save
  end

  def loss_match(points)
    self.number_of_matches += 1
    self.number_of_loss += 1
    self.points += points

    self.save
  end

  def win_frame(win_points, loss_points)
    self.number_of_win_frames += 1
    self.update_points(win_points, loss_points)

    self.save
  end

  def loss_frame(win_points, loss_points)
    self.number_of_lose_frames += 1
    self.update_points(win_points, loss_points)

    self.save
  end

  def update_points(win_points, loss_points)
    self.number_of_win_small_points += win_points
    self.number_of_lose_small_points += loss_points
    self.diff_small_points = self.number_of_win_small_points - self.number_of_lose_small_points

    self.save
  end

  def update_position(position)
    self.position = position

    self.save
  end

end
