class AddBodyToJournalEntries < ActiveRecord::Migration[8.0]
  def change
    add_column :journal_entries, :body, :text
  end
end
