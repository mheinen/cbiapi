class DbConnectorController < ApplicationController

  def connect
    adapter = params[:adapter]
    encoding = params[:encoding]
    database = params[:database]
    host = params[:host]
    username = params[:username]
    password = params[:password]

    @table = ActiveRecord::Base.establish_connection(
        adapter: adapter,
        host: host,
        encoding: encoding,
        database: database,
        username: username,
        password: password
    )
    puts @table.connection
    puts @table.connection.execute('select * from cbi where umsatz = 99').count

  end
end
