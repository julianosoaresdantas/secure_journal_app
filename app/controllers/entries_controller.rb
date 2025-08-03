# app/controllers/entries_controller.rb
class EntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_entry, only: %i[ show edit update destroy ]

  # GET /entries or /entries.json
  def index
    # Filter entries by the current user
    @entries = current_user.entries.order(created_at: :desc) # Order by creation date, newest first

    # Add search functionality
    if params[:query].present?
      # Search in title or content for the given query
      @entries = @entries.where("title ILIKE ? OR content ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
    end
  end

  # GET /entries/1 or /entries/1.json
  def show
  end

  # GET /entries/new
  def new
    @entry = current_user.entries.build
  end

  # GET /entries/1/edit
  def edit
  end

  # POST /entries or /entries.json
  def create
    @entry = current_user.entries.build(entry_params)

    respond_to do |format|
      if @entry.save
        format.html { redirect_to entry_url(@entry), notice: "Entry was successfully created." }
        format.json { render :show, status: :created, location: @entry }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entries/1 or /entries/1.json
  def update
    respond_to do |format|
      if @entry.update(entry_params)
        format.html { redirect_to entry_url(@entry), notice: "Entry was successfully updated." }
        format.json { render :show, status: :ok, location: @entry }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1 or /entries/1.json
  def destroy
    @entry.destroy!

    respond_to do |format|
      format.html { redirect_to entries_url, notice: "Entry was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      # Ensure users can only access their own entries
      @entry = current_user.entries.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to entries_path, alert: "Entry not found or you don't have permission to view it."
    end
private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      # Ensure users can only access their own entries
      @entry = current_user.entries.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to entries_path, alert: "Entry not found or you don't have permission to view it."
    end

    # Only allow a list of trusted parameters through.
    def entry_params
      params.require(:entry).permit(:title, :content, :image) # Add :image here
    end
end

