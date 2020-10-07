
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

  def show
    @url = Url.find(params[:id])
  end

  def access
    outcome = Urls::Access.run(token: params[:token])

    if outcome.valid?
      redirect_to(outcome.result.url)
    else
      render(plain: outcome.errors.full_messages.join(', '))
    end
  end

  private

  def url_params
    params.require(:url).permit(:url).to_h
  end

end
