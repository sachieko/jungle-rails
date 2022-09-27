require 'rails_helper'
require 'database_cleaner/active_record'

DatabaseCleaner.strategy = :truncation

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    product_sample = {:name => 'Green tea tree', :description => 'I just like green tea', :price => 19.99, :category_id => 1, :quantity => 5, :image => 'https://i.pinimg.com/originals/f1/8e/90/f18e90ea15b8a0739a2ca6c9cba75b43.jpg'}

    before(:each) do
      Category.create({:id => 1, :name => 'Trees'})
      @product = Product.new(product_sample)
    end

    after(:each) do
      DatabaseCleaner.clean
    end
    
    context 'with all necessary items' do
      it 'should save correctly when all fields are present' do
        
        expect(@product[:name]).to eq('Green tea tree')
        expect(@product[:description]).to eq('I just like green tea')
        expect(@product[:category_id]).to eq(1)
        expect(@product[:quantity]).to eq(5)
        expect(@product[:price_cents]).to eq(1999)
        expect(@product).to be_valid
        @product.save!

        expect(@product.id).to be_present
      end
    end
    context 'while missing a required field' do
      it 'should not save when missing a name' do
        @product.name = nil
        expect(@product[:name]).to eq(nil)
        
        @product.validate
        expect(@product).to be_invalid
        expect(@product.errors[:name]).to include("can't be blank")
      end
      it 'should not save when missing a required field' do
        @product.price = nil
        @product.price_cents = nil
        expect(@product[:price]).to eq(nil)
        
        @product.validate
        expect(@product).to be_invalid
        expect(@product.errors[:price]).to include("can't be blank")
      end
      it 'should not save when missing a required field' do
        @product.quantity = nil
        expect(@product[:quantity]).to eq(nil)
        
        @product.validate
        expect(@product).to be_invalid
        expect(@product.errors[:quantity]).to include("can't be blank")
      end
      it 'should not save when missing a required field' do
        @product.category_id = nil
        expect(@product[:category_id]).to eq(nil)
        
        @product.validate
        expect(@product).to be_invalid
        expect(@product.errors[:category]).to include("can't be blank")
      end
    end
  end
end