class StreamsController < ApplicationController
  def create
  end

  def new
  end

  def destroy
  end

  def index
    @names = Stream.pluck(:name)
  end
end
