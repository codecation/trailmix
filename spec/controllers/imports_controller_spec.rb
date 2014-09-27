require "rails_helper"

describe ImportsController do
  describe "#create" do
    context "when the import fails to save" do
      it "apologizes to the user" do
        stub_current_user
        import = double("import", save: false)
        allow(Import).to(receive(:new).and_return(import))

        post :create, import: { ohlife_export: double("export") }

        expect(flash[:error]).to include "Sorry"
      end
    end

  end

  def stub_current_user
    allow(controller).to(receive(:current_user))
  end
end
