require "rails_helper"

describe Api::AttachmentsController do
  render_views # it is needed to render jbuilder template

  let(:user)    { create(:user) }
  let(:project) { create(:project, user: user) }
  let(:task)    { create(:task, project: project) }
  let(:comment) { create(:comment, task: task) }

  before do
    sign_in(user)
  end

  describe "GET #index" do
    let!(:attachments) { create_list(:attachment, 5, comment: comment) }

    before(:each) do
      get :index, comment_id: comment.id, format: :json
    end

    it "should return attachments array" do
      expect(assigns(:attachments)).to eq(attachments)
    end
    it { should render_template('index') }
    it { should respond_with(200) }
  end

  describe "POST #create" do
    let(:attachment_attrs) { attributes_for(:attachment, comment: comment) }

    it "should create attachment" do
      expect{ post :create, comment_id: comment.id, file: attachment_attrs[:file], format: :json }
      .to change(Attachment, :count).by(1)
    end

    it "should return created attachment" do
      post :create, comment_id: comment.id, file: attachment_attrs[:file], format: :json
      json = JSON.parse(response.body)
      expect(json["filename"]).to eq(attachment_attrs[:file].original_filename)
    end

    it "should respond with status 200 on valid request" do
      post :create, comment_id: comment.id, file: attachment_attrs[:file], format: :json
      expect(response.status).to eq(200)
    end

    it "should respond with status 400 on invalid request" do
      post :create, comment_id: -1, file: attachment_attrs[:file], format: :json
      expect(response.status).to eq(400)
    end
  end

  describe "DELETE #destroy" do
    let!(:attachment) { create(:attachment, comment_id: comment.id) }

    it "should delete attachment" do
      expect{ delete :destroy, comment_id: comment.id, id: attachment.id }
      .to change(Attachment, :count).by(-1)
    end

    it "should respond with status 200 on valid request" do
      delete :destroy, comment_id: comment.id, id: attachment.id
      expect(response.status).to eq(200)
    end

    it "should respond with status 400 on invalid request" do
      delete :destroy, comment_id: comment.id, id: -1
      expect(response.status).to eq(400)
    end

  end
end