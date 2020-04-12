require './models/organism'

class Environment

  attr_reader :population_capacity, :initial_population, :chromosome_size, :generations_to_display, :solution

  def initialize(population_capacity:, initial_population:, solution:, chromosome_size:, generations_to_display:)
    @population_capacity = population_capacity
    @initial_population = initial_population
    @solution = solution
    @chromosome_size = chromosome_size
    @generations_to_display = generations_to_display
  end

  def run_simulation
    create_initial_population
    sort_by_fitness
    display_population(display_organisms: true, suffix: ": initial population")
    @generation = 0
    while @population.first.fitness < chromosome_size
      @generation += 1
      puts "", "------------------------------------", "GENERATION #: #{@generation}"
      sort_by_fitness
      display_population
      puts "", "FITTEST ORGANISM: #{@population.first.display_gene_values}  #{@population.first.fitness}"
	    survival_of_the_fittest
      display_population(suffix: ": after the weakest pass on")
      sexy_time
	    display_population(suffix: ": after mating")
    end
    display_generations(@population.first)
  end

  def build_lineage(organism)
    @lineage = []
    @lineage << organism
    display_generations_no = generations_to_display < @generation ? generations_to_display : @generation

    for ind in 0..((2**(display_generations_no-1))-2)
      current = @lineage[ind]
      @lineage << (current ? current.parent_1 : nil)
      @lineage << (current ? current.parent_2 : nil)
    end
  end

  def display_generations(organism)
    build_lineage(organism)
    last = @lineage.size
    ind = last-1
    puts "", "Generations that lead to fittest organism"
    while ind >= 0
      current = @lineage[ind]
      print "G#{@generation+1 - Math.log2(ind+2).to_i} - " if po2?(ind+2)
      if current
          print " {#{current.display_gene_values}}"
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

  def create_initial_population
    @population = []
    initial_population.times {
      organism = Organism.new(chromosome_capacity: chromosome_size)
      calculate_fitness(goal: solution, organism: organism)
      @population << organism
    }
  end

  def calculate_fitness(goal:, organism:)
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


  def display_population(display_organisms: false, suffix: "")
    puts "Population: Size #{@population.size} #{suffix}"
    if display_organisms
      @population.each do |organism|
        puts "#{organism.display_gene_values} - #{organism.fitness}"
      end
    end
  end

  def sort_by_fitness
    @population.sort! { |x, y| y.fitness <=> x.fitness }
  end

  def survival_of_the_fittest
    current_capacity = @population.size
    half_capacity = (current_capacity / 2.to_f).ceil
    copy_pop = @population.dup
    @population = copy_pop[0..half_capacity-1]
  end

  def sexy_time
    current_capacity = @population.size
    last_organism = current_capacity - 1
    for current in 0..last_organism do
      break if  @population.size == population_capacity
      for partner in current..last_organism do
        if partner != current
            break if @population.size == population_capacity
            new_organism =  @population[current].mate(partner: @population[partner])
            calculate_fitness(goal: solution, organism: new_organism)
            @population << new_organism
        end
      end
    end
  end
end
