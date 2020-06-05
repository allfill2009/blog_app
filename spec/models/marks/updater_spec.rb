describe Marks::Updater do
  subject { Marks::Updater }

  let(:user) { create(:user, login: "Login_0") }
  let(:post) { create(:post, user_id: user.id) }

  it "updates marks twice" do
    subject.new(post_id: post.id, mark: 5.0).update
    subject.new(post_id: post.id, mark: 4.0).update
    new_post = post.reload
    expect(new_post.marks_count).to eq 2
    expect(new_post.marks_sum).to eq 9
    expect(new_post.average_mark).to eq 4.5
  end
end
