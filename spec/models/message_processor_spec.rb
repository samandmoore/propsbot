require 'rails_helper'

RSpec.describe MessageProcessor do
  describe '#perform' do
    it 'rejects props if no users present in text' do
      message_processor = MessageProcessor.new('Good Job!', 1, 'jim')
      expect(message_processor.perform).to eq 'You have to give props to someone!'

    end

    it "returns proper message for a single recipient" do
      message_processor = MessageProcessor.new('Good job <@U123|sam>!', 1, 'alex.bannon')
      expect(message_processor.perform).to eq 'You gave props to sam'
    end

    it "returns proper message for multiple recipients" do
      message_processor = MessageProcessor.new(
        'Good job <@U123|sam> and <@U456|chris.lopresto> with that thing!',
        1,
        'alex.bannon'
      )
      expect(message_processor.perform).to eq 'You gave props to sam, chris.lopresto'
    end
  end
end
