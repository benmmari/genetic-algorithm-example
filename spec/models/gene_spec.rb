require "./spec/support/factory_bot"
require "./models/gene"

describe Gene do

  context 'init' do
    subject { gene }

    let(:gene) { Gene.new(value: value) }

    context 'when value is set' do
      let(:value) { 'v' }

      it 'returns the correct value' do
        expect(subject.value).to eq(value)
      end

      context 'when value is not in the current gene pool' do
        let(:value) { 'aa' }

        it 'raises an error' do
          expect{ subject }.to raise_error('value not in the gene pool')
        end
      end
    end

    context 'when value is not set' do
      let(:value) { nil }

      it 'ensures the internally set value is from the gene pool' do
        expect(%w(a b c d e f g h i j k l m n o p q r s t u v w x y z _).include? subject.value.downcase).to be true
      end
    end
  end

  context '#mutate' do
    subject { gene.mutate }

    let!(:gene) { Gene.new(value: nil) }

    it 'changes the value of the gene' do
      initial_value = gene.value
      expect(initial_value).to_not eq(subject.value)
    end

    it 'ensures the mutated value is from the gene pool' do
      expect(%w(a b c d e f g h i j k l m n o p q r s t u v w x y z _).include? subject.value.downcase).to be true
    end
  end
end
