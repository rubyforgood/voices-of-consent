require 'rails_helper'

RSpec.describe Feedbacks::Volunteer, type: :model do
  subject { create(:volunteer_feedback) }

  it { expect(subject).to be_an_instance_of(Feedbacks::Volunteer) }
end
