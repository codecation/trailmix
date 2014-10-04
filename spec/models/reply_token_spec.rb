describe ReplyToken do
  describe ".included" do
    it "registers #generate_reply_token as a callback" do
      expect(TestClass.callbacks).to include :generate_reply_token
    end
  end

  describe "#generate_reply_token" do
    it "generates a unique token" do
      klass = TestClass.new

      first_token  = klass.generate_reply_token
      second_token = klass.generate_reply_token

      expect(first_token).to_not eq second_token
    end

    it "includes the email username at the beginning of the token" do
      klass = TestClass.new(email: "username@example.com")

      token = klass.generate_reply_token

      expect(token).to start_with "username"
    end

    context "when a duplicate token exists" do
      it "generates a new one" do
        klass = TestClass.new
        expect(klass).to(receive(:token_exists?))
                     .and_return(true, false)
        expect(klass).to(receive(:new_reply_token))
                     .and_return("first_token", "second_token")

        token = klass.generate_reply_token

        expect(token).to eq "second_token"
      end
    end

    context "when reply_token has not be set" do
      it "assigns the token to reply_token" do
        klass = TestClass.new

        token = klass.generate_reply_token

        expect(klass.reply_token).to eq token
      end
    end

    context "when reply_token has already been set" do
      it "does not change reply_token" do
        klass = TestClass.new(reply_token: "abc123")

        klass.generate_reply_token

        expect(klass.reply_token).to eq "abc123"
      end
    end

  end

  class TestClass < OpenStruct
    @callbacks = []

    def self.callbacks; @callbacks end
    def self.before_create(method); @callbacks << method; end

    def token_exists?(_); false; end
    def email; super || "user@example.com"; end

    include ReplyToken
  end
end
