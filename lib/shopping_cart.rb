
require './lib/product'

class ShoppingCart
  attr_reader :name, :capacity, :products

  def initialize(name, capacity)
    @name = name
    @capacity = capacity[0,2].to_i
    @products = []
  end

  def add_product(product)
    @products << product
  end

  def details
    {name: @name, capacity: @capacity}
  end

  def total_number_of_products
    @products.map do |product|
      product.quantity
    end.sum
  end

  def is_full?
    total_number_of_products > @capacity
  end

  def products_by_category(category)
    @products.find_all do |product|
      product.category == category
    end
  end

  def percentage_occupied
    ((total_number_of_products / @capacity.to_f) * 100).round(2)
  end

  def sorted_products_by_quantity
    @products.sort_by do |product|
      product.quantity
    end.reverse
  end

  def category_keys
    @products.map do |product|
      product.category
    end.uniq
  end

  def product_breakdown
    product_hash = Hash[self.category_keys.collect {|item| [item, []]}]
    product_hash.each do |category, products|
      @products.each do |product|
        if product.category == category
          products << product
        end
      end
    end
  end
end
