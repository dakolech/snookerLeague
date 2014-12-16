require 'rails_helper'

RSpec.describe Round, :type => :model do
  describe 'validations' do
    it { should validate_presence_of :start_date }
    it { should validate_presence_of :end_date }
    it { should validate_presence_of :number }
  end
end
