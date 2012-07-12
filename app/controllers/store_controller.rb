class StoreController < ApplicationController
  def index
    # getting all records from the table
    @products = Product.all
    
  end

end
