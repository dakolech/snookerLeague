require 'rails_helper'

RSpec.describe Player, :type => :model do
  describe 'validations' do
    it { should validate_presence_of :firstname }
    it { should validate_presence_of :lastname }
    it { should validate_presence_of :date_of_birth }
    it { should validate_presence_of :email }
    it { should validate_presence_of :phone_number }
    it { should validate_presence_of :max_break }
  end
end
