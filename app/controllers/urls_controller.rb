
class UrlsController < ApplicationController

  def new
    @url = Urls::Create.new
  end

  def create
    outcome = Urls::Create.run(url_params)

    if outcome.valid?
      redirect_to(outcome.result)
    else
      @url = outcome
      render(:new)
    end
  end

  private

  def url_params
    params.require(:url).permit(:url)
  end

end
