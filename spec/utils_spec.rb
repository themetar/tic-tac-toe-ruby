require_relative '../src/utils'
require 'stringio'

describe Utils do  
  describe '::prompt' do
    let(:mock_in) { StringIO.new }
    let(:stub_out) { StringIO.new }

    before {
      $stdin = mock_in
      $stdout = stub_out
    }

    it 'shows test to user and returns their input' do
      mock_in.puts 'test 1'
      mock_in.puts 'test 2'
      mock_in.rewind
      
      expect { Utils.prompt('question') }.to output("question\n").to_stdout

      expect(Utils.prompt('question')).to eq('test 2')
    end

    it 'returns defaut value on empty input' do
      mock_in.puts ''
      mock_in.rewind

      expect(Utils.prompt('question', 'def')).to eq('def')
    end

    it 'reprompts when a validation block is given' do
      mock_in.puts 'Hello'
      mock_in.puts 'What?'
      mock_in.puts '5'
      mock_in.puts '1'
      mock_in.rewind

      expect(
        Utils.prompt('Enter a number from 1 to 9') { |input| input.to_i.between?(1, 9) }
      ).to eq('5')
    end

    after {
      $stdin = STDIN
      $stdout = STDOUT
    }
  end

end
