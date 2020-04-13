require "./models/organism"

describe Organism do

  let(:organism) { Organism.new(chromosome_blueprint: chromosome_blueprint, chromosome_capacity: chromosome_capacity) }
  let(:chromosome_blueprint) { [] }
  let(:chromosome_capacity) { 2 }
  let(:genes_per_chromosome) { 1 }

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

  context '#mate' do
    subject { organism.mate(partner: partner) }

    let(:partner) { Organism.new(chromosome_blueprint: partner_chromosome_blueprint, chromosome_capacity: chromosome_capacity) }
    let(:partner_chromosome_blueprint) { [Chromosome.new(gene_capacity: 1), Chromosome.new(gene_capacity: 1)] }

    it 'returns a child organism' do
      expect(subject).to be_a(Organism)
      expect(subject.parent_1).to eq(organism)
      expect(subject.parent_2).to eq(partner)
      expect(subject.chromosomes.size).to eq(chromosome_capacity)
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
