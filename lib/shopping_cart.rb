
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
end
