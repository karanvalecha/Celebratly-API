class OccurrencesController < ApplicationController
  before_action :set_occurrence, only: %i[ show update destroy ]

  # GET /occurrences
  # GET /occurrences.json
  def index
    @occurrences = Occurrence.all
  end

  # GET /occurrences/1
  # GET /occurrences/1.json
  def show
  end

  # POST /occurrences
  # POST /occurrences.json
  def create
    @occurrence = Occurrence.new(occurrence_params)

    if @occurrence.save
      render :show, status: :created, location: @occurrence
    else
      render json: @occurrence.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /occurrences/1
  # PATCH/PUT /occurrences/1.json
  def update
    if @occurrence.update(occurrence_params)
      render :show, status: :ok, location: @occurrence
    else
      render json: @occurrence.errors, status: :unprocessable_entity
    end
  end

  # DELETE /occurrences/1
  # DELETE /occurrences/1.json
  def destroy
    @occurrence.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_occurrence
      @occurrence = Occurrence.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def occurrence_params
      params.fetch(:occurrence, {})
    end
end
