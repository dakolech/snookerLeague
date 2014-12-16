require 'rails_helper'

RSpec.describe Break, :type => :model do
  describe 'validations' do
    it { should validate_presence_of :points }
  end
end
