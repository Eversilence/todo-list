require "cancan/matchers"
require "rails_helper"

describe "User" do
  describe "abilities" do
    subject(:ability)    { Ability.new(user) }

    let(:project)    { Project.new(user: user) }
    let(:task)       { Task.new(project: project) }
    let(:comment)    { Comment.new(task: task) }
    let(:attachment) { Attachment.new(comment: comment)}

    context 'logged in' do
      let(:user)  { create(:user) }

      it "can CRUD project" do
        ability.should be_able_to(:create, project)
        ability.should be_able_to(:index, project)
        ability.should be_able_to(:update, project)
        ability.should be_able_to(:destroy, project)
      end

      it "can CRUD task" do
        ability.should be_able_to(:create, task)
        ability.should be_able_to(:index, task)
        ability.should be_able_to(:update, task)
        ability.should be_able_to(:destroy, task)
      end

      it "can CRUD comment" do
        ability.should be_able_to(:create, comment)
        ability.should be_able_to(:index, comment)
        ability.should be_able_to(:update, comment)
        ability.should be_able_to(:destroy, comment)
      end

      it "can CRUD attachment" do
        ability.should be_able_to(:create, attachment)
        ability.should be_able_to(:index, attachment)
        ability.should be_able_to(:update, attachment)
        ability.should be_able_to(:destroy, attachment)
      end

    end

    context "logged out" do
      let(:user)  { nil }

      it "cannot CRUD project" do
        ability.should_not be_able_to(:create, project)
        ability.should_not be_able_to(:index, project)
        ability.should_not be_able_to(:update, project)
        ability.should_not be_able_to(:destroy, project)
      end

      it "cannot CRUD task" do
        ability.should_not be_able_to(:create, task)
        ability.should_not be_able_to(:index, task)
        ability.should_not be_able_to(:update, task)
        ability.should_not be_able_to(:destroy, task)
      end

      it "cannot CRUD comment" do
        ability.should_not be_able_to(:create, comment)
        ability.should_not be_able_to(:index, comment)
        ability.should_not be_able_to(:update, comment)
        ability.should_not be_able_to(:destroy, comment)
      end

      it "cannot CRUD attachment" do
        ability.should_not be_able_to(:create, attachment)
        ability.should_not be_able_to(:index, attachment)
        ability.should_not be_able_to(:update, attachment)
        ability.should_not be_able_to(:destroy, attachment)
      end

    end
  end
end