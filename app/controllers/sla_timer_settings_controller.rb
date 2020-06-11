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
    @project.update_attributes(sla_settings_params) 
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
    params.require(:project).
      permit(sla_timer_settings_attributes: [:id, :reaction_time, :decoration, :_destroy])
  end
end
