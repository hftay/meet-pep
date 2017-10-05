
CREATE TABLE users (
	id SERIAL4 PRIMARY KEY,
	username VARCHAR (50),
	email VARCHAR (200),
	password_digest VARCHAR(400)
);

CREATE TABLE games (
	id SERIAL4 PRIMARY KEY,
	title VARCHAR (200),
	date TIMESTAMP without time zone,
	description VARCHAR (5000),
	venue VARCHAR (400),
	image_url VARCHAR(400),
	user_id INTEGER,
	created_at TIMESTAMP 
);
-- ALTER TABLE games ALTER date TYPE timestamp WITH time zone;

CREATE TABLE rsvps (
	id SERIAL4 PRIMARY KEY,
	user_id INTEGER,
	game_id INTEGER
);

CREATE TABLE stats (
	id SERIAL4 PRIMARY KEY,
	title VARCHAR (200),
	user_id INTEGER,
	user_username VARCHAR (50),
	goals INTEGER,
	assists INTEGER,
	games_won INTEGER
);

CREATE TABLE game_types (
	id SERIAL4 PRIMARY KEY,
	game_id INTEGER,
	type VARCHAR(200)
);


-- comments: id / body / user_id / games_id

INSERT INTO games (title, venue, user_id) VALUES ('Monday Night Football', 'Albert Park', 1);

INSERT INTO users (username, email) VALUES ('dt50', 'dt@ga.co');
INSERT INTO users (username, email) VALUES ('bernie', 'bernie@unimelb.edu.au');
INSERT INTO users (username, email) VALUES ('ozil10', 'ozil@gmail.com');
INSERT INTO users (username, email) VALUES ('alexis7', 'alexis@gmail.com');
INSERT INTO users (username, email) VALUES ('petr1', 'petr@gmail.com');
# user passwords: 'pudding'

INSERT INTO rsvps (game_id, user_id) VALUES (1,1);
