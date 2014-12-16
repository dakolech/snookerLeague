class Break < ActiveRecord::Base
  belongs_to :frame
  belongs_to :player

  validates :points, presence: true

end
