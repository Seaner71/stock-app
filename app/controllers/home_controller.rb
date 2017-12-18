class HomeController < ApplicationController
  def index
    if params[:id] == ''
      @nothing = "Hey, you forgot to enter a symbol"
    elsif
      if params[:id]
        @stock = StockQuote::Stock.quote(params[:id])
      end
    end
    verify_stock
  end

  def about
  end
  def verify_stock
    if @stock == nil
      @error = 'That is not a valid stock symbol'
    end
  end
end
