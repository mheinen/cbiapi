class ApplicationController < ActionController::API

  def base

    puts params.inspect
    case params[:intent]
      when 'Greeting'
        render json: {nameEins: params[:name1], nameZwei: params[:name2]}
      when 'Select'
        render getAll(params[:tablename])
    end

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
