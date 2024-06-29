class StaticpagesController < ApplicationController
  skip_before_action :require_login, only: %i[top form policy]
  def top; end

  def form; end

  def policy; end

  def term; end

end
