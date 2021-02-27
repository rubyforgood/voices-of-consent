require 'rails_helper'

RSpec.describe "feedbacks/volunteers/new", type: :view do

  describe 'accessing the page' do
    it 'must render the react root div' do
      page = render
      expect(page).to include('<div id="react-root"></div>')
    end
  end
end
