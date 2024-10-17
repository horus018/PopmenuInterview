require 'rails_helper'

RSpec.describe Menu, type: :model do
  let(:restaurant) { create(:restaurant) }
  let(:menu) { build(:menu, restaurant: restaurant) }

  context 'Validations' do
    it 'Is valid' do
      expect(menu).to be_valid
    end

    it 'Is not valid without a name' do
      menu.name = nil
      expect(menu).to_not be_valid
    end
  end

  context 'Verify associations' do
    it 'Has many menu_items' do
      association = Menu.reflect_on_association(:menu_items)
      expect(association.macro).to eq :has_and_belongs_to_many
    end
  end
end
