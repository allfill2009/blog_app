describe Api::V1::TopMarksController, type: :controller do
  before(:each) do
    user = create(:user, login: "Login_1")
    (1.0..5.0).step(0.4).each do |mark|
      create(:post, user_id: user.id, average_mark: mark)
    end
  end

  it "returns top 1 post by default" do
    get :index, params: {}

    expect(response).to have_http_status(200)
    expect(JSON.parse(response.body).size).to eq(1)
  end

  it "returns top 10 posts" do
    get :index, params: { top_n: 10 }

    expect(response).to have_http_status(200)
    expect(JSON.parse(response.body).size).to eq(10)
  end

end
