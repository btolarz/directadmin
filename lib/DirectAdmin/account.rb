class DirectAdmin::Account < DirectAdmin::Connector

  def list
    Rack::Utils.parse_nested_query(create_request('CMD_API_SHOW_ALL_USERS'))['list']
  end

  def create(username,email,password,domain)
    data = {
      ip: DA_host,
      domain: domain,
      username: username,
      email: email,
      passwd: password,
      passwd2: password,
      action: 'create',
      add: 'Submit'
    }
    create_request('CMD_API_ACCOUNT_USER', data)
  end

end