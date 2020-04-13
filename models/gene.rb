class Gene

  attr_reader :value

  POSSIBILITIES = %w(a b c d e f g h i j k l m n o p q r s t u v w x y z _)

  def initialize(value: nil)
    @size = POSSIBILITIES.length
    if value.nil?
      @value = POSSIBILITIES[rand(@size)].upcase
    else
      @value = value
    end
    raise 'value not in the gene pool' unless POSSIBILITIES.include? @value.downcase
  end

  def mutate!
    @value = POSSIBILITIES[rand(@size)].upcase
    self
  end
end
