class WelcomeController < ApplicationController

  def index

  end

  def csv_select
    $csv = $csv_orig.select{|row| row[params[:column]].to_i > params[:value].to_i} unless $csv_orig.nil?
  end

  def upload
    array = Array.new
    JSON.parse(params[:csv].to_json).each do |row|
        array << row[1]
    end
    $csv_orig = array
    $csv = array

    $csv.each do |kunde|
      Kunden.create(kundenid: kunde['KundeId'], vorname: kunde['Vorname'],
                    nachname: kunde['Nachname'], kundeseit: ['kundeKundeSeit'],
                    umsatz: kunde['Umsatz'], alter: kunde['Alter'])

    end
  end
end
