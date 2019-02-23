require './chromosome'

class Organism

  attr_accessor :fitness
  attr_reader :chromosomes

  def initialize(chromosome_blueprint: [], chromosome_capacity:, genes_per_chromosome: 1)
    raise 'Chromosome capacity must be an even number' unless chromosome_capacity > 0 && chromosome_capacity % 2 == 0
    @chromosome_capacity = chromosome_capacity
    @genes_per_chromosome = genes_per_chromosome
    if chromosome_blueprint.empty?
      new_chromosomes = []
      chromosome_capacity.times {
        new_chromosomes << Chromosome.new(gene_capacity: genes_per_chromosome)
      }
      @chromosomes = new_chromosomes
    else
      @chromosomes = []
      chromosome_blueprint.each do |blueprint|
        @chromosomes << Chromosome.new(gene_capacity: genes_per_chromosome, genes: blueprint.generate_blueprint)
      end
      mutation_candidate_position = rand(chromosome_capacity)
      @chromosomes[mutation_candidate_position].mutate_gene
    end
  end

  def mate(partner:)
    my_chromosomes = get_chromosomes(true)
    partner_chromosomes = partner.get_chromosomes(false)
    child_chromosomes = my_chromosomes + partner_chromosomes
    Organism.new(chromosome_blueprint: child_chromosomes, chromosome_capacity: @chromosome_capacity, genes_per_chromosome: @genes_per_chromosome)
  end

  def calculate_fitness(goal:)
    result = goal.length
    genes = []
    chromosomes.each do |chromosome|
      genes << chromosome.gene_values
    end
    all_genes = genes.flatten.join("")

    ind = 0
    goal.each_char do |char|
      result -= 1 if all_genes[ind] == char
      ind += 1
    end

    @fitness = result
  end

  def get_chromosomes(first_half)
    half = @chromosome_capacity / 2
    first_half ? chromosomes[0..(half-1)] : chromosomes[half..(@chromosome_capacity-1)]
  end

  def display_gene_values
    genes = []
    chromosomes.each do |chromosome|
      genes << chromosome.gene_values
    end
    genes.flatten.join("")
  end
end
