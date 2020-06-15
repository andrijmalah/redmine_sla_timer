class SlaTimerSettingsController < ApplicationController
  layout 'admin'

  before_action :find_project
  before_action :find_sla_timer_setting, only: :destroy

  def create
    @value = @project.sla_timer_settings.build
    @value.attributes = sla_settings_params["sla_timer_settings_attributes"]
    if @value.save
      flash[:notice] = l(:notice_successful_update) 
    end
    respond_to do |format|
      format.html { redirect_to :controller => 'projects', :action => 'settings', :id => @project, :tab => params[:tab] }
    end
  end

  def destroy
    if @sla_timer_setting.destroy
      flash[:notice] = l(:notice_successful_delete)
    else
      flash[:error] = l(:notice_unsuccessful_save)
    end
    redirect_to :controller => 'projects', :action => 'settings', :id => @project, :tab => params[:tab]
  end

  def update
    new_attr = sla_settings_params.to_hash || {}
    if @project.sla_timer_work_schedule
      new_attr['sla_timer_work_schedule_attributes'][:id] = @project.sla_timer_work_schedule.id
    end

    if @project.update_attributes(new_attr)
      flash[:notice] = l(:notice_successful_update)
    end
    redirect_to :controller => 'projects', :action => 'settings', :id => @project, :tab => params[:tab]
  end

  private

  def find_project
    @project = Project.find(params[:project_id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def find_sla_timer_setting
    @sla_timer_setting = SlaTimerSetting.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def sla_settings_params
    params.require(:project).permit(
      sla_timer_settings_attributes: [:id, :reaction_time, :decoration, :_destroy],
      sla_timer_work_schedule_attributes: [:work_time_from, :work_time_to, :work_days => []]
    )
  end
end
