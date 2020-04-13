require "./models/chromosome"

describe Chromosome do

  let(:chromosome) { Chromosome.new(gene_capacity: gene_capacity, genes: genes) }
  let(:gene_capacity) { 2 }
  let(:genes) { nil }

  context 'init' do
    subject { chromosome }

    context 'when genes are passed in' do
      let(:genes) { [Gene.new, Gene.new] }

      it 'returns the correct value' do
        expect(subject.genes).to eq(genes)
      end

      context 'when genes limit is not equal to gene capacity' do
        let(:genes) { [Gene.new, Gene.new, Gene.new] }

        it 'raises an error' do
          expect { subject }.to raise_error("Number of genes is greater than permitted size of #{gene_capacity}")
        end
      end
    end

    context 'when genes are not passed in' do
      let(:genes) { nil }

      it 'ensures the genes are set correctly' do

        expect(subject.genes.size).to eq(gene_capacity)
      end
    end
  end

  context '#mutate_gene!' do
    subject { chromosome.mutate_gene! }
    let(:gene_position) { 4 }

    it 'mutates one of the gene values - at random' do
      initial_gene = chromosome.genes[gene_position]

      expect_any_instance_of(described_class).to receive(:rand) .with(gene_capacity) { gene_position }
      expect(chromosome.genes[gene_position]).to receive(:mutate!) { 'mutation' }


      expect(initial_gene).to_not eq(subject)
    end
  end

  context '#gene_blueprint' do
    subject { chromosome.gene_blueprint }
    let(:genes) { [Gene.new, Gene.new] }

    it 'returns duplicates of the genes' do
      chromosome.genes.each do |s|
        expect(s).to receive(:dup) .and_call_original
      end

      expect(subject.map(&:value)).to eq(chromosome.genes.map(&:value))
    end
  end

  context '#gene_values' do
    subject { chromosome.gene_values }
    let(:genes) { [Gene.new, Gene.new] }

    it 'returns values of the genes' do
      expect(subject).to eq(chromosome.genes.map(&:value))
    end
  end
end
