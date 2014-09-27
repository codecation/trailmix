require "rails_helper"

describe OhlifeImportWorker do
  describe "#perform" do
    it "calls run on the importer " do
      user = create(:user)
      import = create(:import)
      importer = double("importer", run: nil)
      allow(OhlifeImporter).to(
        receive(:new).with(user, import).and_return(importer)
      )

      OhlifeImportWorker.new.perform(user.id, import.id)

      expect(importer).to(have_received(:run))
    end
  end
end
