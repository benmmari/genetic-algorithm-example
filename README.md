# genetic-algorithm-example

## Purpose
The purpose of this program is to illustrate the problem solving capabilities of genetic algorithms. By starting off with a set of random 'solutions' i.e organisms, the program will converge on the ideal solution after iterating through multiple generations. 

In each iteration the following takes place:
1. Sorting of the population by organism fitness (defined by the fitness calculation)
2. Killing off of half of the population, based on fitness ranking
3. Reproduction of the remaining organisms

   During reproduction each parent contributes half of it's chromosomes to the child.

   After the parents have contributed their chromosomes to the child, there will be a random mutation that takes place within the child organism which will replace one of the randomly selected genes with a gene from the possible set of genes.
  
## The Basics
An Organism is made up of a set of Chromosomes and a Chromosome is comprised of a number of Genes. In this program each Organism needs to have an even set of Chromosomes and each Chromosome is made up of one Gene. Currently the Gene population consists of the characters in the English Alphabet (i.e A,B,C...X,Y,Z). Thus the provided solution can be any even combination of letters. 

I.e "WE", "EVOLVE", "OVER", "MILLENIA"


## How To Run:

```
ruby main.rb {population capacity} {initial population size} {the solution} {no. of generations to print}
```

i.e 

```
ruby main.rb 100 8 AB 4
```

NB: The chromosome size of the organism needs to be an even number, so the length of the solution must be an even number

## Definitions  
P - population capacity - int - the maximum capacity of the population  
I - initial population size - int - how many organisms in the first generation  
S - the solution - string - the solution that will yield the maximum fitness  
N - no. of generations to print - int -  when the simulations comes to an end it will print the solution and it's family tree for N generations. Where N <= Generations taken to produce the solution


## Example Output

```
ruby main.rb 100 8 AB 4

Population: Size 8 : initial population
DE - 2
CQ - 2
PQ - 2
DY - 2
PY - 2
TG - 2
PR - 2
JA - 2

GENERATION #: 1
Population: Size 8

FITTEST ORGANISM: JA  2
Population: Size 4 : after the weakest pass on
Population: Size 10 : after mating

GENERATION #: 2
Population: Size 10

FITTEST ORGANISM: PR  2
Population: Size 5 : after the weakest pass on
Population: Size 15 : after mating

GENERATION #: 3
Population: Size 15

FITTEST ORGANISM: PB  1
Population: Size 8 : after the weakest pass on
Population: Size 36 : after mating

GENERATION #: 4
Population: Size 36

FITTEST ORGANISM: PB  1
Population: Size 18 : after the weakest pass on
Population: Size 100 : after mating

GENERATION #: 5
Population: Size 100

FITTEST ORGANISM: AB  0
Population: Size 50 : after the weakest pass on
Population: Size 100 : after mating

Generations that lead to fittest organism
G2 -  {CQ} {JA} {N/A} {N/A} {N/A} {N/A} {N/A} {N/A}
G3 -  {UQ} {PQ} {DY} {CQ}
G4 -  {PB} {CB}
G5 -  {AB}
```
