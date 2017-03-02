class ApplicationController < ActionController::API
  def base
    puts params.inspect
    render json: {nameEins: params[:name1], nameZwei: params[:name2]}
  end
end
