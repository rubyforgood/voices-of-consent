# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
RSpec.describe 'shared/_navigation.html.erb', type: :view do
  context 'user_signed_in? false' do
    before do
      allow(view).to receive(:user_signed_in?).and_return(false)
    end

    it 'renders navigation bar' do
      render

      assert_select 'a', text: 'Status', count: 0
      assert_select 'a', text: 'Review', count: 0
      assert_select 'a', text: 'Design', count: 0
      assert_select 'a', text: 'Packing', count: 0
      assert_select 'a', text: 'Shipping', count: 0
      assert_select 'a', text: 'Feedback', count: 0
    end
  end

  context 'user_signed_in? true && is_admin? false' do
    before do
      @user = create(:user)
      allow(view).to receive(:user_signed_in?).and_return(true)
      allow(view).to receive(:current_user).and_return(@user)
    end

    it 'renders navigation bar' do
      render

      assert_select "a[href='/box_requests']", text: 'Status', count: 1
      assert_select "a[href='/feedbacks']", text: 'Feedback', count: 0
      base_url = '/box_requests?filter_by='
      assert_select "a[href='#{base_url}review_in_progress&current_user_id=#{@user.id}']",
                    text: 'Review', count: 1
      assert_select "a[href='#{base_url}design_in_progress&current_user_id=#{@user.id}']",
                    text: 'Design', count: 1
      assert_select "a[href='#{base_url}assembly_in_progress&current_user_id=#{@user.id}']",
                    text: 'Packing', count: 1
      assert_select "a[href='#{base_url}shipping_in_progress&current_user_id=#{@user.id}']",
                    text: 'Shipping', count: 1
    end
  end

  context 'user_signed_in? true && is_admin? true' do
    before do
      @user = create(:user)
      allow(view).to receive(:user_signed_in?).and_return(true)
      allow(view).to receive(:current_user).and_return(@user)
      allow(@user).to receive(:is_admin?).and_return(true)
    end

    it 'renders navigation bar' do
      render

      assert_select "a[href='/box_requests']", text: 'Status', count: 1
      base_url = '/box_requests?filter_by='
      assert_select "a[href='#{base_url}review_in_progress&current_user_id=#{@user.id}']",
                    text: 'Review', count: 0
      assert_select "a[href='#{base_url}review_in_progress']",
                    text: 'Review', count: 1
      assert_select "a[href='#{base_url}design_in_progress&current_user_id=#{@user.id}']",
                    text: 'Design', count: 0
      assert_select "a[href='#{base_url}design_in_progress']",
                    text: 'Design', count: 1
      assert_select "a[href='#{base_url}assembly_in_progress&current_user_id=#{@user.id}']",
                    text: 'Packing', count: 0
      assert_select "a[href='#{base_url}assembly_in_progress']",
                    text: 'Packing', count: 1
      assert_select "a[href='#{base_url}shipping_in_progress&current_user_id=#{@user.id}']",
                    text: 'Shipping', count: 0
      assert_select "a[href='#{base_url}shipping_in_progress']",
                    text: 'Shipping', count: 1
    end

    it 'renders menu icons' do
      render

      assert_select 'i', class: 'fas fa-user-clock'
      assert_select 'i', class: 'fas fa-address-card'
      assert_select 'i', class: 'fas fa-object-group'
      assert_select 'i', class: 'fas fa-box-open'
      assert_select 'i', class: 'fas fa-box'
    end
  end
end
