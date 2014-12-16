require 'rails_helper'

RSpec.describe Table, :type => :model do
  describe 'validations' do
    it { should validate_presence_of :position }
    it { should validate_presence_of :number_of_matches }
    it { should validate_presence_of :points }
    it { should validate_presence_of :number_of_wins }
    it { should validate_presence_of :number_of_loss }
    it { should validate_presence_of :number_of_win_frames }
    it { should validate_presence_of :number_of_lose_frames }
    it { should validate_presence_of :number_of_win_small_points }
    it { should validate_presence_of :number_of_lose_small_points }
  end
end
