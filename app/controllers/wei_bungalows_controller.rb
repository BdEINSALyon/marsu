class WeiBungalowsController < ApplicationController
  before_action :set_wei_bungalow, only: [:show, :edit, :update, :destroy]

  # GET /wei_bungalows
  # GET /wei_bungalows.json
  def index
    @wei_bungalows = WeiBungalow.all
  end

  # GET /wei_bungalows/1
  # GET /wei_bungalows/1.json
  def show
  end

  # GET /wei_bungalows/new
  def new
    @wei_bungalow = WeiBungalow.new
  end

  # GET /wei_bungalows/1/edit
  def edit
  end

  # POST /wei_bungalows
  # POST /wei_bungalows.json
  def create
    @wei_bungalow = WeiBungalow.new(wei_bungalow_params)

    respond_to do |format|
      if @wei_bungalow.save
        format.html { redirect_to @wei_bungalow, notice: 'Wei bungalow was successfully created.' }
        format.json { render :show, status: :created, location: @wei_bungalow }
      else
        format.html { render :new }
        format.json { render json: @wei_bungalow.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wei_bungalows/1
  # PATCH/PUT /wei_bungalows/1.json
  def update
    respond_to do |format|
      if @wei_bungalow.update(wei_bungalow_params)
        format.html { redirect_to @wei_bungalow, notice: 'Wei bungalow was successfully updated.' }
        format.json { render :show, status: :ok, location: @wei_bungalow }
      else
        format.html { render :edit }
        format.json { render json: @wei_bungalow.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wei_bungalows/1
  # DELETE /wei_bungalows/1.json
  def destroy
    @wei_bungalow.destroy
    respond_to do |format|
      format.html { redirect_to wei_bungalows_url, notice: 'Wei bungalow was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wei_bungalow
      @wei_bungalow = WeiBungalow.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wei_bungalow_params
      params.require(:wei_bungalow).permit(:name, :seats, :gender, :wei_bus_id)
    end
end
