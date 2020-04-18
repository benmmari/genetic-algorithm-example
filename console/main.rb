require_relative 'simulation'

POPULATION_CAPACITY = ARGV[0].to_i
INITIAL_POPULATION = ARGV[1].to_i
SOLUTION = ARGV[2]
GENERATIONS_TO_DISPLAY = ARGV[3].to_i

Simulation.new(
  population_capacity: POPULATION_CAPACITY,
  initial_population: INITIAL_POPULATION,
  solution: SOLUTION,
  generations_to_display: GENERATIONS_TO_DISPLAY
  ).run_simulation
