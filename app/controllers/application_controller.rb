class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def base

    table_name = params[:table]
    column = params[:column]
    operand = params[:operand]
    value = params[:value]
    with_graph = params[:withGraph]
    kind = params[:kind]
    group_column = params[:groupColumn]

    data = select_data(table_name, column, operand, value)

    case params[:intent]
      when 'Select'
        response = intent_select(column, operand, value, with_graph, data)
      when 'Group'
        response =  intent_group(data, group_column, kind, with_graph)
      else
        response = { selectCount: '', speechOutput: '' }
    end

    render json: response

  end

  def select_data(table, column, operand, value)

    model = table.classify.constantize
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

    model.where("#{column} #{operand2} '#{value}'")

  end

  def intent_select(column, operand, value, with_graph, data)
    result = data.count
    number = result == 1 ? "einen" : result
    string = "Ich habe #{number} #{table_name} mit #{column} #{operand} #{value} gefunden!" +
        "Wollen Sie eine neue Analyse durchführen?"
    if with_graph
      #tbd
    end
    { selectCount: result, speechOutput: string }
  end

  def intent_group(data, group_column, kind, with_graph)
    if kind == 'group'
      grouped = data.group(group_column)
      result = grouped.count
      number = result == 1 ? "einen" : result
      string = "Ich habe #{number} Gruppen gebildet!" +
          "Wollen Sie eine neue Analyse durchführen?"
      if with_graph
        #tbd
      end
      { selectCount: result, speechOutput: string }
    end
  end

end
