require 'minitest/autorun'
require 'minitest/pride'
require './lib/shopping_cart'

class Test < Minitest::Test

  def test_it_exists_and_has_attributes
    cart = ShoppingCart.new("King Soopers", "30items")

    assert_instance_of ShoppingCart, cart
    assert_equal 'King Soopers', cart.name
    assert_equal 30, cart.capacity
    assert_equal [], cart.products
  end

  def test_it_can_add_products
    cart = ShoppingCart.new("King Soopers", "30items")
    product1 = Product.new(:paper, 'toilet paper', 3.70, '10')
    product2 = Product.new(:meat, 'chicken', 4.50, '2')
    cart.add_product(product1)
    cart.add_product(product2)

    assert_equal [product1, product2], cart.products
  end

  def test_it_can_create_details_hash
    cart = ShoppingCart.new("King Soopers", "30items")
    expected = ({name: "King Soopers", capacity: 30})
    assert_equal expected, cart.details
  end

  def test_total_number_of_products
    cart = ShoppingCart.new("King Soopers", "30items")
    product1 = Product.new(:paper, 'toilet paper', 3.70, '10')
    product2 = Product.new(:meat, 'chicken', 4.50, '2')
    product3 = Product.new(:paper, 'tissue paper', 1.25, '1')
    cart.add_product(product1)
    cart.add_product(product2)
    cart.add_product(product3)
    assert_equal 13, cart.total_number_of_products
  end

  def test_if_cart_is_full?
    cart = ShoppingCart.new("King Soopers", "30items")
    product1 = Product.new(:paper, 'toilet paper', 3.70, '10')
    product2 = Product.new(:meat, 'chicken', 4.50, '2')
    product3 = Product.new(:paper, 'tissue paper', 1.25, '1')
    cart.add_product(product1)
    cart.add_product(product2)
    cart.add_product(product3)
    assert_equal false, cart.is_full?

    product4 = Product.new(:produce, 'apples', 0.99, '20')
    cart.add_product(product4)
    assert_equal true, cart.is_full?
  end

  def test_products_by_category
    cart = ShoppingCart.new("King Soopers", "30items")
    product1 = Product.new(:paper, 'toilet paper', 3.70, '10')
    product2 = Product.new(:meat, 'chicken', 4.50, '2')
    product3 = Product.new(:paper, 'tissue paper', 1.25, '1')
    cart.add_product(product1)
    cart.add_product(product2)
    cart.add_product(product3)
    expected = [product1, product3]
    actual = cart.products_by_category(:paper)

    assert_equal expected, actual
  end

  def test_percentage_occupied
    cart = ShoppingCart.new("King Soopers", "30items")
    product1 = Product.new(:paper, 'toilet paper', 3.70, '10')
    product2 = Product.new(:meat, 'chicken', 4.50, '2')
    product3 = Product.new(:paper, 'tissue paper', 1.25, '1')
    cart.add_product(product1)
    cart.add_product(product2)
    cart.add_product(product3)

    assert_equal 43.33, cart.percentage_occupied
  end

  def test_sorted_products_by_quantity
    cart = ShoppingCart.new("King Soopers", "30items")
    product1 = Product.new(:paper, 'toilet paper', 3.70, '10')
    product2 = Product.new(:meat, 'chicken', 4.50, '2')
    product3 = Product.new(:paper, 'tissue paper', 1.25, '1')
    product4 = Product.new(:produce, 'apples', 0.99, '20')
    cart.add_product(product1)
    cart.add_product(product2)
    cart.add_product(product3)
    cart.add_product(product4)

    expected = [product4, product1, product2, product3]
    actual = cart.sorted_products_by_quantity
    assert_equal expected, actual
  end

  def test_product_breakdown
    cart = ShoppingCart.new("King Soopers", "30items")
    product1 = Product.new(:paper, 'toilet paper', 3.70, '10')
    product2 = Product.new(:meat, 'chicken', 4.50, '2')
    product3 = Product.new(:paper, 'tissue paper', 1.25, '1')
    product4 = Product.new(:produce, 'apples', 0.99, '20')
    cart.add_product(product1)
    cart.add_product(product2)
    cart.add_product(product3)
    cart.add_product(product4)

    expected = ({meat: [product2], paper: [product1, product3], produce: [product4]})
    actual = cart.product_breakdown
    assert_equal expected, actual
  end
end
