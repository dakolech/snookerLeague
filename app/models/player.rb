class Player < ActiveRecord::Base
  has_and_belongs_to_many :leagues, :join_table => 'leagues_players'
  #has_many :matches
  has_many :homematches, :class_name => 'Match', :foreign_key => 'player_1_id'
  has_many :awaymatches, :class_name => 'Match', :foreign_key => 'player_2_id'
  has_many :homeframes, :class_name => 'Frame', :foreign_key => 'player_1_id'
  has_many :awayframes, :class_name => 'Frame', :foreign_key => 'player_2_id'
  #has_many :frames
  has_many :breaks

  validates :firstname, presence: true
  #validates :lastname, presence: true
  validates :date_of_birth, presence: true
  #validates :email, presence: true
  validates :phone_number, presence: true
  validates :max_break, presence: true

  def full_name
    if lastname
      "#{firstname} #{lastname}"
    else
      firstname
    end
  end

  def nice_formating
    self.firstname = self.firstname.capitalize
    self.lastname = self.lastname.capitalize
    self.email = self.email.downcase
    self.save
  end

end
