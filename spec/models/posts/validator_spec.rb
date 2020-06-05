describe Posts::Validator do
  subject { Posts::Validator.new(data) }

  describe "empty and blank data" do
    let(:expected) do
      [
        "Login Post.Login is blank",
        "Header Post.Header is blank",
        "Content Post.Content is blank",
        "Ip Post.IP is blank"
      ]
    end

    describe "empty data" do
      let(:data) do
        {}
      end

      it "shows all errors for empty data" do
        subject.valid?
        expect(subject.errors.full_messages).to eq expected
      end
    end

    describe "blank data" do
      let(:data) do
        { login: "", header: "", content: "", ip: "" }
      end

      it "shows all errors for blank data" do
        subject.valid?
        expect(subject.errors.full_messages).to eq expected
      end
    end
  end

  describe "full data" do
    let(:data) do
      { login: "login", header: "header", content: "content", ip: "127.0.0.1" }
    end

    it "shows no errors" do
      subject.valid?
      expect(subject.errors).to be_empty
    end
  end
end
