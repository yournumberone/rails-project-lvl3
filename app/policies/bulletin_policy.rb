# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def show?
    record.user == user || record.published? || user.admin?
  end

  def edit?
    return false if user.nil?

    record.user == user
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end

  def archive?
    edit?
  end

  def to_moderate?
    edit?
  end
end
