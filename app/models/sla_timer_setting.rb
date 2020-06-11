class SlaTimerSetting < ActiveRecord::Base
  belongs_to :project

  validates :reaction_time, numericality: { :greater_than_or_equal_to => 0 }
  validates :reaction_time, :decoration, presence: true
end
