class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    can :read, :all # every user can see users, posts, comments and likes

    return unless user.present? # Returns if user is not registered

    can :manage, :all, author_id: user.id # Only author can manage his posts, comments, and likes
    return unless user.role == 'admin' # Returns if user is not an admin

    can :manage, :all # Admin can manage everything
  end
end
