class BirdsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  # GET /birds
  def index
    birds = Bird.all
    render json: birds
  end

  # POST /birds
  def create
    bird = Bird.create(bird_params)
    render json: bird, status: :created
  end

  # GET /birds/:id
  def show
    render json: find_bird
  end

  # PATCH /birds/:id
  def update
    find_bird.update(bird_params)
    render json: find_bird
  end

  # PATCH /birds/:id/like
  def increment_likes
    find_bird.update(likes: find_bird.likes + 1)
    render json: find_bird
  end

  # DELETE /birds/:id
  def destroy
    find_bird.destroy
    head :no_content
  end

  private

  def bird_params
    params.permit(:name, :species, :likes)
  end

  def find_bird
    Bird.find_by(id: params[:id])
  end

  def render_not_found_response
    render json: { error: "Bird not found" }, status: :not_found
  end

end
