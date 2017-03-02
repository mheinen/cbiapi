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

    case tablename
      when 'Kunden'
        render json: {counter: 100}
      when 'Artikel'
        render json: {counter: 900}
      else
        render json: {counter: 0}
    end

  end

end
