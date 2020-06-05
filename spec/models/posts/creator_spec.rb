describe Posts::Creator do
  subject { Posts::Creator.new(data) }

  let(:data) do
    {
      login: "Login_0",
      header: "Header_0",
      content: "Content_0",
      ip: "127.0.0.1"
    }
  end

  let(:create_user) { create(:user, login: data[:login]) }

  it "creates post only" do
    create_user

    subject.create

    expect(User.where(login: data[:login]).count).to eq 1
    expect(IpLogin.where(ip: data[:ip]).count).to eq 1
    expect(Post.where(header: data[:header], content: data[:content]).count).to eq 1
  end

  it "creates post and user" do
    subject.create

    expect(User.where(login: data[:login]).count).to eq 1
    expect(IpLogin.where(ip: data[:ip]).count).to eq 1
    expect(Post.where(header: data[:header], content: data[:content]).count).to eq 1
  end

end
