require './gene'

class Chromosome

attr_accessor :genes

    def initialize(gene_capacity:, genes: nil)
      raise 'Number of genes is greater than permitted size of #{gene_capacity}' if genes && genes.any? && genes.length > gene_capacity
        @gene_capacity = gene_capacity
        @genes = []
        if genes.nil?
            @gene_capacity.times {
                @genes << Gene.new
            }
        else
            @genes = genes
        end
    end

    def mutate_gene
        position = rand(@gene_capacity)
        mutated_gene = genes[position].mutate
        genes[position] = mutated_gene
    end

    def generate_blueprint
        genes.map do |gene|
            gene.dup
        end
    end

    def gene_values
        genes.map do |gene|
            gene.value
        end
    end
end
