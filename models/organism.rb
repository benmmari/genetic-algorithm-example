require_relative 'chromosome'

class Organism

  attr_reader :chromosomes, :parent_1, :parent_2
  attr_accessor :fitness

  def initialize(chromosome_blueprint: [], chromosome_capacity:, genes_per_chromosome: 1, parent_1: nil, parent_2: nil)
    validate!(chromosome_capacity, chromosome_blueprint)
    @parent_1 = parent_1
    @parent_2 = parent_2
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
      chromosome_blueprint.each do |chromosome|
        @chromosomes << Chromosome.new(gene_capacity: genes_per_chromosome, genes: chromosome.gene_blueprint)
      end
      mutation_candidate_position = rand(chromosome_capacity)
      @chromosomes[mutation_candidate_position].mutate_gene
    end
  end

  def mate(partner:)
    my_chromosomes = get_chromosomes(true)
    partner_chromosomes = partner.get_chromosomes(false)
    child_chromosomes = my_chromosomes + partner_chromosomes
    Organism.new(chromosome_blueprint: child_chromosomes,
      chromosome_capacity: @chromosome_capacity,
      genes_per_chromosome: @genes_per_chromosome,
      parent_1: self,
      parent_2: partner
    )
  end

  def validate!(chromosome_capacity, chromosome_blueprint)
    if chromosome_capacity < 2 || chromosome_capacity % 2 != 0
      raise 'Chromosome capacity must be an even number'
    end

    if chromosome_blueprint.any?  && chromosome_blueprint.size != chromosome_capacity
      raise 'Chromosome blueprint length must be equal to chromosome capacity'
    end
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
