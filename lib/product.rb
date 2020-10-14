class Product
  attr_reader :category, :name, :unit_price, :quantity

  def initialize(category, name, unit_price, quantity)
    @category = category
    @name = name
    @unit_price = unit_price
    @quantity = quantity.to_i
    @hoard_status = false
  end

  def total_price
    @unit_price * @quantity
  end

  def is_hoarded?
    @hoard_status
  end

  def hoard
    @hoard_status = true
  end
end
