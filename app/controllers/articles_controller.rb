class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]

  # GET /articles or /articles.json
  def index
   
      # @articles = Rails.cache.fetch('all_articles', expires_in: 1.hour) do
      #   puts '###' * 100
      #   logger.debug("Fetching articles from database")
      #   Article.all

      # @articles = Article.all
    end


  end
  # GET /articles/1 or /articles/1.json
  def show

      puts '###' * 100
      puts 'show method called'
    
  end

  def search
    
    @no_search_query = false
   
    if params[:query].present?
      @results = Article.search_by_title_and_category(params[:query])
      
      log_query
     
     
    else
          # if no query is present, return 10 latest articles 
          @results = Article.order('published_date DESC').limit(10)
          @no_search_query = true
 
           
      end
      respond_to do |format|
        format.turbo_stream
        format.html { render partial: 'articles/results', locals: { results: @results, no_search_query: @no_search_query } }
      end
 
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to article_url(@article), notice: "Article was successfully created." }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to article_url(@article), notice: "Article was successfully updated." }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy!

    respond_to do |format|
      format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def log_query
    user_queries = Rails.cache.fetch('user_queries', expires_in: 5.minutes) { [] }
    user_queries << { query: params[:query], ip_address: request.remote_ip }
    Rails.cache.write('user_queries', user_queries)
  end


    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :category, :author, :published_date)
    end
end
