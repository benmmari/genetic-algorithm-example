require_relative 'gene'

class Chromosome

  attr_reader :genes

  def initialize(gene_capacity:, genes: nil)
      validate!(gene_capacity, genes)
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
    genes[position].mutate!
  end

  def gene_blueprint
    genes.map do |gene|
      r = gene.dup
    end
  end

  def gene_values
    genes.map do |gene|
      gene.value
    end
  end

  private

  def validate!(gene_capacity, genes)
    raise "Number of genes is greater than permitted size of #{gene_capacity}" if genes&.any? && genes.length != gene_capacity
  end
end
