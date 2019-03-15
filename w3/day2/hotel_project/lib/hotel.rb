require_relative "room"

class Hotel
  def initialize(name, room_names)
    @name = name
    @rooms = Hash.new
    room_names.each do |key, val|
      @rooms[key] = Room.new(val)
    end
  end

  def name
    name_array = @name.split(" ")
    name_array = name_array.map { |el| el.capitalize }
    name_array.join(" ")
  end

  def rooms
    @rooms
  end

  def room_exists?(room_name)
    @rooms.has_key?(room_name)
  end

  def check_in(person, room_name)
    if self.room_exists?(room_name)
      if @rooms[room_name].add_occupant(person)
        p "check in successful"
      else
        p "sorry, room is full"
      end
    else
      p "sorry, room does not exist"
    end
  end
  
  def has_vacancy?
    if @rooms.all? { |key, val| @rooms[key].full? }
      false
    else
      true
    end
  end

  def list_rooms
    list = String.new
    @rooms.each do |key, val|
      list += "#{key}.*#{val.available_space}" + "\n" 
    end
    print list
  end
end
