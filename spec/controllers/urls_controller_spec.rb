RSpec.describe(UrlsController, type: :controller) do

  describe('#new') do
    it('renders') do
      get :new

      expect(assigns(:url)).to be_a(Urls::Create)
      expect(response).to render_template(:new)
    end
  end

  describe('create') do
    let(:interaction_stub) { instance_double(Urls::Create, valid?: valid, result: result) }
    let(:result) { nil }

    before do
      allow(Urls::Create).to receive(:run).and_return(interaction_stub)
    end

    context('when success') do
      let(:valid) { true }
      let(:result) { create(:url) }

      it('calls Urls::Create and redirects to show url path') do
        post(:create, params: { url: { url: 'http://onsport.com.br' } })

        expect(Urls::Create).to have_received(:run).with(url: 'http://onsport.com.br')
        expect(response).to redirect_to(result)
      end
    end

    context('when failure') do
      let(:valid) { false }

      it('calls Urls::Create and renders new') do
        post(:create, params: { url: { url: 'http://onsport.com.br' } })

        expect(Urls::Create).to have_received(:run).with(url: 'http://onsport.com.br')
        expect(response).to render_template(:new)
      end
    end
  end

  describe('access') do
    let(:interaction_stub) { instance_double(Urls::Access, valid?: valid, result: result, errors: errors) }
    let(:errors) { nil }

    before do
      allow(Urls::Access).to receive(:run).and_return(interaction_stub)
    end

    context('when success') do
      let(:valid) { true }
      let(:result) { create(:url) }

      it('calls Urls::Access and redirects to the url of the saved url') do
        get(:access, params: { token: result.token })

        expect(Urls::Access).to have_received(:run).with(token: result.token)
        expect(response).to redirect_to(result.url)
      end
    end

    context('when failure') do
      let(:valid) { false }
      let(:result) { create(:url) }
      let(:errors) { instance_double('errors', full_messages: ['error']) }

      it('calls Urls::Access and redirects to the url of the saved url') do
        get(:access, params: { token: result.token })

        expect(Urls::Access).to have_received(:run).with(token: result.token)
        expect(response.body).to eq('error')
      end
    end
  end
end
