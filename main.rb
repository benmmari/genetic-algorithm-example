require './organism'

POPULATION_CAPACITY = ARGV[0].to_i
INITIAL_POPULATION = ARGV[1].to_i
SOLUTION = ARGV[2]
CHROMOZOME_SIZE = SOLUTION.size
GENERATIONS_TO_DISPLAY = ARGV[3].to_i

def run_simulation
    create_initial_population
    sort_by_fitness
    display_population(display_organisms: true, suffix: ": initial population")
    generation = 1
    while @population.first.fitness > 0
        puts "", "GENERATION #: #{generation}"
        sort_by_fitness
        display_population
        puts ""
        puts "FITTEST ORGANISM: #{@population.first.display_gene_values}  #{@population.first.fitness}"
	    survival_of_the_fittest
        display_population(suffix: ": after the weakest pass on")
        sexy_time
	    display_population(suffix: ": after mating")
        generation += 1
    end
    display_generations(@population.first)
end

def build_lineage(organism)
    @lineage = []
    @lineage << organism
    for ind in 0..(((2**(GENERATIONS_TO_DISPLAY-1))-1)-1)
        current = @lineage[ind]
        @lineage << current.parent_1
        @lineage << current.parent_2
    end
end

def display_generations(organism)
    build_lineage(organism)
    last = @lineage.size
    generation = GENERATIONS_TO_DISPLAY
    ind = last-1
    puts "", "Generations that lead to fittest organism"
    while ind >= 0
        current = @lineage[ind]
        print "G#{Math.log2(ind+2).to_i-1} - " if po2?(ind+2)
        print " |#{current.display_gene_values}|"
        puts "" if po2?(ind+1)
        ind-=1
    end
end

def po2?(n)
    n.to_s(2).count('1') == 1
end

def generation(n)

end

def create_initial_population
    @population = []
    INITIAL_POPULATION.times {
       organism = Organism.new(chromosome_capacity: CHROMOZOME_SIZE)
       organism.calculate_fitness(goal: SOLUTION)
       @population << organism
    }
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
    @population.sort! { |x, y| x.fitness <=> y.fitness }
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
        break if  @population.size == POPULATION_CAPACITY
        for partner in current..last_organism do
            if partner != current
                break if @population.size == POPULATION_CAPACITY
                new_organism =  @population[current].mate(partner: @population[partner])
                new_organism.calculate_fitness(goal: SOLUTION)
                @population << new_organism
            end
        end
    end
end

run_simulation
