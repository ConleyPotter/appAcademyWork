### Databases ###

# The Ruby objects you create during the lifetime of your program will die 
# when it closes. To save (or persist) data, you need to somehow write the 
# data to permanent storage, like the hard disk. We saw some of this in the 
# serialization chapter.

# Applications usually also require rich relationships between pieces of data. 
# Consider a blogging system: users have many posts, posts have many tags, 
# users may be following other users, and so on.

# Relational databases (also sometimes referred to as RDBMS, relational database 
# management systems) were developed to provide a means of organizing data and 
# their relationships, persisting that data, and querying that data.

### Tables ###

# Relational databases organize data in tables.

id	name	age
1	  John	 22
2	  James	 24
3	  Sally	 54
4	  Bob	   48
5	  Lucy	 33
6	  Mary	 98

# Each row is a single entity in the table. Each column houses an additional 
# piece of data for that entity.

# Every row in a database table will have a primary key which will be its 
# unique identifier in that table row. By convention, the primary key is simply 
# id. Most relational database systems have an auto-increment feature to ensure 
# that the primary keys are always unique.

# Breaking your domain down into database tables & columns is an important 
# part of developing any application. Each table will house one type of 
# resource: people, houses, blog_posts, etc. The columns in the table will 
# house the data associated with each instance of the resource.

### Database Schemas ###
Your database schema is a description of the organization of your database into tables and columns.

Designing your schema is one of the first and most important steps when writing an application. It forces you to ask a basic but essential question: what data does my application need to function?

When implementing a database schema, you must decide on three things:

the tables you will have
the columns each of those tables will have
and the data type of each of those columns
Schemas are mutable, so the decisions up front are not at all set in stone. Still, you should spend time thinking about your schema at the outset to avoid making major, avoidable mistakes.

The concept of static typing may be new to you. Ruby is dynamically typed -- there is no need to specify in method parameters or variables the class (also called type) of the data stored in it. Ruby won't stop you even if you store something silly like a Cat object in a variable named favorite_dog, or a String in a variable named number.

SQL is not quite so flexible; you must specify the type of data that will go into each column.

Here are a few of the most common datatypes:

BOOLEAN

INT
FLOAT (stores "floating point" numbers)
VARCHAR(255) (essentialy a string with a length limit of 255 chars)
TEXT (a string of unlimited length)
DATE
DATETIME
TIME
BLOB (non-textual, binary data; e.g., an image)
We'll see how exactly we create tables, include columns, and specify column types in just a bit.


