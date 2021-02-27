require 'rails_helper'

RSpec.describe Feedbacks::Volunteer, type: :model do
  subject { create(:volunteer_feedback) }

  it { expect(subject).to be_an_instance_of(Feedbacks::Volunteer) }
  it { expect(subject).to validate_presence_of(:category) }
  it { expect(subject).to validate_inclusion_of(:category).in_array(Feedback::CATEGORIES) }
  it { expect(subject).to validate_presence_of(:description) }
end
