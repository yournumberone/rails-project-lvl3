# frozen_string_literal: true

class AdminPolicy < ApplicationPolicy
  def admin?
    return false if user.nil?

    user.admin?
  end
end
