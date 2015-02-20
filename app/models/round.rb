class Round < ActiveRecord::Base
  belongs_to :league
  has_many :matches, dependent: :destroy

  default_scope { order('number ASC') }


end
