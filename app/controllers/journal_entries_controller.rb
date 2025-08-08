# app/controllers/journal_entries_controller.rb
class JournalEntriesController < ApplicationController
  before_action :authenticate_user!
  
  # GET /journal_entries or /journal_entries.json
  def index
    @journal_entries = policy_scope(JournalEntry)
  end

  # GET /journal_entries/1 or /journal_entries/1.json
  def show
    @journal_entry = JournalEntry.find(params[:id])
    authorize @journal_entry
  end

  # GET /journal_entries/new
  def new
    @journal_entry = current_user.journal_entries.build
  end

  # GET /journal_entries/1/edit
  def edit
    @journal_entry = JournalEntry.find(params[:id])
    authorize @journal_entry
  end

  # POST /journal_entries or /journal_entries.json
  def create
    @journal_entry = current_user.journal_entries.build(journal_entry_params)
    
    if @journal_entry.save
      redirect_to journal_entry_url(@journal_entry), notice: "Journal entry was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /journal_entries/1 or /journal_entries/1.json
  def update
    @journal_entry = JournalEntry.find(params[:id])
    authorize @journal_entry
    
    if @journal_entry.update(journal_entry_params)
      redirect_to journal_entry_url(@journal_entry), notice: "Journal entry was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /journal_entries/1 or /journal_entries/1.json
  def destroy
    @journal_entry = JournalEntry.find(params[:id])
    authorize @journal_entry
    
    @journal_entry.destroy!
    redirect_to journal_entries_url, notice: "Journal entry was successfully destroyed."
  end

  private

    def journal_entry_params
      params.require(:journal_entry).permit(:title, :content)
    end
end
