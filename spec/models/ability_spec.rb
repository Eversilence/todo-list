require "cancan/matchers"
require "rails_helper"

describe "User" do
  describe "abilities" do
    subject(:ability)    { Ability.new(user) }

    let(:new_project)    { Project.new(user: user) }
    let(:new_task)       { Task.new(project: new_project) }
    let(:new_comment)    { Comment.new(task: new_task) }
    let(:new_attachment) { Attachment.new(comment: new_comment)}

    let(:owned_project)    { create(:project, user: owner) }
    let(:owned_task)       { create(:task, project: owned_project) }
    let(:owned_comment)    { create(:comment, task: owned_task) }
    let(:owned_attachment) { create(:attachment, comment: owned_comment) }

    context 'logged in' do

      let(:user)  { create(:user) }
      let(:owner) { user }

      it "can CRUD project" do
        ability.should be_able_to(:create, new_project)
        ability.should be_able_to(:read, owned_project)
        ability.should be_able_to(:update, owned_project)
        ability.should be_able_to(:destroy, owned_project)
      end

      it "can CRUD task" do
        ability.should be_able_to(:create, new_task)
        ability.should be_able_to(:read, owned_task)
        ability.should be_able_to(:update, owned_task)
        ability.should be_able_to(:destroy, owned_task)
      end

      it "can CRUD comment" do
        ability.should be_able_to(:create, new_comment)
        ability.should be_able_to(:read, owned_comment)
        ability.should be_able_to(:update, owned_comment)
        ability.should be_able_to(:destroy, owned_comment)
      end

      it "can CRUD attachment" do
        ability.should be_able_to(:create, new_attachment)
        ability.should be_able_to(:read, owned_attachment)
        ability.should be_able_to(:update, owned_attachment)
        ability.should be_able_to(:destroy, owned_attachment)
      end

    end

    context "logged out" do

      let(:user)  { nil }
      let(:owner) { create(:user) }

      it "cannot CRUD project" do
        ability.should_not be_able_to(:create, new_project)
        ability.should_not be_able_to(:read, owned_project)
        ability.should_not be_able_to(:update, owned_project)
        ability.should_not be_able_to(:destroy, owned_project)
      end

      it "cannot CRUD task" do
        ability.should_not be_able_to(:create, new_task)
        ability.should_not be_able_to(:read, owned_task)
        ability.should_not be_able_to(:update, owned_task)
        ability.should_not be_able_to(:destroy, owned_task)
      end

      it "cannot CRUD comment" do
        ability.should_not be_able_to(:create, new_comment)
        ability.should_not be_able_to(:read, owned_comment)
        ability.should_not be_able_to(:update, owned_comment)
        ability.should_not be_able_to(:destroy, owned_comment)
      end

      it "cannot CRUD attachment" do
        ability.should_not be_able_to(:create, new_attachment)
        ability.should_not be_able_to(:read, owned_attachment)
        ability.should_not be_able_to(:update, owned_attachment)
        ability.should_not be_able_to(:destroy, owned_attachment)
      end

    end
  end
end