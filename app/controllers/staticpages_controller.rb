class StaticpagesController < ApplicationController
  skip_before_action :require_login, only: %i[top form]
  def top; end

  def form; end

end
