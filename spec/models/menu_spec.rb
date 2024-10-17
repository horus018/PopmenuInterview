require 'rails_helper'

RSpec.describe Menu, type: :model do
  let(:menu) { build(:menu) }  # Alterado para `build` para evitar persistência precoce

  context 'validations' do
    it 'is valid with valid attributes' do
      expect(menu).to be_valid
    end

    it 'is not valid without a name' do
      menu.name = nil
      expect(menu).to_not be_valid
      expect(menu.errors[:name]).to include("can't be blank")  # Verifica a mensagem de erro
    end
  end

  context 'associations' do
    it 'has many menu_items' do
      assoc = Menu.reflect_on_association(:menu_items)
      expect(assoc.macro).to eq :has_many
    end
  end
end
