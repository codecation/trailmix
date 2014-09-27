require "rails_helper"

describe  OhlifeExportParser do
  describe "#parse" do
    it "parses an entry" do
      string = "2014-02-30\n\nHey\n\nEnd of entry"

      result = parse(string)

      expect(result).to eq(
        {
          body: "Hey\n\nEnd of entry",
          year: "2014",
          month: "02",
          day: "30"
        }
      )
    end
  end

  def parse(string)
    OhlifeExportParser.new.parse(string)
  rescue Parslet::ParseFailed => failure
    puts failure.cause.ascii_tree
    raise
  end
end
