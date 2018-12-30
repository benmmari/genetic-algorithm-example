require './organism'

POPULATION_CAPACITY = 1000
INITIAL_POPULATION = 10
SOLUTION = 'RANDOM'

def run_simulation
    create_initial_population
    sort_by_fitness
    display_population(display_organisms: true)
    generation = 1
    while @population.first.fitness > 0
        puts "", "GENERATION #{generation}"
        display_population
        survival_of_the_fittest
        display_population
        sexy_time
        sort_by_fitness
        display_population
        generation += 1
        puts ""
        print "FITTEST ORGANISM:"
        @population.first.chromosome.display
        print " "
        print @population.first.fitness
    end
end

def create_initial_population
    @population = []
    INITIAL_POPULATION.times {
       organism = Organism.new
       organism.calculate_fitness(goal: SOLUTION)
       @population << organism
      }
end

def display_population(display_organisms: false)
    puts "Population: Size #{@population.length}"
    if display_organisms
        @population.each do |organism|
           organism.chromosome.display
           puts organism.fitness
        end
    end
end

def sort_by_fitness
    @population.sort! { |x, y| x.fitness <=> y.fitness }
end

def survival_of_the_fittest
    current_capacity = @population.length
    half_capacity = (current_capacity / 2.to_f).ceil
    @population = @population[0..half_capacity-1]
end

def sexy_time
    current_capacity = @population.size
    remainder = current_capacity - 1
    for current in 0..remainder do
        break if  @population.length == POPULATION_CAPACITY
        for partner in current..remainder do
            if partner != current
                break if  @population.length == POPULATION_CAPACITY
                @population << @population[current].mate(partner: @population[partner])
                @population.last.calculate_fitness(goal: SOLUTION)
            end
        end
    end
end

run_simulation
