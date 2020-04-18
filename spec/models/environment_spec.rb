require "./models/chromosome"
require "./models/gene"
require "./models/environment"

describe Environment do
  let!(:environment) { Environment.new(population_capacity: population_capacity, initial_population: initial_population, solution: solution, generations_to_display: generations_to_display) }

  let(:population_capacity) { 100 }
  let(:initial_population) { 10 }
  let(:solution) { 'TEST' }
  let(:generations_to_display) { 2 }

  context '#calculate_fitness!' do
    subject { environment.calculate_fitness(organism: organism) }

    let(:organism) { Organism.new(chromosome_blueprint: chromosome_blueprint, chromosome_capacity: solution.size, mutate: false) }
    let(:chromosome_blueprint) do
      [
        Chromosome.new(gene_capacity: 1, genes: [Gene.new(value: 'T')]),
        Chromosome.new(gene_capacity: 1, genes: [Gene.new(value: 'E')]),
        Chromosome.new(gene_capacity: 1, genes: [Gene.new(value: 'S')]),
        Chromosome.new(gene_capacity: 1, genes: [Gene.new(value: 'T')]),
      ]
      end

    it 'returns the correct fitness value' do
      expect(subject).to eq(4)
    end
  end

  context '#sort_by_fitness!!' do
    subject do
     environment.sort_by_fitness!
   end

    let(:initial_population) { 3 }
    let(:organism_1) { Organism.new(chromosome_blueprint: chromosome_blueprint_1, chromosome_capacity: solution.size, mutate: false) }
    let(:chromosome_blueprint_1) do
      [
        Chromosome.new(gene_capacity: 1, genes: [Gene.new(value: 'T')]),
        Chromosome.new(gene_capacity: 1, genes: [Gene.new(value: 'E')]),
        Chromosome.new(gene_capacity: 1, genes: [Gene.new(value: 'S')]),
        Chromosome.new(gene_capacity: 1, genes: [Gene.new(value: 'X')]),
      ]
      end

    let(:organism_2) { Organism.new(chromosome_blueprint: chromosome_blueprint_2, chromosome_capacity: solution.size, mutate: false) }
    let(:chromosome_blueprint_2) do
      [
        Chromosome.new(gene_capacity: 1, genes: [Gene.new(value: 'T')]),
        Chromosome.new(gene_capacity: 1, genes: [Gene.new(value: 'E')]),
        Chromosome.new(gene_capacity: 1, genes: [Gene.new(value: 'X')]),
        Chromosome.new(gene_capacity: 1, genes: [Gene.new(value: 'X')]),
      ]
      end

    let(:organism_3) { Organism.new(chromosome_blueprint: chromosome_blueprint_3, chromosome_capacity: solution.size, mutate: false) }
    let(:chromosome_blueprint_3) do
      [
        Chromosome.new(gene_capacity: 1, genes: [Gene.new(value: 'T')]),
        Chromosome.new(gene_capacity: 1, genes: [Gene.new(value: 'E')]),
        Chromosome.new(gene_capacity: 1, genes: [Gene.new(value: 'S')]),
        Chromosome.new(gene_capacity: 1, genes: [Gene.new(value: 'T')]),
      ]
      end

    before do
      environment.create_initial_population
      environment.instance_variable_set(:@population, [organism_1, organism_2, organism_3].map do |organism|
        environment.calculate_fitness(organism: organism)
        organism
      end
      )
    end

    it 'sorts the population in order of fitness, desceding' do
      subject
      expect(environment.population).to match_array([organism_3, organism_1, organism_2])
    end
  end

  context 'fittest_organism' do
    subject do
     environment.fittest_organism
   end

    let(:initial_population) { 3 }
    let(:organism_1) { Organism.new(chromosome_blueprint: chromosome_blueprint_1, chromosome_capacity: solution.size, mutate: false) }
    let(:chromosome_blueprint_1) do
      [
        Chromosome.new(gene_capacity: 1, genes: [Gene.new(value: 'T')]),
        Chromosome.new(gene_capacity: 1, genes: [Gene.new(value: 'E')]),
        Chromosome.new(gene_capacity: 1, genes: [Gene.new(value: 'S')]),
        Chromosome.new(gene_capacity: 1, genes: [Gene.new(value: 'X')]),
      ]
      end

    let(:organism_2) { Organism.new(chromosome_blueprint: chromosome_blueprint_2, chromosome_capacity: solution.size, mutate: false) }
    let(:chromosome_blueprint_2) do
      [
        Chromosome.new(gene_capacity: 1, genes: [Gene.new(value: 'T')]),
        Chromosome.new(gene_capacity: 1, genes: [Gene.new(value: 'E')]),
        Chromosome.new(gene_capacity: 1, genes: [Gene.new(value: 'X')]),
        Chromosome.new(gene_capacity: 1, genes: [Gene.new(value: 'X')]),
      ]
      end

    let(:organism_3) { Organism.new(chromosome_blueprint: chromosome_blueprint_3, chromosome_capacity: solution.size, mutate: false) }
    let(:chromosome_blueprint_3) do
      [
        Chromosome.new(gene_capacity: 1, genes: [Gene.new(value: 'T')]),
        Chromosome.new(gene_capacity: 1, genes: [Gene.new(value: 'E')]),
        Chromosome.new(gene_capacity: 1, genes: [Gene.new(value: 'S')]),
        Chromosome.new(gene_capacity: 1, genes: [Gene.new(value: 'T')]),
      ]
      end

     before do
      environment.create_initial_population
      environment.instance_variable_set(:@population, [organism_1, organism_2, organism_3].map do |organism|
        environment.calculate_fitness(organism: organism)
        organism
      end
      )
     end

    it 'returns the fittest organism' do
      expect(subject).to eq(organism_3)
    end
  end

  context 'create_initial_population' do
    subject do
     environment.create_initial_population
   end

    it 'creates the initial population of the correct size' do
      subject
      expect(environment.population.size).to eq(initial_population)
    end

    # technically this could be a heisenspec
    it 'ensures the organisms are created randomly' do
      subject
      expect(environment.population.map(&:gene_values).uniq.size).to eq(initial_population)
    end
  end

  context 'survival_of_the_fittest' do
    subject do
      environment.survival_of_the_fittest
    end

    before do
     environment.create_initial_population
    end

    it 'divides the population in half' do
      before_population_size = environment.population.size
      subject
      after_population_size = environment.population.size
      expect(after_population_size * 2).to eq(before_population_size)
    end

    it 'ensures the fittest organisms remain' do
      before_population = environment.population
      subject
      after_population = environment.population
      dead_organisms = before_population - after_population
      fittest_dead_organism = dead_organisms.sort { |x, y| y.fitness <=> x.fitness }.first
      after_population.each do |organism|
        organism.fitness > fittest_dead_organism.fitness
      end
    end
  end

  context 'build_lineage' do
    subject do
      environment.build_lineage(organism_1)
    end

    let(:initial_population) { 7 }
    let(:generations_to_display) { 4 }
    let(:chromosome_blueprint) do
      [
        Chromosome.new(gene_capacity: 1),
        Chromosome.new(gene_capacity: 1),
        Chromosome.new(gene_capacity: 1),
        Chromosome.new(gene_capacity: 1)
      ]
      end
    let(:organism_1) { Organism.new(chromosome_blueprint: chromosome_blueprint, chromosome_capacity: solution.size, parent_1: organism_2, parent_2: organism_3) }
    let(:organism_2) { Organism.new(chromosome_blueprint: chromosome_blueprint, chromosome_capacity: solution.size, parent_1: organism_6, parent_2: organism_7) }
    let(:organism_3) { Organism.new(chromosome_blueprint: chromosome_blueprint, chromosome_capacity: solution.size, parent_1: organism_4, parent_2: organism_5) }
    let(:organism_4) { Organism.new(chromosome_blueprint: chromosome_blueprint, chromosome_capacity: solution.size) }
    let(:organism_5) { Organism.new(chromosome_blueprint: chromosome_blueprint, chromosome_capacity: solution.size) }
    let(:organism_6) { Organism.new(chromosome_blueprint: chromosome_blueprint, chromosome_capacity: solution.size) }
    let(:organism_7) { Organism.new(chromosome_blueprint: chromosome_blueprint, chromosome_capacity: solution.size) }

     before do
      environment.create_initial_population
      environment.instance_variable_set(:@population, [organism_1, organism_2, organism_3, organism_4, organism_5, organism_6, organism_7])
     end

    it 'returns the correct lineage for the oranism' do
      expect(subject).to eq([organism_1, organism_2, organism_3, organism_6, organism_7, organism_4, organism_5, nil, nil, nil, nil, nil, nil, nil, nil])
    end
  end

  context 'sexy_time' do
    subject do
      environment.sexy_time
    end

    let(:initial_population) { 3 }
    let(:chromosome_blueprint) do
      [
        Chromosome.new(gene_capacity: 1),
        Chromosome.new(gene_capacity: 1),
        Chromosome.new(gene_capacity: 1),
        Chromosome.new(gene_capacity: 1)
      ]
      end
    let(:organism_1) { Organism.new(chromosome_blueprint: chromosome_blueprint, chromosome_capacity: solution.size) }
    let(:organism_2) { Organism.new(chromosome_blueprint: chromosome_blueprint, chromosome_capacity: solution.size) }
    let(:organism_3) { Organism.new(chromosome_blueprint: chromosome_blueprint, chromosome_capacity: solution.size) }

     before do
      environment.instance_variable_set(:@population, [organism_1, organism_2, organism_3].map do |organism|
        environment.calculate_fitness(organism: organism)
        organism
      end
      )
     end

    it 'ensures the population does not go beyond capacity' do
      subject
      expect(environment.population.size <= population_capacity).to be true
    end

    it 'ensures no organism mates with itself' do
      subject
      environment.population.each do |organism|
        expect(organism.parent_1 != organism.parent_2).to be true unless organism.parent_1.nil?
      end
    end

    it 'increases the population by the expected value' do
      subject
      expect(environment.population.size).to eq(6)
    end

    it 'ensures all new organisms have their fitness set' do
      subject
      environment.population.each do |organism|
        expect(organism.fitness).to_not eq nil
      end
    end

    it 'ensures the fittest organisms mate more' do
      expect(organism_1).to receive(:mate).exactly(2).times .and_call_original
      expect(organism_2).to receive(:mate).exactly(1).times .and_call_original
      subject
    end
  end
end
