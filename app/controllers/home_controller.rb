class HomeController < ApplicationController
  def index
    if params[:id] == ''
      @nothing = "Hey, you forgot to enter a symbol"
    elsif
      if params[:id]
        @stock = StockQuote::Stock.quote(params[:id])
          if @stock == nil || @stock.name == nil
            @error = 'That is not a valid stock symbol'
          end
      end
    end
end

  def about
  end

end
