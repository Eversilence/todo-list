require "rails_helper"

describe Api::TasksController do
  render_views

  let(:user)    { create(:user) }
  let(:project) { create(:project, user: user) }

  before do
    sign_in(user)
  end

  describe "GET #index" do
    let!(:tasks) { create_list(:task, 5, project: project) }

    before(:each) do
      get :index, project_id: project.id, format: :json
    end

    it "should return tasks array" do
      expect(assigns(:tasks)).to eq(tasks)
    end
    it { should render_template('index') }
    it { should respond_with(200) }
  end



  describe "POST #create" do
    let(:task_attrs) { attributes_for(:task) }

    it "should create project" do
      expect{ post :create, project_id: project.id, task: task_attrs, format: :json }
      .to change(Task, :count).by(1)
    end

    it "should return created project" do
      post :create, project_id: project.id, task: task_attrs, format: :json
      json = JSON.parse(response.body)
      expect(json["name"]).to eq(task_attrs[:name])
    end

    it "should respond with status 200 on valid request" do
      post :create, project_id: project.id, task: task_attrs, format: :json
      expect(response.status).to eq(200)
    end

    it "should respond with status 400 on invalid request" do
      post :create, project_id: project.id, task: nil, format: :json
      expect(response.status).to eq(400)

      post :create, project_id: -1, task: task_attrs[:name] = '', format: :json
      expect(response.status).to eq(400)
    end

    context 'Priority of tasks' do
      let!(:isolated_project) { create(:project, user: user) }
      let!(:first_task)       { create(:task, project: isolated_project) }
      let!(:second_task)      { create(:task, project: isolated_project) }
      let!(:third_task)       { create(:task, project: isolated_project) }

      it "should be created with correct priority" do
        expect(first_task.position).to eq(1)
        expect(second_task.position).to eq(2)
        expect(third_task.position).to eq(3)
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:task) { create(:task, project_id: project.id) }

    it "should delete project" do
      expect{ delete :destroy, project_id: project.id, id: task.id }
      .to change(Task, :count).by(-1)
    end

    it "should respond with status 200 on valid request" do
      delete :destroy, project_id: project.id, id: task.id
      expect(response.status).to eq(200)
    end

    it "should respond with status 400 on invalid request" do
      delete :destroy, project_id: project.id, id: -1
      expect(response.status).to eq(400)
    end

  end

  describe "UPDATE #put" do
      let(:task)        { create(:task, project_id: project.id) }
      let(:new_attribs) { { name: 'updated name' } }

    before(:each) do
      put :update, project_id: project.id, id: task.id, task: new_attribs
    end

    it "should update project" do
      task.reload
      expect(task[:name]).to eq(new_attribs[:name])
    end

    it "should respond with status 200 on valid request" do
      expect(response.status).to eq(200)
    end

    it "should respond with status 400 on invalid request" do
      put :update, project_id: project.id, id: task.id, task: nil
      expect(response.status).to eq(400)
    end
  end
end