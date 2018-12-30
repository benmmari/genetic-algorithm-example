require './chromosome'

class Organism

  CHROMOSOME_SIZE = 6
  MATING_LIMIT = 3

  attr_accessor :mated_number, :fitness
  attr_reader :chromosome

  def initialize(randomize: true, genes: nil)
    @mated_number = 0
    if randomize
        @chromosome = Chromosome.new(size: CHROMOSOME_SIZE, randomize: true)
    else
        @chromosome = Chromosome.new(size: CHROMOSOME_SIZE, genes: genes)
    end
  end

  def mate(partner:)
    half = CHROMOSOME_SIZE / 2
    my_genes = get_genes(organism: self, number: half)
    partner_genes = get_genes(organism: partner, number: half)
    child_genes = my_genes + partner_genes
    @mated_number += 1
    partner.mated_number += 1
    Organism.new(randomize: false, genes: child_genes)
  end

  def calculate_fitness(goal:)
    result = goal.length
    ind = 0
    goal.each_char do |char|
       result -= 1 if @chromosome.genes[ind].value == char
       ind += 1
    end
    @fitness = result
    @fitness
  end

  private

  def get_genes(organism:, number:)
    genes = []
    number.times {
      value = organism.chromosome.genes[rand(number * 2)].value
      genes << Gene.new(value: value, randomize: false)
    }
    genes
  end
end
