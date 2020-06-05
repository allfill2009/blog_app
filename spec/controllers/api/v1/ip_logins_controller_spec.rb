describe Api::V1::IpLoginsController, type: :controller do
  let(:ip_1) { "127.0.0.1" }
  let(:ip_2) { "127.0.0.2" }
  let(:login_1) { "Login_1" }
  let(:login_2) { "Login_2" }
  let(:user_1) { create(:user, login: login_1) }
  let(:user_2) { create(:user, login: login_2) }

  context "One IP but two users" do
    let!(:ip_login_1) { create(:ip_login, ip: ip_1, login: login_1, user_id: user_1.id) }
    let!(:ip_login_2) { create(:ip_login, ip: ip_1, login: login_2, user_id: user_2.id) }

    it "returns one record" do
      get :index, params: { logins: [login_1, login_2] }

      expect(response).to have_http_status(:ok)

      items = JSON.parse(response.body)
      expect(items.size).to eq(1)

      item = items.first
      puts item
      expect(item["ip"]).to eq ip_1
      expect(item["logins"]).to include(user_1.login)
      expect(item["logins"]).to include(user_2.login)
    end
  end

  context "Two logins with different IP" do
    let!(:ip_login_1) { create(:ip_login, ip: ip_1, login: login_1, user_id: user_1.id) }
    let!(:ip_login_2) { create(:ip_login, ip: ip_2, login: login_2, user_id: user_2.id) }

    it "returns two items" do
      get :index, params: { logins: [user_1.login, user_2.login] }

      expect(response).to have_http_status(:ok)

      items = JSON.parse(response.body)
      expect(items.size).to eq(2)

      expect(items.first["ip"]).to eq(ip_1)
      expect(items.first["logins"]).to include(user_1.login)
      expect(items.last["ip"]).to eq(ip_2)
      expect(items.last["logins"]).to include(user_2.login)
    end
  end
end
