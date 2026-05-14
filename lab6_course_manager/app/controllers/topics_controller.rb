class TopicsController < ApplicationController
  before_action :set_topic, only: %i[show edit update destroy]

  def index
    @topics = Topic.order(:name)
  end

  def show; end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)
    if @topic.save
      redirect_to @topic, notice: "Topic created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @topic.update(topic_params)
      redirect_to @topic, notice: "Topic updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @topic.destroy
    redirect_to topics_path, notice: "Topic deleted"
  end

  private

  def set_topic
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:name)
  end
end
