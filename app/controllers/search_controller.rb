class SearchController < ApplicationController

  def show
    @how = params[:search][:how]
    @value = params[:search][:value]
    @model = params[:search][:model]
    @datas = search_for(@how, @value, @model)
  end

  private

  def match((value, model))
    if model == 'user'
      User.where("name LIKE ?", "#{value}")
    elsif model == 'book'
      Book.where("name LIKE ?", "#{value}")
    end
  end

  def forward(value, model)
    if model == 'user'
      User.where("name LIKE ?", "#{value}%")
    elsif model == 'book'
      Book.where("name LIKE ?", "#{value}%")
    end
  end

  def backward(value, model)
    if model == 'user'
      User.where("name LIKE ?", "%#{value}")
    elsif model == 'book'
      Book.where("name LIKE ?", "%#{value}")
    end
  end

  def partial(value, model)
    if model == 'user'
      User.where("name LIKE ?", "%#{value}%")
    elsif model == 'book'
      Book.where("name LIKE ?", "%#{value}%")
    end
  end

  def search_for(how, value, model)
    case how
    when 'match'
      match(value, model)
    when 'forward'
      forward(value, model)
    when 'backward'
      backward(value, model)
    when 'partial'
      partial(value, model)
    end
  end

end
