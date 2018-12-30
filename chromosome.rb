require './gene'

class Chromosome

attr_accessor :genes

    def initialize(size:, genes: nil, randomize: false)
        @size = size
        if randomize
            @genes = []
            @size.times {
                @genes << Gene.new
            }
        else
            @genes = genes
            mutate_gene
        end

        raise 'Chromosome size is greater than permitted size of #{@size}' if @genes.length > @size
    end

    def mutate_gene
        position = rand(@size)
        mutated_gene = @genes[position].mutate
        @genes[position] = mutated_gene
    end

    def display
        @genes.each do |gene|
            gene.display
        end
    end
end
