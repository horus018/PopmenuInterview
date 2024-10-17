require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  let(:restaurant) { build(:restaurant) }

  context 'Restaurant validations' do
    it 'Is valid' do
      expect(restaurant).to be_valid
    end

    it 'Is not valid without a name' do
      restaurant.name = nil
      expect(restaurant).to_not be_valid
    end
  end

  context 'Verify associations' do
    it 'Has many menus' do
      association = Restaurant.reflect_on_association(:menus)
      expect(association.macro).to eq :has_many
    end
  end
end
