require "rails_helper"

describe Api::ProjectsController do
  let(:user) { create(:user) }

  before do
    sign_in(user)
  end

  describe "GET #index" do
    let(:projects) { create_list(:project, 5, user: user) }

    before(:each) do
      get :index, format: :json
    end

    it "should return projects array" do
      expect(assigns(:projects)).to eq(projects)
    end
    it { should render_template('index') }
    it { should respond_with(200) }
  end

  describe "POST #create" do
    let(:project_attrs) { attributes_for(:project) }

    it "should create project" do
      expect{ post :create, project: project_attrs }
      .to change(Project, :count).by(1)
    end

    it "should return created project" do
      post :create, project: project_attrs
      json = JSON.parse(response.body)
      expect(json["name"]).to eq(project_attrs[:name])
    end

    it "should respond with status 200 on valid request" do
      post :create, project: project_attrs
      expect(response.status).to eq(200)
    end

    it "should respond with status 400 on invalid request" do
      post :create, project: nil
      expect(response.status).to eq(400)

      post :create, project: project_attrs[:name] = nil
      expect(response.status).to eq(400)

      post :create, project: project_attrs[:user_id] = nil
      expect(response.status).to eq(400)
    end

  end

  describe "DELETE #destroy" do
    let!(:project) { create(:project, user: user) }

    it "should delete project" do
      expect{ delete :destroy, id: project.id }
      .to change(Project, :count).by(-1)
    end

    it "should respond with status 200 on valid request" do
      delete :destroy, id: project.id
      expect(response.status).to eq(200)
    end

    it "should respond with status 400 on invalid request" do
      delete :destroy, id: -1
      expect(response.status).to eq(400)
    end

  end

  describe "UPDATE #put" do
    let(:project)     { create(:project, user: user) }
    let(:new_attribs) { { name: 'updated name' } }

    before(:each) do
      put :update, id: project.id, project: new_attribs
    end

    it "should update project" do
      project.reload
      expect(project[:name]).to eq(new_attribs[:name])
    end

    it "should respond with status 200 on valid request" do
      expect(response.status).to eq(200)
    end

    it "should respond with status 400 on invalid request" do
      put :update, id: project.id, project: nil
      expect(response.status).to eq(400)
    end

  end
end