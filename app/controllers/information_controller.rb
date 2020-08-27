class InformationController < ApplicationController
  skip_before_action :authenticate_user!
  def top; end
  def help; end
end
