require "rails_helper"

describe Api::CommentsController do
  before do
    @user = FactoryGirl.create(:user)
    sign_in(@user)
    project = FactoryGirl.create(:project, user: @user)
    @task = FactoryGirl.create(:task, project: project)
  end

  describe "GET #index" do
    before(:each) do
      @comments = FactoryGirl.create_list(:comment, 5, task: @task)
      get :index, task_id: @task.id, format: :json
    end

    it "should return tasks array" do
      expect(assigns(:comments)).to eq(@comments)
    end
    it { should render_template('index') }
    it { should respond_with(200) }
  end

  describe "POST #create" do
    before do
      @comment_attrs = FactoryGirl.attributes_for(:comment)
    end

    it "should create project" do
      expect{ post :create, task_id: @task.id, comment: @comment_attrs }
      .to change(Comment, :count).by(1)
    end

    it "should return created project" do
      post :create, task_id: @task.id, comment: @comment_attrs
      json = JSON.parse(response.body)
      expect(json["body"]).to eq(@comment_attrs[:body])
    end

    it "should respond with status 200 on valid request" do
      post :create, task_id: @task.id, comment: @comment_attrs
      expect(response.status).to eq(200)
    end

    it "should respond with status 400 on invalid request"
  end

  describe "DELETE #destroy" do
    before do
      @comment = FactoryGirl.create(:comment, task_id: @task.id)
    end

    it "should delete project" do
      expect{ delete :destroy, task_id: @task.id, id: @comment.id }
      .to change(Comment, :count).by(-1)
    end

    it "should respond with status 200 on valid request" do
      delete :destroy, task_id: @task.id, id: @comment.id
      expect(response.status).to eq(200)
    end

    it "should respond with status 400 on invalid request" do
      delete :destroy, task_id: @task.id, id: -1
      expect(response.status).to eq(400)
    end

  end

  describe "UPDATE #put" do
    before(:each) do
      @comment = FactoryGirl.create(:comment, task_id: @task.id)
      @new_attribs = { body: 'updated body' }
      put :update, task_id: @task.id, id: @comment.id, comment: @new_attribs
    end

    it "should update project" do
      @comment.reload
      expect(@comment[:body]).to eq(@new_attribs[:body])
    end

    it "should respond with status 200 on valid request" do
      expect(response.status).to eq(200)
    end

    it "should respond with status 400 on invalid request" do
      put :update, task_id: @task.id, id: -1, comment: @new_attribs
      expect(response.status).to eq(400)
    end
  end
end