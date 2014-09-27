require "rails_helper"

describe OhlifeImporter do
  describe "#run" do
    it "creates entries for each entry in the file" do
      import = create_import
      user = import.user

      OhlifeImporter.new(user, import).run

      first_entry = user.entries.first
      expect(first_entry.body).to(
        eq("Older entry line one.\r\n\r\nOlder entry line two.")
      )
      expect(first_entry.created_at).to eq(Date.new(2014, 1, 28))

      second_entry = user.entries.second
      expect(second_entry.body).to(
        eq("List of items:\r\n\r\n* Item 1\r\n* Item 2\r\n")
      )
      expect(second_entry.created_at).to eq(Date.new(2014, 1, 29))
    end

    it "associates the created entries with an import" do
      import = create_import
      user = import.user

      OhlifeImporter.new(user, import).run

      expect(import.reload.entries.count).to eq(2)
    end
  end

  def create_import
    create(:import, ohlife_export: File.new(ohlife_export))
  end

  def ohlife_export
    Rails.root + "spec/fixtures/ohlife_export.txt"
  end
end
