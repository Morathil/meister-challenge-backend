
class Subscriptions::TaskCreated < GraphQL::Schema::Subscription
  field :task, Types::TaskType, null: true

  def update
    super
  end
end
