class PagesController < ApplicationController

  def politicians
    @politicians = if (Rails.env.staging? || Rails.env.development?)
      JSON.parse(File.read("app/helpers/dummy-politicians.json"))
    elsif Rails.env.production?
      JSON.parse(File.read("app/helpers/politicians.json"))
    end
  end

  def terms
  end

  def diplomat
    @experts = JSON.parse(File.read("app/helpers/experts.json"))
    @tuttors = JSON.parse(File.read("app/helpers/tuttors.json"))
  end

  def digital_era
  end

  def maping
  end
end
