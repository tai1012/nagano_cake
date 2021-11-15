class Customers::HomesController < ApplicationController
  def top
    @items = Item.all.order(id: "DESC").first(4)
  end

  def about
  end

end
