module Types
  class SubscriptionType < Types::BaseObject
    # field :task_created, subscription: Subscriptions::TaskCreated, description: "Triggered when a new task is created"
    field :task_created, Types::TaskType, null: false

    def task_created
      object
    end
  end
end