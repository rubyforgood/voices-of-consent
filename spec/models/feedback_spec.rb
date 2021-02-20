require 'rails_helper'

RSpec.describe Feedback, type: :model do
  subject { create(:feedback) }

  it { expect(subject).to be_an_instance_of(Feedback) }
end
