class Break < ActiveRecord::Base
  belongs_to :frame
  belongs_to :player

  default_scope { order('created_at ASC') }

  validates :points, presence: true

end
