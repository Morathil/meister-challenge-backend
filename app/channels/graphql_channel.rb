class GraphqlChannel < ApplicationCable::Channel
  def subscribed
    @subscription_ids = []
  end

  def execute(data)
    result = ::GraphqlActionCableHandler.execute(data:, channel: self)

    payload = {
      result: result.subscription? ? { data: nil } : result.to_h,
      more: result.subscription?,
    }

    # Track the subscription here so we can remove it
    # on unsubscribe.
    if result.context[:subscription_id]
      @subscription_ids << result.context[:subscription_id]
    end

    transmit(payload)
  end

  def unsubscribed
    @subscription_ids.each do |id|
      MeisterChallengeSchema.subscriptions.delete_subscription(id)
    end
  end
end