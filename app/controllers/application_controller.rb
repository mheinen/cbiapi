class ApplicationController < ActionController::API

  def base

    puts params.inspect
    response = nil

    case params[:intent]
      when 'Greeting'
        response = {nameEins: params[:name1], nameZwei: params[:name2]}
      when 'Select'
        response =  getAll(params[:tablename])
    end

    render json: response

  end

  def getAll(tablename)

    response = nil
    case tablename
      when 'Kunden'
        response = {counter: 100}
      when 'Artikel'
        response = {counter: 900}
      else
        response = {counter: 0}
    end

    response

  end

end
