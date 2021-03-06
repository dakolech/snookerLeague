class Player < ActiveRecord::Base
  has_and_belongs_to_many :leagues, :join_table => 'leagues_players'
  has_many :homematches, :class_name => 'Match', :foreign_key => 'player_1_id'
  has_many :awaymatches, :class_name => 'Match', :foreign_key => 'player_2_id'
  has_many :homeframes, :class_name => 'Frame', :foreign_key => 'player_1_id'
  has_many :awayframes, :class_name => 'Frame', :foreign_key => 'player_2_id'
  has_many :breaks

  validates :firstname, presence: true
  validates :date_of_birth, presence: true
  validates :email, presence: true
  validates :phone_number, presence: true
  validates :max_break, presence: true

  before_save :downcasing

  def full_name
    if lastname
      "#{firstname.capitalize} #{lastname.capitalize}"
    else
      firstname.capitalize
    end
  end

  def downcasing
    self.firstname = self.firstname.downcase if self.firstname
    self.lastname = self.lastname.downcase if self.lastname
    self.email = self.email.downcase if self.email
    self.city = self.city.downcase if self.city
  end

end
