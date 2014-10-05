require "rails_helper"

describe AdminDashboard do
  describe ".users_by_day_since" do
    it "returns the count of users created, grouped by day" do
      Timecop.freeze(2014, 01, 30) do
        cutoff = 15.days.ago
        outside_range = create(:user, created_at: (cutoff - 1.day))
        within_range = create(:user, created_at: Date.yesterday)

        result = AdminDashboard.new.users_by_day_since(cutoff)

        expected = { Time.zone.parse("2014-01-29") => 1 }
        expect(result).to eq(expected)
      end
    end
  end

  describe ".entries_by_day_since" do
    it "returns the count of entries created, grouped by day" do
      Timecop.freeze(2014, 01, 30) do
        cutoff = 15.days.ago
        outside_range = create(:entry, date: (cutoff - 1.day))
        within_range = create(:entry, date: Date.yesterday)

        result = AdminDashboard.new.entries_by_day_since(cutoff)

        expected = { Time.zone.parse("2014-01-29") => 1 }
        expect(result).to eq(expected)
      end
    end
  end

  describe ".users_created_since" do
    it "returns users created after a given date" do
      Timecop.freeze(2014, 01, 30) do
        cutoff = 15.days.ago
        outside_range = create(:user, created_at: (cutoff - 1.day))
        within_range = create(:user, created_at: Date.yesterday)

        result = AdminDashboard.new.users_created_since(cutoff)

        expect(result).to eq([within_range])
      end
    end
  end

  describe "#trial_status_for" do
    context "when the user writes every day" do
      it "returns 'great'" do
        daily_writer = build_stubbed(:user, created_at: 3.days.ago)
        3.times { create(:entry, user: daily_writer) }

        result = AdminDashboard.new.trial_status_for(daily_writer)

        expect(result).to eq "great"
      end
    end

    context "when the user writes half the time" do
      it "returns 'warning'" do
        frequent_writer = build_stubbed(:user, created_at: 2.days.ago)
        create(:entry, user: frequent_writer)

        result = AdminDashboard.new.trial_status_for(frequent_writer)

        expect(result).to eq "warning"
      end
    end

    context "when the user writes a third of the time" do
      it "returns 'danger'" do
        occasional_writer = build_stubbed(:user, created_at: 3.days.ago)
        create(:entry, user: occasional_writer)

        result = AdminDashboard.new.trial_status_for(occasional_writer)

        expect(result).to eq "danger"
      end
    end
  end

  describe "#entries_per_day_for" do
    context "when the user writes every day" do
      it "returns 1" do
        daily_writer = build_stubbed(:user, created_at: 3.days.ago)
        3.times { create(:entry, user: daily_writer) }

        result = AdminDashboard.new.entries_per_day_for(daily_writer)

        expect(result).to eq 1
      end
    end

    context "when the user writes a third of the time" do
      it "returns 0.3" do
        occasional_writer = build_stubbed(:user, created_at: 3.days.ago)
        create(:entry, user: occasional_writer)

        result = AdminDashboard.new.entries_per_day_for(occasional_writer)

        expect(result).to eq 0.3
      end
    end
  end
end
