require 'test_helper' 

class ProductTest < ActiveSupport::TestCase
  fixtures :products
  # loading fixture file(s)
  # the default is to load all the fixtures

  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid? # assert expects it's argument to return TRUE
    assert product.errors[:title].any? # if it is so then the test fails at that point
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "product price must be positive" do
    product = Product.new(
      :title => 'My Book Title',
      :description => 'yyy',
      :image_url => 'zzz.jpg'
      ) # setting all attributes but price
    
    # test 1
    product.price = -1
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01",
      product.errors[:price].join('; ')
    
    # test 2
    product.price = 0
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01",
      product.errors[:price].join('; ')
    
    # test 3
    product.price = 1
    assert product.valid?  
  end


  # this method is for the test "image_url"
  def new_product(image_url)
    Product.new(
      :title => 'My book title',
      :description => 'yyy',
      :price => 1,
      :image_url => image_url
      )
  end

  test "image_url" do

    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }

    ok.each do |name|
      assert new_product(name).valid?, "#{name} shouldn't be invalid" 
    end

    bad.each do |name|
      assert new_product(name).invalid?, "#{name} shouldn't be valid"
    end
  end

  test "title length must be at least ten chars long" do
    product = Product.new(
      :description => 'yyy',
      :price => 1.00,
      :image_url => 'zzz.jpg' 
      )

    product.title = 'Title'
    assert product.invalid?

    product.title = 'This is a longer title'
    assert product.valid?
  end

end
