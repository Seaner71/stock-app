class StocksController < ApplicationController
  before_action :set_stock, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /stocks
  # GET /stocks.json
  def index
    @stocks = current_user.stocks
  end

  # GET /stocks/1
  # GET /stocks/1.json
  def show
    @stock = Stock.find_by_id(params[:id])
    # get_stock_history

  end

  # GET /stocks/new
  def new
    @stock = Stock.new
  end

  # GET /stocks/1/edit
  def edit
  end

  # POST /stocks
  # POST /stocks.json
  def create
    @stock = Stock.new(stock_params)
    @stock.user_id = current_user.id
    @stock.sname = StockQuote::Stock.quote(params['stock'][:ticker]).sname
    @stock.name = StockQuote::Stock.quote(params['stock'][:ticker]).name
    respond_to do |format|
      if @stock.save
        format.html { redirect_to @stock, notice: 'Stock was successfully created.' }
        format.json { render :show, status: :created, location: @stock }
      else
        format.html { render :new }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stocks/1
  # PATCH/PUT /stocks/1.json
  def update
    respond_to do |format|
      if @stock.update(stock_params)
        format.html { redirect_to @stock, notice: 'Stock was successfully updated.' }
        format.json { render :show, status: :ok, location: @stock }
      else
        format.html { render :edit }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stocks/1
  # DELETE /stocks/1.json
  def destroy
    @stock.destroy
    respond_to do |format|
      format.html { redirect_to stocks_url, notice: 'Stock was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def createDate
    set_stock
    @start_date = params['start']
    @end_date = params['end']
    @stock_history = StockQuote::Stock.history(@stock.ticker,   @start_date,  @end_date)
    @stock_price_hash = {}
    @stock_history[:history].each do |day|
    @stock_price_hash[day[:date]] = day[:close]
    end
    render 'show'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock
      @stock = Stock.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stock_params
      params.require(:stock).permit(:ticker, :user_id, :shares, :sname, :name)
    end
    def correct_user
      @ticker = current_user.stocks.find_by(id: params[:id])
      redirect_to stocks_path, notice: "Not authorized to edit this stock" if @ticker.nil?
    end
    # def get_stock_history
    #  @stock_history = StockQuote::Stock.history(@stock.ticker, "07/15/2016", Time.now.strftime("%d/%m/%Y"))
    #     @stock_price_hash = {}
    #     @stock_history[:history].each do |day|
    #       @stock_price_hash[day[:date]] = day[:close]
    #     end
    # end
end
