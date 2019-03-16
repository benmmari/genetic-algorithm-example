# Genetic Algorithm Example

## Purpose
The purpose of this program is to illustrate the problem solving capabilities of genetic algorithms. The program will start off with a list of randomly generated 'solutions' i.e organisms, then it will continuously iterate through progressive generations, only stopping when the fittest organism has reached the global maximum. In order to determine the fitness of an organism, the program compares the organisms ordered gene output to the provided solution. The organisms themselves do not know what the solution is, they are just guided by selective pressure over many generations. 

## The Basics
An Organism is made up of a group of Chromosomes and a Chromosome is comprised of a number of Genes. In the current version of the program each Organism is made up of an even number of Chromosomes and each Chromosome is made up of one Gene. A Gene can be value from a set of characters that consists of the 26 letters in the English Alphabet as well as the underscore character (i.e [ A,B,C...X,Y,Z,\_ ]). The provided solution must be any even combination of these characters. 

I.e "\_WE\_", "EVOLVE", "OVER", "MILLENIA"

## The Algorithm

In each iteration of the algorithm the following takes place (after the initial population has been created):
1. Sorting of the population by organism fitness
2. Culling the lower half the population
3. Reproduction of the remaining organisms

   During reproduction, each parent contributes half of it's chromosomes to the child.

   After the parents have contributed their chromosomes to the child, there will be a random mutation that takes place within the child organism, which will replace one of the randomly selected genes with a gene from the possible set of genes.
  
## Definitions  
population capacity - integer - the maximum capacity of the population.  
initial population size - integer - how many organisms in the first generation.  
the solution - string - an ordered combination of genes.  
no. of generations to print - integer -  when the simulation comes to an end it will print out the family tree of the solution for N generations.


## How To Run:

```
ruby main.rb {population capacity} {initial population size} {the solution} {no. of generations to print}
```

i.e 

```
ruby main.rb 100 9 THIS_TEXT_IS__RANDOM 4
```

NB: The chromosome size of the organism needs to be an even number, so there must be an even number of characters in the solution.

## Example Output 
* Some of the output below has been intentionally ommited (G7 to G69), for the sake of brevity

```
genetic-algorithm-example git:(master)✗ ruby main.rb 100 9 THIS_TEXT_IS__RANDOM 4

Population: Size 9 : initial population
TVIV_YRMOQDVAYGAAOEL - 4
VYISDNERMEWLNOVPOTCI - 3
TVOEQWQAGFRNERGPMPBC - 1
SIFXAYPB_USCGHLRNULY - 1
AVNFUAGXENMVFPZHSWEZ - 1
BWVIFMEYGVVHUILIBIVV - 1
GMGPFQZM_DLQJVMBAQID - 0
IM_HGFYGYPWCALKXCCXQ - 0
LNNRMBPGHULITLFIRBEZ - 0

------------------------------------
GENERATION #: 1
Population: Size 9

FITTEST ORGANISM: TVIV_YRMOQDVAYGAAOEL  4
Population: Size 5 : after the weakest pass on
Population: Size 15 : after mating

------------------------------------
GENERATION #: 2
Population: Size 15

FITTEST ORGANISM: TVIV_YRMOQDVAYGAAOEL  4
Population: Size 8 : after the weakest pass on
Population: Size 36 : after mating

------------------------------------
GENERATION #: 3
Population: Size 36

FITTEST ORGANISM: TVIV_YRMOQDVAYGAAOEL  4
Population: Size 18 : after the weakest pass on
Population: Size 100 : after mating

------------------------------------
GENERATION #: 4
Population: Size 100

FITTEST ORGANISM: SEISDNERMESCGHLRNULY  4
Population: Size 50 : after the weakest pass on
Population: Size 100 : after mating

------------------------------------
GENERATION #: 5
Population: Size 100

FITTEST ORGANISM: TVIV_YRMOBSCGHLRNUOY  5
Population: Size 50 : after the weakest pass on
Population: Size 100 : after mating

------------------------------------
GENERATION #: 6
Population: Size 100

FITTEST ORGANISM: TVIV_YRMOBSCGHLRNUOY  5
Population: Size 50 : after the weakest pass on
Population: Size 100 : after mating

...
...
...
...
...

------------------------------------
GENERATION #: 70
Population: Size 100

FITTEST ORGANISM: THIS_TEXT_IS__RVNDOM  19
Population: Size 50 : after the weakest pass on
Population: Size 100 : after mating

------------------------------------
GENERATION #: 71
Population: Size 100

FITTEST ORGANISM: THIS_TEXT_IS__RVNDOM  19
Population: Size 50 : after the weakest pass on
Population: Size 100 : after mating

------------------------------------
GENERATION #: 72
Population: Size 100

FITTEST ORGANISM: THIS_TEXT_IS__RVNDOM  19
Population: Size 50 : after the weakest pass on
Population: Size 100 : after mating

------------------------------------
GENERATION #: 73
Population: Size 100

FITTEST ORGANISM: THIS_TEXT_IS__RVNDOM  19
Population: Size 50 : after the weakest pass on
Population: Size 100 : after mating

------------------------------------
GENERATION #: 74
Population: Size 100

FITTEST ORGANISM: THIS_TEXT_IS__RANWOM  19
Population: Size 50 : after the weakest pass on
Population: Size 100 : after mating

------------------------------------
GENERATION #: 75
Population: Size 100

FITTEST ORGANISM: THIS_TEXT_IS__RANWOM  19
Population: Size 50 : after the weakest pass on
Population: Size 100 : after mating

------------------------------------
GENERATION #: 76
Population: Size 100

FITTEST ORGANISM: THIS_TEXT_IS__RVNDOM  19
Population: Size 50 : after the weakest pass on
Population: Size 100 : after mating

------------------------------------
GENERATION #: 77
Population: Size 100

FITTEST ORGANISM: THIS_TEXT_IS__RANDOM  20
Population: Size 50 : after the weakest pass on
Population: Size 100 : after mating

Generations that lead to fittest organism
G74 -  {THIS_TEXT_ISL_RANQOM} {THIS_TEXT_IS__RVNDOM} {THIS_TEIT_IS__RVNDIM} {THIS_TEXT_IS__RVNDDM} {THIS_TEXT_IS__RVNDIM} {THIS_TEXT_ISJ_RANUOM} {THIS_TEXT_IS__RKNDDM} {THIS_TEXT_ISJ_RANWOM}
G75 -  {THIS_TEXT_ISL_RANDOM} {THIS_TEXT_IS__RVNDOM} {THIS_TEIT_IS__RVNDIM} {THIS_TEXT_IS__RVNDDM}
G76 -  {THIS_TEMT_ISL_RANDOM} {THIS_TEXT_IS__RVNDOM}
G77 -  {THIS_TEXT_IS__RANDOM}
```
