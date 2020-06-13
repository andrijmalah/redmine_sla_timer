class SlaTimerSettingsController < ApplicationController
  layout 'admin'

  before_action :find_project
  before_action :find_sla_timer_setting, only: :destroy 

  def create
    @value = @project.sla_timer_settings.build
    @value.attributes = sla_settings_params["sla_timer_settings_attributes"]
    @value.save
    respond_to do |format|
      format.html { redirect_to project_sla_timer_settings_path(@project) }
      format.js
    end
  end

  def destroy
    @sla_timer_setting.destroy
    redirect_to :controller => 'projects', :action => 'settings', :id => @project, :tab => params[:tab]
  end

  def update
    new_attr = sla_settings_params.to_hash || {}
    byebug
    # new_attr['sla_timer_work_schedule_attributes'] = { :days_time => '00:00' }
    if @project.sla_timer_work_schedule
      new_attr['sla_timer_work_schedule_attributes'][:id] = @project.sla_timer_work_schedule.id
    end

    # @project.update_attributes(sla_settings_params)
    @project.update_attributes(new_attr)
    redirect_to :controller => 'projects', :action => 'settings', :id => @project, :tab => params[:tab]
  end

  def timer_update
    days_time_config = sla_work_days_params[:sla_work_days_settings]
    # sla_work_days_params[:sla_work_days_settings][:work_days].each do |day|
      # days_time_config[WorkingHours::Config::DAYS_OF_WEEK[day.to_i]] = '00:00'
      # days_config[day] = '00:00'
    # end
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
# sla_timer_work_schedule_attributes: [:work_days => []],
#<ActionController::Parameters 
#{"settings"=>{"work_days"=>["1", "3"]}, "commit"=>"Save", "tab"=>"sla_timer", "controller"=>"sla_timer_settings", "action"=>"timer_update", "project_id"=>"buh"} permitted: false>

#params.require(:project).permit(sla_timer_work_schedule_attributes: [:days_time => [:work_days => [], :work_time => []]])
# "work_time_from"=>"1:18", "sla_timer_work_schedule_attributes"=>    {"days_time"=>{                  "work_time"=>  {"from"=>"1.3", "to"=>"00:02"}}, 
#   "work_time_from"=>"1.4"}}