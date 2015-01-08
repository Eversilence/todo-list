class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :create, :read, :update, :destroy, :to => :crud

    if user
      can :crud, Project, :user_id => user.id
      can :crud, Task, project: { user_id: user.id}
      can :crud, Comment, task: { project: { user_id: user.id} }
      can :crud, Attachment, comment: { task: { project: { user_id: user.id} } }
    else
      cannot :crud, Project
      cannot :crud, Task
      cannot :crud, Comment
      cannot :crud, Attachment
    end

  end
end