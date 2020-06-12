class SlaTimerSetting < ActiveRecord::Base
  belongs_to :project

  validates :reaction_time, numericality: { :greater_than_or_equal_to => 0 }
  validates :reaction_time, :decoration, presence: true

  def reaction_time=(h)
    write_attribute :reaction_time, (h.is_a?(String) ? (h.to_hours || h) : h)
  end

end
