describe Api::V1::PostsController, type: :controller do
  let(:data) do
    {
      login: "Login_0",
      header: "Header_0",
      content: "Content_0",
      ip: "127.0.0.1",
    }
  end

  it "creates post and user" do
    post(:create, params: data)

    expect(User.where(login: data[:login]).count).to eq 1
    expect(IpLogin.where(ip: data[:ip]).count).to eq 1
    expect(Post.where(header: data[:header], content: data[:content]).count).to eq 1

    expect(response).to have_http_status(:ok)
    body = JSON.parse(response.body)
    post = Post.last
    expect([post.header, post.content]).to eq [body["header"], body["content"]]
  end

  it "creates post only" do
    create(:user, login: data[:login])

    post(:create, params: data)

    expect(User.where(login: data[:login]).count).to eq 1
    expect(IpLogin.where(ip: data[:ip]).count).to eq 1
    expect(Post.where(header: data[:header], content: data[:content]).count).to eq 1

    expect(response).to have_http_status(:ok)
    body = JSON.parse(response.body)
    post = Post.last
    expect([post.header, post.content]).to eq [body["header"], body["content"]]
  end

end
