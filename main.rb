require './environment'

POPULATION_CAPACITY = ARGV[0].to_i
INITIAL_POPULATION = ARGV[1].to_i
SOLUTION = ARGV[2]
CHROMOZOME_SIZE = SOLUTION.size
GENERATIONS_TO_DISPLAY = ARGV[3].to_i

Environment.new(
  population_capacity: POPULATION_CAPACITY,
  initial_population: INITIAL_POPULATION,
  solution: SOLUTION,
  chromosome_size: CHROMOZOME_SIZE,
  generations_to_display: GENERATIONS_TO_DISPLAY
  ).run_simulation
