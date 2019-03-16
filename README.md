# Genetic Algorithm Example

## Purpose
The purpose of this program is to illustrate the problem solving capabilities of genetic algorithms. By starting off with a set of random 'solutions' i.e organisms, the program will converge on the ideal solution after iterating through multiple generations. 

In each iteration the following takes place:
1. Sorting of the population by organism fitness (defined by the fitness calculation)
2. Killing off of half of the population, based on fitness ranking
3. Reproduction of the remaining organisms

   During reproduction each parent contributes half of it's chromosomes to the child.

   After the parents have contributed their chromosomes to the child, there will be a random mutation that takes place within the child organism which will replace one of the randomly selected genes with a gene from the possible set of genes.
  
## The Basics
An Organism is made up of a set of Chromosomes and a Chromosome is comprised of a number of Genes. In this program each Organism needs to have an even set of Chromosomes and each Chromosome is made up of one Gene. Currently the Gene population consists of the 26 letters in the English Alphabet as well as the underscore (i.e A,B,C...X,Y,Z,_). Thus the provided solution can be any even combination of these characters. 

I.e "\_WE\_", "EVOLVE", "OVER", "MILLENIA"


## How To Run:

```
ruby main.rb {population capacity} {initial population size} {the solution} {no. of generations to print}
```

i.e 

```
ruby main.rb 100 9 THIS_TEXT_IS__RANDOM 4
```

NB: The chromosome size of the organism needs to be an even number, so the length of the solution must be an even number

## Definitions  
P - population capacity - int - the maximum capacity of the population.  
I - initial population size - int - how many organisms in the first generation.  
S - the solution - string - an ordered combination of genes.  
N - no. of generations to print - int -  when the simulations comes to an end it will print the solution and it's family tree for N generations. Where N <= Generations taken to produce the solution.


## Example Output 
* A few lines of the output have been intentionally ommited

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
