class DirectAdmin::Pointer  < DirectAdmin::Connector

  def list(domain)
    data = {
      domain: domain
    }
    responce = create_request('CMD_API_DOMAIN_POINTER', data)

    parsed_responce = Rack::Utils.parse_nested_query(responce)
    if parsed_responce.any?
      return parsed_responce.collect{|k,v| k}
    else
      []
    end
  end

  def create(domain,new_domain, is_alias = true)
    data = {
      domain: domain,
      action: :add,
      from: new_domain,
      alias: is_alias
    }
    create_request('CMD_API_DOMAIN_POINTER', data)
  end

  def destroy(domain,old_domain)
    data = {
      domain: domain,
      action: :delete,
      select0: old_domain
    }
    create_request('CMD_API_DOMAIN_POINTER', data)
  end

end