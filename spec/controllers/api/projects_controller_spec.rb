require "rails_helper"

# describe Api::ProjectsController do
#   context '#index' do
#     before do
#       user = FactoryGirl.create(:user)
#       @projects = FactoryGirl.create_list(:project, 5, user: user)
#       sign_in(user)
#     end
#     it "respond with projects" do

#       get :index, format: :json
#       # user = FactoryGirl.create(:user)
#       # project = FactoryGirl.create(:project, user: user)
#       # sign_in(user)

#       # get :index, format: :json
#       binding.pry
#       expect(assigns(:projects)).to eq(@projects)
#       it { should respond_with :ok }
#     end
#   end
# end


describe Api::ProjectsController do

  describe "GET #index" do
    before do
      user = FactoryGirl.create(:user)
      sign_in(user)
      @projects = FactoryGirl.create_list(:project, 5, user: user)
      get :index, format: :json
    end

    it { should render_template('index') }
    it { should respond_with(200) }
    it "should return projects array" do
      expect(assigns(:projects)).to eq(@projects)
    end
  end

  describe "POST #create" do
    before do
      user = FactoryGirl.create(:user)
      sign_in(user)
      @project_attrs = FactoryGirl.attributes_for(:project, user: user)
    end

    it "should create project" do
      expect{ post :create, project: @project_attrs }
      .to change(Project, :count).by(1)
    end

    it "should respond with status 200" do
      post :create, project: @project_attrs, format: :json
      expect(response.status).to eq(200)
    end

    it "should return created project" do
      # verify only id of projects
    end

  end

  describe "DELETE #destroy" do
    # implement later
  end
end