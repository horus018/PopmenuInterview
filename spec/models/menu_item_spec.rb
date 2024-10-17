require 'rails_helper'

RSpec.describe MenuItem, type: :model do
  let(:restaurant) { create(:restaurant) }
  let(:menu) { create(:menu, restaurant: restaurant) }
  let(:menu_item) { build(:menu_item, menu: menu) }

  context 'Validations' do
    it 'Is valid' do
      expect(menu_item).to be_valid
    end

    it 'Is not valid without a name' do
      menu_item.name = nil
      expect(menu_item).to_not be_valid
      expect(menu_item.errors[:name]).to include("can't be blank") # Model error message
    end

    it 'Is not valid without a price' do
      menu_item.price = nil
      expect(menu_item).to_not be_valid
      expect(menu_item.errors[:price]).to include("can't be blank")  # Model error message
    end

    it 'Is not valid if the price is less than or equal to zero' do
      menu_item.price = 0
      expect(menu_item).to_not be_valid
      expect(menu_item.errors[:price]).to include("must be greater than 0")  # Model error message
    end

    it 'Validates uniqueness of name' do
      duplicate_item = MenuItem.new(name: 'PopBurguer')
      expect(duplicate_item.valid?).to be_falsey
    end
  end

  context 'Associations' do
    it 'Belongs to a menu' do
      association = MenuItem.reflect_on_association(:menus)
      expect(association.macro).to eq :has_and_belongs_to_many
    end

    it 'Destroys associated menu items when menu is deleted' do
      expect { menu.destroy }.to change(MenuItem, :count).by(0)
    end
  end
end
