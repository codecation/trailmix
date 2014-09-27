require "rails_helper"

describe  OhlifeExportParser do
  describe "#parse" do
    it "parses entries" do
      export = ohlife_export

      result = parse(export)
      result = stringify_keys(result)

      expect(result).to eq(
        [
          {
            body: "Older entry line one.\r\n\r\nOlder entry line two.",
            date: "2014-01-28"
          },
          {
            body: "List of items:\r\n\r\n* Item 1\r\n* Item 2\r\n",
            date: "2014-01-29"
          }
        ]
      )
    end
  end

  def parse(export)
    OhlifeExportParser.new.parse(export)
  rescue Parslet::ParseFailed => failure
    puts failure.cause.ascii_tree
    raise
  end

  def stringify_keys(hash)
    hash.map { |hsh| hsh.inject({}) { |h, (k, v)| h[k] = v.to_s ; h } }
  end

  def ohlife_export
    IO.read(Rails.root.join("spec/fixtures/ohlife_export.txt"))
  end
end
