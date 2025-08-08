# app/controllers/journal_entries_controller.rb
class JournalEntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_journal_entry, only: %i[ show edit update destroy ]

  # GET /journal_entries or /journal_entries.json
  def index
    @journal_entries = current_user.journal_entries
  end

  # GET /journal_entries/1 or /journal_entries/1.json
  def show
  end

  # GET /journal_entries/new
  def new
    @journal_entry = current_user.journal_entries.build
  end

  # GET /journal_entries/1/edit
  def edit
  end

  # POST /journal_entries or /journal_entries.json
  def create
    @journal_entry = current_user.journal_entries.build(journal_entry_params)

    respond_to do |format|
      if @journal_entry.save
        format.html { redirect_to journal_entry_url(@journal_entry), notice: "Journal entry was successfully created." }
        format.json { render :show, status: :created, location: @journal_entry }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @journal_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /journal_entries/1 or /journal_entries/1.json
  def update
    respond_to do |format|
      if @journal_entry.update(journal_entry_params)
        format.html { redirect_to journal_entry_url(@journal_entry), notice: "Journal entry was successfully updated." }
        format.json { render :show, status: :ok, location: @journal_entry }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @journal_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /journal_entries/1 or /journal_entries/1.json
  def destroy
    @journal_entry.destroy!

    respond_to do |format|
      format.html { redirect_to journal_entries_url, notice: "Journal entry was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_journal_entry
      @journal_entry = current_user.journal_entries.find(params[:id])
    end

    def journal_entry_params
      params.require(:journal_entry).permit(:title, :content)
    end
end
