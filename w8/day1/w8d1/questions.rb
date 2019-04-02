require 'sqlite3'
require 'singleton'
require 'byebug'

class QuestionsDBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Question
  attr_accessor :id, :title, :body, :author_id

  def self.all
    data = QuestionsDBConnection.instance.execute("SELECT * FROM questions")
    data.map { |datum| Question.new(datum) }
  end

  def self.find_by_id(id)
    raise "#{id} not found in database" unless Question.all.any? { |question| question.id == id }
    question = QuestionsDBConnection.instance.execute(<<-SQL, id)
    SELECT * FROM questions WHERE id = ?
    SQL
    Question.new(question.first)
  end
  
  def self.find_by_author_id(author_id)
    raise "#{author_id} not found in database" unless User.all.any? { |user| user.id == author_id }
    questions = QuestionsDBConnection.instance.execute(<<-SQL, author_id)
    SELECT * FROM questions WHERE author = ?
    SQL
    questions.map { |question| Question.new(question) }
  end
  
  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author']
  end

  def replies
    Reply.find_by_question_id(self.id)
  end

  def author
    User.find_by_id(self.author_id)
  end
  
  def followers
    QuestionFollow.followers_for_question_id(self.id)
  end
  
end

class User
  attr_accessor :id, :fname, :lname
  def self.all
    data = QuestionsDBConnection.instance.execute("SELECT * FROM users")
    data.map { |datum| User.new(datum) }
  end
  
  def self.find_by_id(id)
    raise "#{id} not found in database" unless User.all.any? { |user| user.id == id }
    user = QuestionsDBConnection.instance.execute(<<-SQL, id)
    SELECT * FROM users WHERE id = ?
    SQL
    User.new(user.first)
  end
  
  def self.find_by_name(fname, lname)
    raise "#{fname} #{lname} not found in database" unless User.all.any? { |user| user.fname == fname && user.lname == lname }
    user = QuestionsDBConnection.instance.execute(<<-SQL, fname, lname)
    SELECT * FROM users WHERE fname = ? AND lname = ?
    SQL
    User.new(user.first) 
  end
  
  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def authored_questions
    Question.find_by_author_id
  end
  
  def authored_replies
    Reply.find_by_user_id
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(self.id)
  end
end

class QuestionFollow
  attr_accessor :id, :follower, :question
  def self.all
    data = QuestionsDBConnection.instance.execute("SELECT * FROM question_follows")
    data.map { |datum| QuestionFollow.new(datum) }
  end
  
  def self.find_by_id(id)
    raise "#{id} not found in database" unless QuestionFollow.all.any? { |questionfollow| questionfollow.id == id }
    questionfollow = QuestionsDBConnection.instance.execute(<<-SQL, id)
    SELECT * FROM question_follows WHERE id = ?
    SQL
    QuestionFollow.new(questionfollow.first)
  end

  def self.followers_for_question_id(question_id)
    followers = QuestionsDBConnection.instance.execute(<<-SQL, question_id)
    SELECT * FROM users JOIN question_follows ON users.id = question_follows.follower WHERE question = ?
    SQL
    followers.map { |follower| User.find_by_id(follower['id']) }
  end
  
  def self.followed_questions_for_user_id(user_id)
    questions = QuestionsDBConnection.instance.execute(<<-SQL, user_id)
    SELECT question FROM question_follows JOIN users ON users.id = question_follows.follower WHERE follower = ?
    SQL
    questions.map { |question| Question.find_by_id(question['question']) }
  end

  def initialize(options)
    @id = options['id']
    @follower = options['follower']
    @question = options['question']
  end
  
end

class Reply
  attr_accessor :id, :subject_question, :parent_reply, :reply_author, :reply_body
  def self.all
    data = QuestionsDBConnection.instance.execute("SELECT * FROM replies")
    data.map { |datum| Reply.new(datum) }
  end
  
  def self.find_by_id(id)
    raise "Reply #{id} not found in database" unless Reply.all.any? { |reply| reply.id == id }
    reply = QuestionsDBConnection.instance.execute(<<-SQL, id)
    SELECT * FROM replies WHERE id = ?
    SQL
    Reply.new(reply.first)
  end
  
  def self.find_by_user_id(user_id)
    raise "User #{user_id} not found in database" unless Reply.all.any? { |reply| reply.reply_author == user_id }
    replies = QuestionsDBConnection.instance.execute(<<-SQL, user_id)
    SELECT * FROM replies WHERE reply_author = ?
    SQL
    replies.map { |reply| Reply.new(reply) }
  end
  
  def self.find_by_question_id(question_id)
    raise "Question #{question_id} not found in database" unless Reply.all.any? { |reply| reply.subject_question == question_id }
    replies = QuestionsDBConnection.instance.execute(<<-SQL, question_id)
    SELECT * FROM replies WHERE subject_question = ?
    SQL
    replies.map { |reply| Reply.new(reply) }
  end

  def initialize(options)
    @id = options['id']
    @subject_question = options['subject_question']
    @parent_reply = options['parent_reply']
    @reply_author = options['reply_author']
    @reply_body = options['reply_body']
  end
  
  def author
    User.find_by_id(self.reply_author)
  end

  def question
    Question.find_by_id(self.subject_question)
  end

  def parent_reply
    Reply.find_by_id(@parent_reply) #use @ instead of self b/c it will call recursively otherwise. This can be avoided by naming attribute parent_reply_id instead
  end

  def child_replies
    children = QuestionsDBConnection.instance.execute(<<-SQL, self.id)
    SELECT * FROM replies WHERE parent_reply = ?
    SQL
    children.map { |child| Reply.new(child) }
  end
  
end

class QuestionLike
  attr_accessor :id, :like_id, :question_id
  def self.all
    data = QuestionsDBConnection.instance.execute("SELECT * FROM question_likes")
    data.map { |datum| QuestionLike.new(datum) }
  end
  
  def self.find_by_id(id)
    raise "#{id} not found in database" unless QuestionLike.all.any? { |questionlike| questionlike.id == id }
    questionlike = QuestionsDBConnection.instance.execute(<<-SQL, id)
    SELECT * FROM question_likes WHERE id = ?
    SQL
    QuestionLike.new(questionlike.first)
  end

  def initialize(options)
    @id = options['id']
    @like_id = options['like_id']
    @question_id = options['question_id']
  end
end
