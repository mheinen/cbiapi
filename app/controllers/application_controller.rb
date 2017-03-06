class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def base

    puts params.inspect
    response = nil

    case params[:intent]
      when 'Greeting'
        response = {nameEins: params[:name1], nameZwei: params[:name2]}
      when 'Select'
        response =  getAll(params[:tablename], params[:column], params[:operand], params[:value])
      else
        response = ''
    end

    render json: response

  end


  def getAll(tablename, column, operand, value)

    model = tablename.classify.constantize
    case operand
      when 'größer'
        operand2 = '>'
      when 'über'
        operand2 = '>'
      when 'mehr als'
        operand2 = '>'
      when 'kleiner'
        operand2 = '<'
      when 'kleiner'
        operand2 = '<'
      when 'weniger als'
        operand2 = '<'
      when 'größer gleich'
        operand2 = '>='
      when 'kleiner gleich'
        operand2 = '<='
      when 'gleich'
        operand2 = '='
      when 'mindestens'
        operand2 = '>='
      when 'höchstens'
        operand2 = '<='
      else
        operand2 = '='
    end
    result = model.where("#{column} #{operand2} '#{value}'").count
    number = result == 1 ? "einen" : result
    string = "Ich habe #{number} #{column} gefunden."
    { selectCount: result, speechOutput: string }

  end

end
