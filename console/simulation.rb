require './models/environment'

class Simulation

  attr_reader :environment

  def initialize(population_capacity:, initial_population:, solution:, generations_to_display:)
    @environment = Environment.new(
      population_capacity: POPULATION_CAPACITY,
      initial_population: INITIAL_POPULATION,
      solution: SOLUTION,
      generations_to_display: GENERATIONS_TO_DISPLAY
      )
  end

  def run_simulation
    environment.create_initial_population
    display_population(display_organisms: true, suffix: ": initial population")
    @generation = 0
    while environment.fittest_organism.fitness <= environment.chromosome_size
      @generation += 1
      puts "", "------------------------------------", "GENERATION #: #{generation}"
      environment.sort_by_fitness!
      display_population
      puts "", "FITTEST ORGANISM: #{environment.fittest_organism.gene_values}  #{environment.fittest_organism.fitness}"

      break if environment.fittest_organism.fitness == environment.chromosome_size

      environment.survival_of_the_fittest
      display_population(suffix: ": after the weakest pass on")
      environment.sexy_time
      display_population(suffix: ": after mating")
    end
    display_generations(environment.fittest_organism)
  end

  private

  attr_reader :generation

 def display_generations(organism)
    lineage = environment.build_lineage(organism)
    last = lineage.size
    ind = last - 1
    puts "", "Generations that lead to fittest organism"
    while ind >= 0
      current = lineage[ind]
      print "G#{generation + 1 - Math.log2(ind+2).to_i} - " if po2?(ind+2)
      if current
        print " {#{current.gene_values}}"
      else
        print " {N/A}"
      end
      puts "" if po2?(ind+1)
      ind-=1
    end
  end

  def po2?(n)
    n.to_s(2).count('1') == 1
  end

  def display_population(display_organisms: false, suffix: "")
    puts "Population: Size #{environment.population.size} #{suffix}"
    if display_organisms
      environment.population.each do |organism|
        puts "#{organism.gene_values} - #{organism.fitness}"
      end
    end
  end
end
