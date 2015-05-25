class DirectAdmin::Connector

  attr_accessor :host, :port, :login, :password, :base_url, :domain

  def initialize(opt = {})
    @host     = DA_host
    @port     = DA_port
    @login    = opt[:login] || DA_login
    @password = opt[:password] || DA_password
    @domain   = DA_domain
    @base_url = "http://#{login}:#{password}@#{host}:#{port}"
  end

  def create_request(command, data = {}, method = :get)
    return RestClient.send(method, "#{base_url}/#{command}", params: data)
  end

  def parse_response(response)
    response = CGI::parse response
    puts response
    return {status: response['error'] == ["0"], details: response["details"].first}
  end

end