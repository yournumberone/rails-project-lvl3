# frozen_string_literal: true

class Admin::BulletinPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def reject?
    index?
  end

  def archive?
    index?
  end

  def publish?
    index?
  end
end
