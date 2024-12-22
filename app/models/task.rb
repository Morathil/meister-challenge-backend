class Task < ApplicationRecord
  belongs_to :project
  after_save :trigger_task_created_event

  private

  def trigger_task_created_event
    MeisterChallengeSchema.subscriptions.trigger("task_created", {}, self)
  end
end
