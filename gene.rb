class Gene

    attr_accessor :value

    POSSIBILITIES = %w(a b c d e f g h i j k l m n o p q r s t u v w x y z)
    
    def initialize(value:nil, randomize: true)
        if randomize
            size = POSSIBILITIES.length
            @value = POSSIBILITIES[rand(size)].upcase
        else
            @value = value
        end
        raise 'value can not be null' if @value.nil?
    end

    def mutate
        size = POSSIBILITIES.length
        @value = POSSIBILITIES[rand(size)].upcase
	self
    end

    def display
        print @value
    end
end
