class Map
    def initialize
        @mapADT = []
    end

    def set(key, value)
        @mapADT.each do |pair|
            if pair.include?(key)
                pair[1] = value 
                return [key, value]
            end
        end
        @mapADT.push([key, value])
        value
    end

    def get(key)
        @mapADT.each do |pair|
            return pair[1] if pair.include?(key)
        end
        nil
    end

    def delete(key)
        to_delete = nil
        @mapADT.each_with_index do |pair, idx|
            to_delete = idx if pair.include?(key)
        end
        @mapADT.delete_at(to_delete)
        key
    end

    def show
        to_show = {}
        @mapADT.each do |pair|
            to_show[pair[0]] = pair[1]
        end
        to_show
    end
end