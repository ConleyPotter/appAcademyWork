class Stack
    def initialize
        # create ivar to store stack here!
        @stackADT = []
    end

    def push(el)
        # add an element to the stack
        stackADT.push
    end

    def pop
        # removes one element from the stack
        stackADT.pop
    end

    def peek
        # returns, but doesn't remove the top element in the stack
        stackADT.last
    end

    private
    
    attr_reader :stackADT
end