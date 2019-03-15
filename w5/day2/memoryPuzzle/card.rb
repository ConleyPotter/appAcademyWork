class Card
    attr_reader :face_value, :hidden
    def initialize
        @face_value = ("A".."Z").to_a.sample
        @hidden = true
    end

    def hide
        @hidden = true
    end

    def reveal
        @hidden = false
    end

    def to_s
        @hidden ? (return " ") : (return @face_value)
    end

    def ==(val)
        @face_value == val
    end
end