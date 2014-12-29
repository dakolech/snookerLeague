class Round < ActiveRecord::Base
  belongs_to :league
  has_many :matches, dependent: :destroy

  #validates :start_date, presence: true
  #validates :end_date, presence: true
  #validates :number, presence: true


end
