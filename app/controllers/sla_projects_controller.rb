class SlaProjectsController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    # @polls = Poll.find(:all) # @project.polls
  end
end
