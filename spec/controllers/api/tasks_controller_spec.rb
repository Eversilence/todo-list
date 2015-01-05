require "rails_helper"

describe Api::TasksController do
  before do
    @user = FactoryGirl.create(:user)
    sign_in(@user)

    @project = FactoryGirl.create(:project, user: @user)
  end

  describe "GET #index" do
    before(:each) do
      @tasks = FactoryGirl.create_list(:task, 5, project: @project)
      get :index, project_id: @project.id, format: :json
    end

    it "should return tasks array" do
      expect(assigns(:tasks)).to eq(@tasks)
    end
    it { should render_template('index') }
    it { should respond_with(200) }
  end

  describe "POST #create" do
    before do
      @task_attrs = FactoryGirl.attributes_for(:task, project_id: @project.id)
    end

    it "should create project" do
      expect{ post :create, project_id: @project.id, task: @task_attrs }
      .to change(Task, :count).by(1)
    end

    it "should return created project" do
      post :create, project_id: @project.id, task: @task_attrs
      json = JSON.parse(response.body)
      expect(json["name"]).to eq(@task_attrs[:name])
    end

    it "should respond with status 200 on valid request" do
      post :create, project_id: @project.id, task: @task_attrs
      expect(response.status).to eq(200)
    end

    it "should respond with status 400 on invalid request"
  end

  describe "DELETE #destroy" do
    before do
      @task = FactoryGirl.create(:task, project_id: @project.id)
    end

    it "should delete project" do
      expect{ delete :destroy, project_id: @project.id, id: @task.id }
      .to change(Task, :count).by(-1)
    end

    it "should respond with status 200 on valid request" do
      delete :destroy, project_id: @project.id, id: @task.id
      expect(response.status).to eq(200)
    end

    it "should respond with status 400 on invalid request" do
      delete :destroy, project_id: @project.id, id: -1
      expect(response.status).to eq(400)
    end

  end

  describe "UPDATE #put" do
    before(:each) do
      @task = FactoryGirl.create(:task, project_id: @project.id)
      @new_attribs = { name: 'updated name' }
      put :update, project_id: @project.id, id: @task.id, task: @new_attribs
    end

    it "should update project" do
      @task.reload
      expect(@task[:name]).to eq(@new_attribs[:name])
    end

    it "should respond with status 200 on valid request" do
      expect(response.status).to eq(200)
    end

    it "should respond with status 400 on invalid request" do
      put :update, project_id: @project.id, id: -1, task: @new_attribs
      expect(response.status).to eq(400)
    end
  end
end