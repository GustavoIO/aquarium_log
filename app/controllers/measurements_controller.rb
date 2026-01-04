class MeasurementsController < ApplicationController
  before_action :set_aquarium
  before_action :set_measurement, only: [:edit, :update, :destroy]
  before_action :combine_datetime, only: [:create, :update]

  def new
    @measurement = @aquarium.measurements.build(measured_at: Time.current)
  end

  def create
    @measurement = @aquarium.measurements.build(measurement_params)
    if @measurement.save
      redirect_to @aquarium, notice: "Measurement was successfully added."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @measurement.photo.purge if params[:measurement][:remove_photo] == "1"
    if @measurement.update(measurement_params)
      redirect_to @aquarium, notice: "Measurement was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @measurement.destroy
    redirect_to @aquarium, notice: "Measurement was successfully deleted."
  end

  private

  def set_aquarium
    @aquarium = Aquarium.find(params[:aquarium_id])
  end

  def set_measurement
    @measurement = @aquarium.measurements.find(params[:id])
  end

  def combine_datetime
    date = params[:measurement][:measured_at]
    time = params[:measured_at_time]
    if date.present? && time.present?
      params[:measurement][:measured_at] = "#{date} #{time}"
    end
  end

  def measurement_params
    params.require(:measurement).permit(:ph, :kh, :gh, :nitrates, :phosphates, :measured_at, :photo)
  end
end
