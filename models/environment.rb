require './models/organism'

class Environment

  attr_reader :population_capacity, :initial_population, :chromosome_size, :generations_to_display, :solution, :population

  def initialize(population_capacity:, initial_population:, solution:, generations_to_display:)
    @population_capacity = population_capacity
    @initial_population = initial_population
    @solution = solution
    @chromosome_size = solution.size
    @generations_to_display = generations_to_display
    @population = []
  end

  def build_lineage(organism)
    lineage = []
    lineage << organism

    for ind in 0..((2**(generations_to_display-1))-2)
      current = lineage[ind]
      lineage << (current ? current.parent_1 : nil)
      lineage << (current ? current.parent_2 : nil)
    end
    lineage
  end

  def create_initial_population
    initial_population.times {
      new_organism = Organism.new(chromosome_capacity: chromosome_size)
      calculate_fitness(organism: new_organism)
      add_to_population(organism: new_organism, population: @population)
    }
  end

  def calculate_fitness(goal: solution, organism:)
    result = 0
    genes = []
    organism.chromosomes.each do |chromosome|
      genes << chromosome.gene_values
    end
    all_genes = genes.flatten.join("")

    ind = 0
    goal.each_char do |char|
      result += 1 if all_genes[ind] == char
      ind += 1
    end

    organism.fitness = result
  end

  def sort_by_fitness!
    population.sort! { |x, y| y.fitness <=> x.fitness }
  end

  def survival_of_the_fittest
    current_capacity = population.size
    half_capacity = (current_capacity / 2.to_f).ceil
    @population = population[0..half_capacity-1]
  end

  def fittest_organism
    sort_by_fitness!
    population.first
  end

  def sexy_time
    current_capacity = population.size
    last_organism = current_capacity - 1
    for current in 0..last_organism do
      break if  population.size == population_capacity
      for partner in current..last_organism do
        if partner != current
            break if population.size == population_capacity
            new_organism =  population[current].mate(partner: population[partner])
            calculate_fitness(organism: new_organism)
            add_to_population(organism: new_organism, population: @population)
        end
      end
    end
  end

  private

  def add_to_population(organism:, population:)
    population << organism
  end
end
