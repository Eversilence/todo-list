require "rails_helper"

describe Api::CommentsController do
  let(:user)    { create(:user) }
  let(:project) { create(:project, user: user) }
  let(:task)    { create(:task, project: project) }

  before do
    sign_in(user)
  end

  describe "GET #index" do
    let(:comments) { create_list(:comment, 5, task: task) }

    before(:each) do
      get :index, task_id: task.id, format: :json
    end

    it "should return comments array" do
      expect(assigns(:comments)).to eq(comments)
    end
    it { should render_template('index') }
    it { should respond_with(200) }
  end

  describe "POST #create" do
    let(:comment_attrs) { attributes_for(:comment) }

    it "should create comment" do
      expect{ post :create, task_id: task.id, comment: comment_attrs }
      .to change(Comment, :count).by(1)
    end

    it "should return created comment" do
      post :create, task_id: task.id, comment: comment_attrs
      json = JSON.parse(response.body)
      expect(json["body"]).to eq(comment_attrs[:body])
    end

    it "should respond with status 200 on valid request" do
      post :create, task_id: task.id, comment: comment_attrs
      expect(response.status).to eq(200)
    end

    it "should respond with status 400 on invalid request" do
      post :create, task_id: -1, comment: comment_attrs
      expect(response.status).to eq(400)
    end

  end

  describe "DELETE #destroy" do
    let!(:comment) { create(:comment, task_id: task.id) }

    it "should delete comment" do
      expect{ delete :destroy, task_id: task.id, id: comment.id }
      .to change(Comment, :count).by(-1)
    end

    it "should respond with status 200 on valid request" do
      delete :destroy, task_id: task.id, id: comment.id
      expect(response.status).to eq(200)
    end

    it "should respond with status 400 on invalid request" do
      delete :destroy, task_id: task.id, id: -1
      expect(response.status).to eq(400)
    end

  end

  describe "UPDATE #put" do
      let(:comment)     { create(:comment, task_id: task.id) }
      let(:new_attribs) { { body: 'updated body' } }

    before(:each) do
      put :update, task_id: task.id, id: comment.id, comment: new_attribs
    end

    it "should update project" do
      comment.reload
      expect(comment[:body]).to eq(new_attribs[:body])
    end

    it "should respond with status 200 on valid request" do
      expect(response.status).to eq(200)
    end

    it "should respond with status 400 on invalid request" do
      put :update, task_id: task.id, id: comment.id, comment: nil
      expect(response.status).to eq(400)
    end
  end
end