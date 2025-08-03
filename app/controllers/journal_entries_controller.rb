# app/controllers/journal_entries_controller.rb
class JournalEntriesController < ApplicationController
  # Ensure only authenticated users can access journal entries
  before_action :authenticate_user!
  before_action :set_journal_entry, only: %i[ show edit update destroy ]

  # GET /journal_entries
  def index
    # Only show journal entries belonging to the current user
    @journal_entries = current_user.journal_entries.order(created_at: :desc)
  end

  # GET /journal_entries/1
  def show
    # set_journal_entry already ensures it belongs to current_user
  end

  # GET /journal_entries/new
  def new
    @journal_entry = current_user.journal_entries.build # Build new entry for current user
  end

  # GET /journal_entries/1/edit
  def edit
    # set_journal_entry already ensures it belongs to current_user
  end

  # POST /journal_entries
  def create
    @journal_entry = current_user.journal_entries.build(journal_entry_params)

    if @journal_entry.save
      redirect_to @journal_entry, notice: "Journal entry was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /journal_entries/1
  def update
    if @journal_entry.update(journal_entry_params)
      redirect_to @journal_entry, notice: "Journal entry was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /journal_entries/1
  def destroy
    @journal_entry.destroy!
    redirect_to journal_entries_url, notice: "Journal entry was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_journal_entry
      # Find the journal entry, but only if it belongs to the current user
      @journal_entry = current_user.journal_entries.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to journal_entries_url, alert: "Journal entry not found or you don't have permission to view it."
    end

    # Only allow a list of trusted parameters through.
    def journal_entry_params
      params.require(:journal_entry).permit(:title, :content)
    end
end
