require "spec_helper"

describe PhotoUploader do
  it "accepts JPEG photos" do
    entry = build(:entry, :with_photo)

    expect(entry).to be_valid
  end

  it "rejects an SVG disguised with an image extension" do
    svg = Tempfile.new(["evil", ".png"])
    svg.write(%(<svg xmlns="http://www.w3.org/2000/svg"><image href="x"/></svg>))
    svg.rewind

    entry = build(:entry, photo: Rack::Test::UploadedFile.new(svg.path, "image/png"))

    expect(entry).not_to be_valid
    expect(entry.errors[:photo]).to be_present
  ensure
    svg&.close!
  end
end
