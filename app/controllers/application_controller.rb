class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  prepend_before_action :set_doorkeeper_token
  before_action :doorkeeper_authorize!

  def base

    table_name = params[:table]
    column = params[:column]
    operand = params[:operand]
    value = params[:value]
    with_graph = params[:withGraph]
    kind = params[:kind]
    group_column = params[:groupColumn]
    function = params[:function]
    agg_column = params[:aggColumn]

    data = select_data(table_name, column, operand, value)

    case params[:intent]
      when 'Select'
        response = intent_select(data, table_name, column, operand, value, with_graph)
      when 'Group'
        response =  intent_group(data, group_column, kind, with_graph, function, agg_column)
      else
        response = { selectCount: '', speechOutput: '' }
    end

    render json: response

  end

  def select_data(table, column = nil, operand = nil, value = nil)

    model = table.classify.constantize
    case operand
      when 'größer'
        operand2 = '>'
      when 'größer als'
        operand2 = '>'
      when 'über'
        operand2 = '>'
      when 'mehr als'
        operand2 = '>'
      when 'kleiner'
        operand2 = '<'
      when 'kleiner als'
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
    column.nil? ? model.all : model.where("#{column} #{operand2} '#{value}'")

  end

  def intent_select(data, table_name, column = nil, operand = nil, value = nil, with_graph)
    result = data.count
    number = result == 1 ? "einen" : result
    columnNil = column.nil? ? '' : 'mit'
    string = "Ich habe #{number} #{table_name} #{columnNil} #{column} #{operand} #{value} gefunden!" +
        "Wollen Sie eine neue Analyse durchführen?"
    if with_graph
      #tbd
    end
    { selectCount: result, speechOutput: string}
  end

  def intent_group(data, group_column, kind, with_graph, function, agg_column)

    case function.downcase
      when 'summe'
        func = 'SUM'
      when 'durchschnitt'
        func = 'AVG'
      when 'minimum'
        func = 'MIN'
      when 'maximum'
        func = 'MAX'
      when 'zählen'
        func = 'COUNT'
      when 'anzahl'
        func = 'COUNT'
      else
        func = 'COUNT'
    end

    if kind == 'group'
      query = '"'+group_column + '"' + ', ' + func + '("' + agg_column + '") AS ' + func + '_' + agg_column +
          ', COUNT(id) AS anzahl_faelle'
      result = data.group(group_column).select(query)
      puts result.as_json
      length = result.length
      length == 1 ? string = "Ich habe eine Gruppen gebildet!" : string = "Ich habe #{length} Gruppen gebildet!"
      string += "Wollen Sie eine neue Analyse durchführen?"
      if with_graph
        #tbd
      end
      { selectCount: length, speechOutput: string }
    end
  end

  def current_doorkeeper_user
    @current_doorkeeper_user ||= User.find(doorkeeper_token.resource_owner_id)
  end

  private

  def set_doorkeeper_token
    request.parameters[:access_token] = token_from_params
  end

  def token_from_params
    params["accessToken"] rescue nil
  end

end
