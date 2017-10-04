GA Week 6:
Project #2: Building Your First Full-stack Application
Project Timeframe: 3 days

Objective: 
building a full-stack database backed application using Sinatra.

App summary:
Pep is a community marketplace for social sports! (similar to meetup.com but for sports)
Pep knows... Pep knows all the social sport events happening in your location, and is well-positioned to connect users to the events they are interested in!

Approach taken:
one of the objectives of this project is to practise the back-end aspect of programming, with less of a focus on the front-end. The emphasis of this project is to practise data-modeling and object-relational models
MVC framework.
Make MVP first, get to quantum of utility

Step 1: Design of Data model
- scoped out the schemas required 
- relational database
users table: id / username /email/ password_digest
games table: id / date / time / venue / image_url / created_at
game_type: id / type of sport
RSVP: id / user_id / games_id
comments: id / body / user_id / games_id
object relational model 

Step 2: Models:
- User
- Game
- Comment

Step 3: Views:
Drew out wireframe of the app
- Home
- Game 
- Login

Technical Requirement:
- App has at least 2 models
- sign up/log in functionality, with encrypted passwords & an authorization flow
- complete RESTful routes for at least one of your resources with GET, POST, PUT, PATCH, and DELETE
- Utilize SQL or an ORM to create a database table structure and interact with your relationally-stored data
- Be deployed online and accessible to the public


Unsolved problems:
- User should be able to view all available games (high level)
- User should be able to get a detailed view of a game (detailed)
- User should be able to RSVP to a game
- User should be able to create a game
- If User is Creator, should be able to edit game
- If User is Creator, should be able to delete game
- User should be able to view his/her upcoming games
- Add API weather, calendar, googlemaps
- Pep personality
	home= see pep's list, tell pep about your game, ask pep about your upcoming games, say bye 
- potential bot?
- annoying time zone conversion in edit page
- games are showing in UTC timezone, i want them to show in local time
