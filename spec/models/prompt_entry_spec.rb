describe PromptEntry do
  describe "#best" do
    context "when there's an entry from one year ago" do
      it "returns that entry" do
        Timecop.freeze(2014, 1, 2, 20) do # 8PM UTC
          user = create(:user, time_zone: "Guam") # UTC+10
          one_year_ago = Date.new(2013, 1, 3)
          one_year_entry = create(:entry, user: user, date: one_year_ago)
          create(:entry, user: user, date: 1.week.ago)

          best = PromptEntry.new(user.entries, user.time_zone).best

          expect(best).to eq(one_year_entry)
        end
      end
    end

    context "when there's an entry from one month ago" do
      it "returns that entry" do
        Timecop.freeze(2014, 1, 2, 20) do # 8PM UTC
          user = create(:user, time_zone: "Guam") # UTC+10
          one_month_ago = Date.new(2013, 12, 3)
          create(:entry, user: user, date: 1.week.ago)
          one_month_entry = create(:entry, user: user, date: one_month_ago)

          best = PromptEntry.new(user.entries, user.time_zone).best

          expect(best).to eq(one_month_entry)
        end
      end
    end

    context "when there's an entry from one week ago" do
      it "returns that entry" do
        Timecop.freeze(2014, 1, 2, 20) do # 8PM UTC
          user = create(:user, time_zone: "Guam") # UTC+10
          one_week_ago = Date.new(2013, 12, 27)
          create(:entry, user: user, date: 2.years.ago)
          one_week_entry = create(:entry, user: user, date: one_week_ago)

          best = PromptEntry.new(user.entries, user.time_zone).best

          expect(best).to eq(one_week_entry)
        end
      end
    end

    context "when there are no interesting entries" do
      it "returns a random entry" do
        user = create(:user)
        random_entry = double(:entry)
        allow(user.entries).to(receive(:random).and_return(random_entry))

        best = PromptEntry.new(user.entries, user.time_zone).best

        expect(best).to eq(random_entry)
      end
    end
  end
end
