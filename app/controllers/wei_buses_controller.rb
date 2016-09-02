class WeiBusesController < ApplicationController
  before_action :set_wei_bus, only: [:show, :edit, :update, :destroy]

  # GET /wei_buses
  # GET /wei_buses.json
  def index
    @wei_buses = WeiBus.all
  end

  # GET /wei_buses/1
  # GET /wei_buses/1.json
  def show
  end

  # GET /wei_buses/new
  def new
    @wei_bus = WeiBus.new
  end

  # GET /wei_buses/1/edit
  def edit
  end

  # POST /wei_buses
  # POST /wei_buses.json
  def create
    @wei_bus = WeiBus.new(wei_bus_params)

    respond_to do |format|
      if @wei_bus.save
        format.html { redirect_to @wei_bus, notice: 'Wei bus was successfully created.' }
        format.json { render :show, status: :created, location: @wei_bus }
      else
        format.html { render :new }
        format.json { render json: @wei_bus.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wei_buses/1
  # PATCH/PUT /wei_buses/1.json
  def update
    respond_to do |format|
      if @wei_bus.update(wei_bus_params)
        format.html { redirect_to @wei_bus, notice: 'Wei bus was successfully updated.' }
        format.json { render :show, status: :ok, location: @wei_bus }
      else
        format.html { render :edit }
        format.json { render json: @wei_bus.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wei_buses/1
  # DELETE /wei_buses/1.json
  def destroy
    @wei_bus.destroy
    respond_to do |format|
      format.html { redirect_to wei_buses_url, notice: 'Wei bus was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wei_bus
      @wei_bus = WeiBus.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wei_bus_params
      params.require(:wei_bus).permit(:name, :seats)
    end
end
