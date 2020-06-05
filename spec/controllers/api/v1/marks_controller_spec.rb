describe Api::V1::MarksController, type: :controller do
  let(:user) { create(:user, login: "Login_0") }
  let(:post) { create(:post, user_id: user.id) }

  it "fails if no post" do
    put :update, params: { id: -1, mark: 1 }

    expect(response).to have_http_status(422)
  end

  it "updates mark when value is blank" do
    put :update, params: { id: post.id }

    new_post = post.reload
    expect(new_post.average_mark).to eq 1.0

    expect(response).to have_http_status(200)
    expect(response.body).to include("1.0")
  end

  it "updates mark when value is empty" do
    put :update, params: { id: post.id, mark: "" }

    new_post = post.reload
    expect(new_post.average_mark).to eq 1.0

    expect(response).to have_http_status(200)
    expect(response.body).to include("1.0")
  end

  it "updates mark when value is 0" do
    put :update, params: { id: post.id, mark: 0 }

    new_post = post.reload
    expect(new_post.average_mark).to eq 1.0

    expect(response).to have_http_status(200)
    expect(response.body).to include("1.0")
  end

  it "updates mark when value is 1" do
    put :update, params: { id: post.id, mark: 1 }

    new_post = post.reload
    expect(new_post.average_mark).to eq 1.0

    expect(response).to have_http_status(200)
    expect(response.body).to include("1.0")
  end

  it "updates mark when value is 5" do
    put :update, params: { id: post.id, mark: 5 }

    new_post = post.reload
    expect(new_post.average_mark).to eq 5.0

    expect(response).to have_http_status(200)
    expect(response.body).to include("5.0")
  end

  it "updates mark when value is 10" do
    put :update, params: { id: post.id, mark: 10 }

    new_post = post.reload
    expect(new_post.average_mark).to eq 5.0

    expect(response).to have_http_status(200)
    expect(response.body).to include("5.0")
  end
end
