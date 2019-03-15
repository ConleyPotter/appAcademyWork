class Queue
    def initialize
        @queueADT = []
    end

    def enqueue(el)
        queueADT.push(el)
    end

    def dequeue
        queueADT.shift
    end

    def peek
        queueADT.first
    end
    
    private
    
    attr_reader :queueADT
end

