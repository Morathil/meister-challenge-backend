class GraphqlActionCableHandler
  
  def self.execute(data:, channel:)
    data = sanitize(data)
    query = data["query"]
    variables = data["variables"]
    operation_name = data["operationName"]
    context = { channel: }
    
    MeisterChallengeSchema.execute(query:,context:,variables:,operation_name:)
  end

  private_class_method def self.sanitize(data)
    data["variables"] = ensure_hash(data["variables"])
    data
  end

  private_class_method def self.ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end
end