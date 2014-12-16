require 'rails_helper'

RSpec.describe Match, :type => :model do
  describe 'validations' do
    it { should validate_presence_of :player_1_frames }
    it { should validate_presence_of :player_2_frames }
    it { should validate_presence_of :date }
  end
end
