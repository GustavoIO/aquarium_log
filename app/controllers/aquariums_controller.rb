class AquariumsController < ApplicationController
  before_action :set_aquarium, only: [:show, :edit, :update, :destroy, :chart_data]

  def index
    @aquariums = Aquarium.order(:name).includes(measurements: { photo_attachment: :blob })
  end

  def show
    set_current_aquarium(@aquarium)
    @measurements = @aquarium.measurements.limit(50)
  end

  def new
    @aquarium = Aquarium.new
  end

  def create
    @aquarium = Aquarium.new(aquarium_params)
    if @aquarium.save
      set_current_aquarium(@aquarium)
      redirect_to @aquarium, notice: "Aquarium was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @aquarium.update(aquarium_params)
      redirect_to @aquarium, notice: "Aquarium was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @aquarium.destroy
    session[:current_aquarium_id] = nil if session[:current_aquarium_id] == @aquarium.id
    redirect_to root_path, notice: "Aquarium was successfully deleted."
  end

  def chart_data
    param = params[:param] || "ph"
    allowed_params = %w[ph kh gh nitrates phosphates]
    param = "ph" unless allowed_params.include?(param)

    measurements = @aquarium.measurements.reorder(measured_at: :asc).pluck(:measured_at, param.to_sym)

    render json: {
      labels: measurements.map { |m| m[0].strftime("%Y-%m-%d %H:%M") },
      values: measurements.map { |m| m[1]&.to_f },
      param: param
    }
  end

  private

  def set_aquarium
    @aquarium = Aquarium.find(params[:id])
  end

  def aquarium_params
    params.require(:aquarium).permit(:name, :description)
  end
end
