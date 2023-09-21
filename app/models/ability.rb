# frozen_string_literal: true

class Ability
  include CanCan::Ability

 def initialize(user)
# binding.pry

user ||= User.new
can :read, Post


    if user.present?


      if user && user.admin?
        can :manage, :all

      elsif user && user.editor?
        can :manage, Post, user_id: user.id
        can :read, :all
        can :create, Post
        can :like, Post
        can :edit, Post
        can :update, Post
        can :destroy, Post, user_id: user.id

      elsif user && user.normal?
        can :manage, Post, user_id: user.id
        can :read, :all
        can :create, Post
        can :like, Post
        can :edit, Post
        can :destroy, Post, user_id: user.id

      end

    else
      can :read, :sign_up
    end
  end
end
