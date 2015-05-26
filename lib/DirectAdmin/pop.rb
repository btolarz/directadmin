class DirectAdmin::POP < DirectAdmin::Connector

  def pop_list
    data = {
      domain: domain,
      action: 'list'
    }
    response = create_request('CMD_API_POP', data)
    Rack::Utils.parse_nested_query(response)['list']
  end

  def pop_aliases
    data = {
      domain: domain
    }
    response = create_request('CMD_API_EMAIL_FORWARDERS', data)
    hash = Rack::Utils.parse_nested_query(response)
    arr = []
    hash.each do |k,v|
      arr << {alias: k, email: v}
    end
    return arr
  end

  def pop_create(user, password = SecureRandom.hex(3), quota = 100, limit = nil)
    if user.class == User
      user = "#{user.first_name}.#{user.last_name}"
    end
    data = {
      domain: domain,
      action: 'create',
      user: user.parameterize.gsub('-','.'),
      passwd: password,
      passwd2: password,
      quota: quota,
      limit: limit
    }
    AdminMailer.email_password(user.parameterize.gsub('-','.'),password).deliver
    request = create_request('CMD_API_POP', data)
    {request: request, password: password}
  end

  def pop_add_alias(user,email)
    data = {
      domain: domain,
      action: 'create',
      user: user,
      email: email
    }
    create_request('CMD_API_EMAIL_FORWARDERS', data)
  end

  def pop_remove_alias(email)
    data = {
      domain: domain,
      action: 'delete',
      select0: email
    }
    create_request('CMD_API_EMAIL_FORWARDERS', data)
  end

end