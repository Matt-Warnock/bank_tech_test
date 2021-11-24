# frozen_string_literal: true

require 'null_action'

RSpec.describe NullAction do
  describe '#run' do
    it 'returns nil' do
      expect(subject.run).to be nil
    end
  end
end
