# frozen_string_literal: true

class Admin::BulletinPolicy < ApplicationPolicy
  def index?
    admin?
  end
end
