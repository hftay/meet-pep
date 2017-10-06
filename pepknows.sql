
CREATE TABLE users (
	id SERIAL4 PRIMARY KEY,
	username VARCHAR (50),
	email VARCHAR (200),
	password_digest VARCHAR(400)
); # in hindsight, would have been good to capture phone num (optional) and user location (for working out nearest games), created_at etc 

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

-- Rsvp belong to users and game. rsvp.game
CREATE TABLE rsvps (
	id SERIAL4 PRIMARY KEY,
	user_id INTEGER,
	game_id INTEGER
);

-- leagues belong to User
CREATE TABLE leagues (
	id SERIAL4 PRIMARY KEY,
	title VARCHAR (200) NOT NULL,
	user_id INTEGER
);

-- leaguestats belong to League. leaguestats.league
CREATE TABLE leaguestats (
	id SERIAL4 PRIMARY KEY,
	league_id INTEGER,
	user_id INTEGER,
	goals INTEGER,
	assists INTEGER,
	games_won INTEGER
);

INSERT INTO games (title, venue, user_id) VALUES ('Monday Night Football', 'Albert Park', 1);

INSERT INTO users (username, email) VALUES ('dt50', 'dt@ga.co');
# user passwords: 'pudding'

INSERT INTO rsvps (game_id, user_id) VALUES (1,1);


