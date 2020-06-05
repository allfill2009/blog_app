describe TopMarks::Finder do
  subject { TopMarks::Finder }

  it "finds top n marks" do
    user = create(:user, login: "Login")
    create(:post, user_id: user.id, average_mark: 3.0)
    user_2 = create(:user, login: "Login_2")
    post_2 = create(:post, user_id: user_2.id, average_mark: 5.0, header: "Header", content: "Content")

    posts = subject.new(1).find
    expect(posts.size).to eq(1)
    expect(posts.first.values).to eq([post_2.header, post_2.content])
  end
end
