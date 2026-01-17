namespace :dev do
  desc "Add sample photos to some entries"
  task add_photos: :environment do
    require "open-uri"
    require "tempfile"

    user = User.find_by(email: "user@example.com")
    unless user
      puts "No test user found. Run `rake dev:prime` first."
      exit 1
    end

    entries = user.entries.order(date: :desc).limit(20)
    if entries.empty?
      puts "No entries found for test user."
      exit 1
    end

    # Add photos to ~10 random entries
    entries_to_update = entries.sample(10)

    entries_to_update.each_with_index do |entry, index|
      # Use picsum.photos for random images
      image_url = "https://picsum.photos/800/600?random=#{index}"

      begin
        puts "Adding photo to entry from #{entry.date}..."

        tempfile = Tempfile.new(["sample", ".jpg"])
        tempfile.binmode

        URI.open(image_url) do |image|
          tempfile.write(image.read)
        end

        tempfile.rewind
        entry.photo = tempfile
        entry.save!

        tempfile.close
        tempfile.unlink

        puts "  ✓ Added photo"
      rescue => e
        puts "  ✗ Failed: #{e.message}"
      end
    end

    puts "\nDone! Added photos to #{entries_to_update.size} entries."
  end
end
