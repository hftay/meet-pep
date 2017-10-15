## GA Week 6:  
Project #2: Building Your First Full-stack Application  
Project timeframe: 3.5 days  

### Project objective:  
Primary: Build a full-stack database backed application using Sinatra.  
Secondary: Practise back-end aspect of programming, e.g. data-modeling and the use of object-relational models.  
**Link to app:** [Meet Pep](https://meet-pep.herokuapp.com/)

### The problem:
- lots of friction (e.g. scheduling, location, mixed games) in organising a social team sports that requires many people (e.g. >10) to participate. difficult for players to find games and vice versa, leading to missed opportunities.
- problem can be partially solved by signing up to a season-long league (e.g. via a sports club) however this is a commitment (e.g. weekly) which may not suit everyone. can be difficult to find replacement at moment's notice.
- keeping track of game stats is a laborious process (usually hand written / excel). this is more of a problem for the numbers/analytical-driven,

### The solution:
- Pep is a community platform for social sports! (similar to meetup.com but for sports). 
- Pep makes it possible to create a game on your terms and reach a wider audience than would be possible through word of mouth.
- Pep makes it easier to connect to sports based on your preferences e.g. timing, location, style of play (e.g. mixed games).
- Pep Stats (in development) allow players to create league tables and compile stats to track their performance. League leaderboards will help with creating friendly competitiveness / help track self-imposed performance targets.
Also comes with a team randomiser (in progress) to create fair teams based on existing stats. 

Functionalities:
- User should be able to view all available games (high level)
- User should be able to get a detailed view of a game (detailed)
- User should be able to RSVP to a game
- User should be able to create a game
- If User is Creator, should be able to edit game
- If User is Creator, should be able to delete game
- User should be able to view his/her upcoming games
- User should be able to create, edit, view and delete "league tables" tracking game statistics

Technical Requirement:
- App has at least 2 models
- sign up/log in functionality, with encrypted passwords & an authorization flow
- complete RESTful routes for at least one of your resources with GET, POST, PUT, PATCH, and DELETE
- Utilize SQL or an ORM to create a database table structure and interact with your relationally-stored data
- Be deployed online and accessible to the public

Tech used:
- HTML5, CSS3/Bootstrap
- Ruby ActiveRecord / Sinatra
- PostgresSQL
- RESTful routing
- Deployed via Heroku

Lessons learned:
- Dedicate time to the planning process, write pseudocode before writing actual code.
- Design wireframes and understand the information you want to present 
- Using the appropriate data model (drawing it out) will make your life much easier
- Creating events using time-input can be tricky with different timezones
- CSS grids and bootstrap is a quick and dirty way to get some basic CSS done 
