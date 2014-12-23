class Player < ActiveRecord::Base
  has_and_belongs_to_many :leagues, :join_table => 'leagues_players'
  has_many :matches
  has_many :frames
  has_many :breaks

  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :date_of_birth, presence: true
  validates :email, presence: true
  validates :phone_number, presence: true
  validates :max_break, presence: true

end
