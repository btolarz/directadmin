class DirectAdmin::Domain < DirectAdmin::Connector

  def list
    CGI::parse(create_request('CMD_API_SHOW_DOMAINS'))["list[]"]
  end

  def create(domain)
    data = {
      domain: domain,
      action: 'create',
      bandwidth: 'unlimited',
      uquota: 'unlimited',
      ssl: 'OFF',
      cgi: 'ON',
      php: 'ON'
    }
    create_request('CMD_API_DOMAIN', data)
  end

  def change_name(old_domain,new_domain)
    data = {
      old_domain: old_domain,
      new_domain: new_domain
    }
    create_request('CMD_API_CHANGE_DOMAIN', data, :post)
  end

  def destroy(domain)
    data = {
      select0: domain,
      delete: true,
      confirmed: true
    }
    create_request('CMD_API_DOMAIN', data)
  end

end