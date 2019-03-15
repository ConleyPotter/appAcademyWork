# As you develop and debug your programs, often times you'll find it useful
# to test ideas in a "sandbox" environment where you can get quick feedback on 
# the state of your code. We'll use a Ruby REPL to this end. To review, REPL
# stands for Read, EValuate, Print, Loop. 

# At App Academy, our Ruby REPL of choice is Pry. Pry is an open source project
# developed as an alternative to IRB, the standard Ruby REPL. Pry is a much more
# powerful tool that allows for more efficient and effective debugging. Because
# of this, we'll prefer Pry over the standard REPL.

### Using Pry ###

# You can begin a pry session by simply using the command pry in your cmd line.
# You'll be greetd by a seemingly unassuming REPL:

# $ pry
# [1] pry(main)> 

# Like any REPL, you can type Ruby code line by bline to test ideas on the fly. 
# Every line you write will have it's evaluation displayed with =>:

[1] pry(main)> greens = ["kale", "spinach", "arugula"]
=> ["kale", "spinach", "arugula"]
[2] pry(main)> greens << "broccoli"
=> ["kale", "spinach", "arugula", "broccoli"]
[3] pry(main)> greens.length
=> 4

# You could even copy and paste multiple lines of code into a pry session. That's
# nothing groundbreaking, but what advanced tools does pry offer us?

### ls ###

# We can use ls to list method that we can use in a given context. For example, 
# let's say we wanted to know what methods we ahve available to use on strings by
# entering ls String in Pry:

[1] pry(main)> ls String
String.methods: try_convert
String#methods:
  %            capitalize   delete!                end_with?          ljust         rpartition   strip      tr!                
  *            capitalize!  delete_prefix          eql?               lstrip        rstrip       strip!     tr_s               
  +            casecmp      delete_prefix!         force_encoding     lstrip!       rstrip!      sub        tr_s!              
  +@           casecmp?     delete_suffix          freeze             match         scan         sub!       undump             
  -@           center       delete_suffix!         getbyte            match?        scrub        succ       unicode_normalize  
  <<           chars        downcase               grapheme_clusters  next          scrub!       succ!      unicode_normalize!
  <=>          chomp        downcase!              gsub               next!         setbyte      sum        unicode_normalized?
  ==           chomp!       dump                   gsub!              oct           shell_split  swapcase   unpack             
  ===          chop         each_byte              hash               ord           shellescape  swapcase!  unpack1            
  =~           chop!        each_char              hex                partition     shellsplit   to_c       upcase             
  []           chr          each_codepoint         include?           prepend       size         to_f       upcase!            
  []=          clear        each_grapheme_cluster  index              pretty_print  slice        to_i       upto               
  ascii_only?  codepoints   each_line              insert             replace       slice!       to_r       valid_encoding?    
  b            concat       empty?                 inspect            reverse       split        to_s     
  bytes        count        encode                 intern             reverse!      squeeze      to_str   
  bytesize     crypt        encode!                length             rindex        squeeze!     to_sym   
  byteslice    delete       encoding               lines              rjust         start_with?  tr      

# Whoa! There are tons of methods that we haven't even learned. Don't be
# intimidated, documentation isi your friend. From this point you can search
# the Ruby Docs in your web browswer to gain more insight in the functionality
# of a method you are unfamiliar with. You can even use Pry to get a summary
# of a method's documentation. Let's see that next.

### show-doc ###

# We can use show-dc to show a documentation summary for a given method. For
# example, if we want to learn more about the end_with? method from the example
# above, we can use the pry command show-doc String#end_with?. We'll need
# to follow this # notations closely as the output from ls suggests.

[2] pry(main)> show-doc String#end_with?

From: string.c (C Method):
Owner: String
Visibility: public
Signature: end_with?(*arg1)
Number of lines: 7

Returns true if str ends with one of the suffixes given.

  "hello".end_with?("ello")               #=> true

  # returns true if one of the suffixes matches.
  "hello".end_with?("heaven", "ello")     #=> true
  "hello".end_with?("heaven", "paradise") #=> false

# some of the inital verbiag won't be particuliarly useful to use at this point, but
# looking at the latter synopsis and examples provided, we can get a really good
# idea of how one could use this method. If you still can't gather the usage
# of a method, then you should view the full documentation article in the Ruby
# Docs in your web broswer.

### load ###

# This is not a Pry specific command, but you'll find it useful nonetheless
# when you want to bring an entire files worth of Ruby code into your
# Pry session. If we begin a Pry session in the same folder where we have a .rb
# file. We can load the entire file into Pry and begin playing with it. 

# Let's say our command line is located in my_ruby_code/ and there is a code.rb
# file within that we want to load into pry. Our folder struture is set up like so:

# my_ruby_code/
# |--code.rb

# Then we can load the fine into pry:

~/Desktop/my_ruby_code$ ls
code.rb

~/Desktop/my_ruby_code$ cat code.rb
def is_prime?(num)
  (2...num).each do |factor|
    return false if num % factor == 0
  end

  num > 1
end

~/Desktop/my_ruby_code$ pry
[1] pry(main)> load "code.rb"
=> true
[2] pry(main)> is_prime?(16)
=> false
[3] pry(main)> is_prime?(7)
=> true
[4] pry(main)>

### show-source ###

# If we want to see the code that implements a method, we call this the source
# code, we can use the show-source method. Let's say we previously copy and 
# pasted a definition for is_prime? into our Pry session, then we could
# view the original source using show-source is_prime?:

[5] pry(main)> show-source is_prime?

From: (pry) @ line 1:
Owner: Object
Visibility: public
Number of lines: 7

def is_prime?(num)
  (2...num).each do |factor|
    return false if num % factor == 0
  end

  num > 1
end

# You'll find the few commands aove the most useful as you code, so you should
# focus on this handful of commands for now. However, there si much more we can
# do with Pry; feel free to read about it in the Pry Github #{https://github.com/pry/pry/blob/master/README.md}
