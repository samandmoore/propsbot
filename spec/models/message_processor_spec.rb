require 'rails_helper'

RSpec.describe MessageProcessor do
  describe '#perform' do
    it 'rejects props if no users present in text' do
      message_processor = MessageProcessor.new('Good Job!', 1)
      expect(message_processor.perform).to eq 'You have to give props to someone!'

    end
  end
end
