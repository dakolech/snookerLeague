class League < ActiveRecord::Base
  has_and_belongs_to_many :players, :join_table => 'leagues_players'
  has_many :tables, dependent: :destroy
  has_many :rounds, dependent: :destroy

  validates :name, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :number_of_winners, presence: true
  validates :number_of_dropots, presence: true
  validates :best_of, presence: true
  validates :win_points, presence: true
  validates :loss_points, presence: true
end