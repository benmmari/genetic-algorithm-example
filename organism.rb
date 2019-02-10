require './chromosome'

class Organism

  attr_accessor :fitness
  attr_reader :chromosome

  def initialize(randomize: true, genes: nil, size:)
    raise 'Chromozome size must be an even number' unless size > 0 && size % 2 == 0
    @size = size
    if randomize
        @chromosome = Chromosome.new(size: size, randomize: true)
    else
        @chromosome = Chromosome.new(size: size, genes: genes)
    end
  end

  def mate(partner:)
    half = @size / 2
    my_genes = get_genes(organism: self, number: half)
    partner_genes = get_genes(organism: partner, number: half)
    child_genes = my_genes + partner_genes
    Organism.new(randomize: false, genes: child_genes, size: @size)
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
