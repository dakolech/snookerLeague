require 'rails_helper'

RSpec.describe League, :type => :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :start_date }
    it { should validate_presence_of :end_date }
    it { should validate_presence_of :number_of_winners }
    it { should validate_presence_of :number_of_dropots }
    it { should validate_presence_of :best_of }
    it { should validate_presence_of :win_points }
    it { should validate_presence_of :loss_points }
  end
end
