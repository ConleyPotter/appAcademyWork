PRAGMA foreign_keys = ON;
DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY, 
  fname VARCHAR(255) NOT NULL, 
  lname VARCHAR(255) NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY, 
  title VARCHAR(255) NOT NULL, 
  body TEXT NOT NULL,
  author INTEGER NOT NULL,

  FOREIGN KEY (author) REFERENCES users(id)
);

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY, 
  follower INTEGER,
  question INTEGER NOT NULL,

  FOREIGN KEY (follower) REFERENCES users(id),
  FOREIGN KEY (question) REFERENCES questions(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY, 
  subject_question INTEGER NOT NULL,
  parent_reply INTEGER,
  reply_author INTEGER NOT NULL, 
  reply_body TEXT NOT NULL,

  FOREIGN KEY (subject_question) REFERENCES questions(id),
  FOREIGN KEY (parent_reply) REFERENCES replies(id),
  FOREIGN KEY (reply_author) REFERENCES users(id)

);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  like_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (like_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  users(fname, lname)
VALUES
  ('Rexi', 'John'),
  ('Susi', 'Hum'),
  ('Conley', 'Potter'),
  ('Harry', 'Potter'),
  ('Peter', 'Hum'),
  ('Jasmine', 'John'),
  ('Carly', 'Schaaf'),
  ('Mashu', 'Duek');

INSERT INTO   
  questions(title, body, author)
VALUES
  ('Why doesn''t App Academy serve squirrels', 'Squirrels are a nutritious, stimulating meal for all dogs, I means students, to live on. App Academy is not serving the needs of ALL students by not serving squirrels.', 1),
  ('Why doesn''t App Academy hire dogs', 'Dogs are awesome and you should hire dogs as instructors...and feed them squirrels', 1),
  ('Why doesn''t App Academy accept dogs', 'Once again, I must remind you that dogs are awesome and would make excellent programmers. The field needs wayyyyyyyy more dogs.', 2);

INSERT INTO
  question_follows(follower, question)
VALUES
  (3, 1),
  (3, 2),
  (5, 1),
  (6, 2),
  (7, 1),
  (8, 1);

INSERT INTO
  replies(subject_question, parent_reply, reply_author, reply_body)
VALUES
  (3, NULL, 7, 'Although we agree that dogs are awesome, it is unfair to have dogs be accepted as students because they would make everyone else feel stupid.'),
  (3, 1, 8, 'Additionally, it would require us to accept butt sniffing as a appropriate form of greeting. Some of our human students would have issues would that.' ),
  (1, NULL, 8, 'Here at App Academy we do not serve regular meals to anyone regardless of their species.' );

INSERT INTO
  question_likes(like_id, question_id)
VALUES
  (1, 1),
  (1, 2),
  (1, 3),
  (2, 1),
  (2, 2),
  (2, 3),
  (3, 1),
  (3, 2),
  (3, 3),
  (5, 1),
  (5, 2),
  (5, 3),
  (6, 1),
  (6, 2),
  (6, 3),
  (7, 1),
  (7, 2),
  (8, 3);