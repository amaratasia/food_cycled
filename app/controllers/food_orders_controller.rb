class FoodOrdersController < ApplicationController
  before_action :set_food_order, only: [:show, :edit, :update, :destroy]
before_action :authenticate_user!
  # GET /food_orders
  # GET /food_orders.json
  def index
    @food_orders = FoodOrder.all
    # current_user ||= User.first
    @food_orders = @food_orders.where(user_id: current_user.id) if current_user.user?
    @food_orders = @food_orders.where(status: nil) if current_user.volunteer?
    return render json: {data: @food_orders.as_json}, status: 200
  end

  # GET /food_orders/1
  # GET /food_orders/1.json
  def history
    food_orders = FoodOrder.where(picked_by: current_user.id)
    return render json: {data: food_orders.as_json}, status: 200
  end

  def update_status
    food_order = FoodOrder.find(params[:id])
    food_order.update_attributes({status:5, picked_by: current_user.id})
    return render json: {data: food_order.as_json}, status: 200
  end

  # GET /food_orders/new
  def new
    @food_order = FoodOrder.new
  end

  # GET /food_orders/1/edit
  def edit
  end

  # POST /food_orders
  # POST /food_orders.json
  def create
    @food_order = FoodOrder.new(food_order_params)
    if @food_order.save
      return render json: {data: @food_order.as_json}, status: 200
    else
      return render json: @food_order.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /food_orders/1
  # PATCH/PUT /food_orders/1.json
  def update
    respond_to do |format|
      if @food_order.update(food_order_params)
        format.html { redirect_to @food_order, notice: 'Food order was successfully updated.' }
        format.json { render :show, status: :ok, location: @food_order }
      else
        format.html { render :edit }
        format.json { render json: @food_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /food_orders/1
  # DELETE /food_orders/1.json
  def destroy
    @food_order.destroy
    respond_to do |format|
      format.html { redirect_to food_orders_url, notice: 'Food order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_food_order
      @food_order = FoodOrder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def food_order_params
      params[:food_order][:user_id] = current_user.try(:id) || 1
      params.require(:food_order).permit(:user_id, :food_name, :status, :picked_by, :image_url, :prep_date, :expiry_date, :spice_value)
    end
end
