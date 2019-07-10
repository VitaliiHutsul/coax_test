class ArticlesController < ApplicationController


	def index
		@articles = Article.all
		@articles = @articles.paginate(page: params[:page], per_page: 5)
	end


	def new

	end

	def show
		@article = Article.find(params[:date])
		authorize @article
	end

	def import
		ParserService.new.render_data
		redirect_to root_path
		flash[:success] = "data imported"
	end

	private
	  def article_params
	   params.require(:article).permit(:date, :ruby_gem, :url, :cve)
	  end
end
