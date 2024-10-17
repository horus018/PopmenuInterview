require 'rails_helper'

RSpec.describe MenuItem, type: :model do
  let(:menu) { create(:menu) }
  let(:menu_item) { build(:menu_item, menu: menu) }  # Alterado para `build` para evitar persistência precoce

  context 'validations' do
    it 'is valid with valid attributes' do
      expect(menu_item).to be_valid
    end

    it 'is not valid without a name' do
      menu_item.name = nil
      expect(menu_item).to_not be_valid
      expect(menu_item.errors[:name]).to include("can't be blank")  # Verifica a mensagem de erro
    end

    it 'is not valid without a price' do
      menu_item.price = nil
      expect(menu_item).to_not be_valid
      expect(menu_item.errors[:price]).to include("can't be blank")  # Verifica a mensagem de erro
    end

    it 'is not valid if the price is less than or equal to zero' do
      menu_item.price = 0
      expect(menu_item).to_not be_valid
      expect(menu_item.errors[:price]).to include("must be greater than 0")  # Verifica a mensagem de erro
    end
  end

  context 'associations' do
    it 'belongs to a menu' do
      assoc = MenuItem.reflect_on_association(:menu)
      expect(assoc.macro).to eq :belongs_to
    end
  end
end
