require "./models/organism"

describe Organism do

  let(:organism) { Organism.new(chromosome_blueprint: chromosome_blueprint, chromosome_capacity:chromosome_capacity, genes_per_chromosome: 1, parent_1: parent_1, parent_2: parent_2) }
  let(:chromosome_blueprint) { [] }
  let(:chromosome_capacity) { 2 }
  let(:genes_per_chromosome) { 1 }
  let(:parent_1) { nil }
  let(:parent_2) { nil }

  context 'init' do
    subject { organism }

    context 'when blueprint is passed in' do
      let(:chromosome_blueprint) { [Chromosome.new(gene_capacity: 1), Chromosome.new(gene_capacity: 1)] }
      let(:chromosome_position) { 1 }

      it 'returns chromosomes with mutation' do
        expect_any_instance_of(described_class).to receive(:rand) .with(chromosome_capacity) { chromosome_position }
        expect_any_instance_of(Chromosome).to receive(:mutate_gene!) .and_call_original
        subject
      end

      context 'when chromosome blueprint size is not equal to chromosome capacity' do
        let(:chromosome_blueprint) { [Chromosome.new(gene_capacity: 1)] }
        let(:chromosome_capacity) { 4 }

        it 'raises an error' do
          expect { subject }.to raise_error("Chromosome blueprint length must be equal to chromosome capacity")
        end
      end

      context 'when chromosome capacity is not an even number' do
        let(:chromosome_capacity) { 1 }

        it 'raises an error' do
          expect { subject }.to raise_error("Chromosome capacity must be an even number")
        end
      end
    end

    context 'when blueprint is not passed in' do
      let(:genes) { nil }

      it 'ensures the chromosomes are set correctly' do

        expect(subject.chromosomes.size).to eq(chromosome_capacity)
      end
    end
  end

  xcontext '#mutate_gene' do
    subject { chromosome.mutate_gene }
    let(:gene_position) { 4 }

    it 'mutates one of the gene values - at random' do
      initial_gene = chromosome.genes[gene_position]

      expect_any_instance_of(described_class).to receive(:rand) .with(gene_capacity) { gene_position }
      expect(chromosome.genes[gene_position]).to receive(:mutate!) { 'mutation' }


      expect(initial_gene).to_not eq(subject)
    end
  end

  context '#get_chromosomes' do
    subject { organism.get_chromosomes(first_half) }


    context 'first half is true' do
      let(:first_half) { true }

      it 'returns the correct chromosones' do
        expect(subject).to eq([organism.chromosomes[0]])
      end
    end

    context 'first half is false' do
      let(:first_half) { false }

      it 'returns the correct chromosones' do
        expect(subject).to eq([organism.chromosomes[1]])
      end
    end
  end

  context '#display_gene_values' do
    subject { organism.display_gene_values }
    let(:chromosome_blueprint) { [Chromosome.new(gene_capacity: 1), Chromosome.new(gene_capacity: 1)] }

    it 'returns values of the genes' do
      expect(subject).to eq(organism.chromosomes.map { |c| c.genes.map(&:value) }.flatten.join(""))
    end
  end
end
