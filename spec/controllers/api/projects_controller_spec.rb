require "rails_helper"

describe Api::ProjectsController do
  before do
    @user = FactoryGirl.create(:user)
    sign_in(@user)
  end

  describe "GET #index" do
    before do
      @projects = FactoryGirl.create_list(:project, 5, user: @user)
      get :index, format: :json
    end

    it "should return projects array" do
      expect(assigns(:projects)).to eq(@projects)
    end
    it { should render_template('index') }
    it { should respond_with(200) }
  end

  describe "POST #create" do
    before do
      @project_attrs = FactoryGirl.attributes_for(:project, user: @user)
    end

    it "should create project" do
      expect{ post :create, project: @project_attrs }
      .to change(Project, :count).by(1)
    end

    it "should return created project" do
      post :create, project: @project_attrs
      json = JSON.parse(response.body)
      expect(json["name"]).to eq(@project_attrs[:name])
    end

    it "should respond with status 200 on valid request" do
      post :create, project: @project_attrs
      expect(response.status).to eq(200)
    end

    it "should respond with status 400 on invalid request"

  end

  describe "DELETE #destroy" do
    before do
      @project = FactoryGirl.create(:project, user: @user)
    end

    it "should delete project" do
      expect{ delete :destroy, id: @project.id }
      .to change(Project, :count).by(-1)
    end

    it "should respond with status 200 on valid request" do
      delete :destroy, id: @project.id
      expect(response.status).to eq(200)
    end

    it "should respond with status 400 on invalid request" do
      delete :destroy, id: -1
      expect(response.status).to eq(400)
    end

  end

  describe "UPDATE #put" do
    before(:each) do
      @project = FactoryGirl.create(:project, user: @user)
      @new_attribs = { name: 'updated name' }
      put :update, id: @project.id, project: @new_attribs
    end

    it "should update project" do
      @project.reload
      expect(@project[:name]).to eq(@new_attribs[:name])
    end

    it "should respond with status 200 on valid request" do
      expect(response.status).to eq(200)
    end

    it "should respond with status 400 on invalid request" do
      put :update, id: -1, project: @new_attribs
      expect(response.status).to eq(400)
    end

  end
end