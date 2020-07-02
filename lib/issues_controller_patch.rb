require_dependency 'issues_controller'

module IssuesControllerPatch
  extend ActiveSupport::Concern

  included do
    before_action :authorize, :except => [:sla_timer_update]
 
    def sla_timer_update
      @issues = Issue.where(:id => params[:id])

      respond_to do |format|
        if @issues
          format.json { render json: @issues.map{ |i| { id: i.id, time: i.sla_timers } }.as_json }
        else
          timerload = {
            error: 'Issue not found',
            status: 400
          }
          format.json { render :json => timerload, :status => :bad_request }
        end
      end
    end
  end
end
IssuesController.send :include, IssuesControllerPatch