class Hash

  def my_each(&prc)
    prc ||= Proc.new { |k,v| p v }
    k = 0
    
    while k < keys.length
      prc.call(keys[k], self[keys[k]])
      k += 1
    end
  end

end
