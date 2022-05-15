class Admin::CategoryPolicy < ApplicationPolicy

  def index?
    return false if user.nil?

    user.admin?
  end

  def create?
    index?
  end

  def destroy?
    index?
  end
end
