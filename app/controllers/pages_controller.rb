class PagesController < ApplicationController

  def politicians
    @politicians = JSON.parse(File.read("app/helpers/politicians.json"))
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
