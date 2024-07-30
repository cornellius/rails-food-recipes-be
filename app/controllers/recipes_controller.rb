class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[ show edit update destroy ]
  protect_from_forgery with: :null_session

  # GET /recipes or /recipes.json
  def index
    @per_page = Kaminari.config.default_per_page
    params[:page]? @page = params[:page] : @page = 1

    if params[:ingredients]
      @total_recipes, @recipes = Recipe.search_by_ingredients(params[:ingredients])
    else
      @total_recipes = Recipe.all.count
      @recipes = Recipe.all.includes(:author, :category).order(created_at: :desc).page(@page)
    end
  end

  # GET /recipes/1 or /recipes/1.json
  def show
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit
  end

  # POST /recipes or /recipes.json
  def create
    @recipe = Recipe.new(
      title: params[:recipe][:title],
      prep_time: params[:recipe][:prep_time],
      cook_time: params[:recipe][:cook_time],
      ingredients: params[:ingredients],
      ratings: params[:recipe][:rating],
      category_id: params[:recipe][:category_id],
      author_id: params[:recipe][:author_id]
    )

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to recipe_url(@recipe), notice: "Recipe was successfully created." }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1 or /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to recipe_url(@recipe), notice: "Recipe was successfully updated." }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    @recipe.destroy!

    respond_to do |format|
      format.html { redirect_to recipes_url, notice: "Recipe was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def recipe_params
      params.require(:recipe).permit(:title, :cook_time, :prep_time, :ratings, :category_id, :author_id, :ingredients => {})
    end
end
