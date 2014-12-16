require 'rails_helper'

RSpec.describe Frame, :type => :model do
  describe 'validations' do
    it { should validate_presence_of :player_1_points }
    it { should validate_presence_of :player_2_points }
  end
end
