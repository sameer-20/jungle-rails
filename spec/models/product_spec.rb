require 'rails_helper'

RSpec.describe Product, type: :model do
  
  describe 'Validations' do
    
    context 'given name, price, quantity and category' do
      it 'product saves successfully' do
        @category = Category.new(name: 'Electronics')
        @product = Product.new(name: 'ABC Headphones', price: 30, quantity: 21, category: @category)
        expect(@product).to be_valid
      end
    end

    context 'given price, quantity and category but no name' do 
      it 'product does not save' do
        @category = Category.new(name: 'Electronics')
        @product = Product.new(name: '', price: 30, quantity: 21, category: @category)
        expect(@product).to_not be_valid
        expect(@product.errors.full_messages).to include("Name can't be blank")
      end
    end  

    context 'given name, quantity and category but no price' do 
      it 'product does not save' do
        @category = Category.new(name: 'Electronics')
        @product = Product.new(name: 'ABC headphones', price: nil, quantity: 21, category: @category)
        expect(@product).to_not be_valid
        expect(@product.errors.full_messages).to include("Price can't be blank")
      end
    end

    context 'given name, price and category but no quantity' do 
      it 'product does not save' do
        @category = Category.new(name: 'Electronics')
        @product = Product.new(name: 'ABC headphones', price: 20, quantity: nil, category: @category)
        expect(@product).to_not be_valid
        expect(@product.errors.full_messages).to include("Quantity can't be blank")
      end
    end

    context 'given name, price and quantity but no category' do 
      it 'product does not save' do
        @product = Product.new(name: 'ABC headphones', price: 20, quantity: 5, category: nil)
        expect(@product).to_not be_valid
        expect(@product.errors.full_messages).to include("Category can't be blank")
      end
    end

  end

end
