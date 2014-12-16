-- League Standings
select team_name as 'Team', sum(game_points) as 'Total Points'
from squad, playsin, fixture, fantasyteam
where squad.game_week = fixture.game_week
and fixture.fixture_id = playsin.fixture_id
and squad.player_id = playsin.player_id
and squad.team_id = fantasyteam.team_id
and in_first_team = true
group by team_name
order by sum(game_points) desc;


-- get team points for every game week
select team_name as 'Team', squad.game_week as 'Game Week', sum(game_points) as 'Week Points'
from squad, playsin, fixture, fantasyteam
where squad.team_id = 't001' 
and squad.game_week = fixture.game_week
and fixture.fixture_id = playsin.fixture_id
and squad.player_id = playsin.player_id
and squad.team_id = fantasyteam.team_id
and in_first_team = true
group by squad.game_week;


-- what player has the most game_points
select T.First_name, T.Last_name, max(T.max_gamepoints) as Points
from (select playsIn.player_id, sum(game_points) as max_gamepoints, first_name, last_name
from playsIn, player
where playsIn.player_id = player.player_id
group by playsIn.player_id
order by sum(game_points)desc)T;


-- what player has the most game_points in an individual position
select T.First_name, T.Last_name, max(T.max_gamepoints) as Points, T.Position
from (select playsIn.player_id, sum(game_points) as max_gamepoints, first_name, last_name, position
from playsIn, player
where playsIn.player_id = player.player_id and position = 'midfielder'
group by playsIn.player_id
order by sum(game_points)desc)T;


-- show full squad for Ciaran Team 1
select distinct squad.player_id, squad.team_id, team_name, first_name, last_name, position
from squad, fantasyTeam, player
where squad.team_id = fantasyTeam.team_id and squad.player_id = player.player_id
and team_name like '%ciaran team 1%';


-- individual player form over each game week
select first_name as 'First Name', last_name as 'Last Name',
squad.game_week as 'Game Week', game_points as 'Week Points'
from squad, playsIn, fixture, player
where first_name = 'Juan' and last_name = 'Mata'
and squad.game_week = fixture.game_week
and fixture.fixture_id = playsIn.fixture_id
and player.player_id = playsIn.player_id
group by squad.game_week;


-- display total overall top points scorers by position
select playsIn.player_id, first_name, last_name, player.club_name, sum(game_points) as 'Total Points'
from playsIn, player
where playsIn.player_id = player.player_id and position = 'midfielder'
group by playsIn.player_id
order by sum(game_points)desc;


-- display the number of players who represent thier country nationally 
-- who play in the Premier League, ordered by descending
select ifnull(national_team, 'Has not represented country') as 'National Team', 
count(Distinct player_id) as 'Number of players'
from player
group by national_team
order by count(Distinct player_id) desc;


-- Get player name and game week where a player has earned 10 points or more
select game_points, game_week, first_name, last_name from playsIn natural join player, fixture
where game_points >=10 and playsin.player_id = player.player_id and playsin.fixture_id = fixture.fixture_id
order by game_points desc;

-- Get players who have played internationally for a Country other than their Country of birth
select first_name, last_name, country_of_birth, national_team from player 
where country_of_birth != national_team and national_team != 'NULL';


-- get team points for any game week
select team_name as 'Team', squad.game_week as 'Game Week', sum(game_points) as 'Total Points'
from squad, playsin, fixture, fantasyteam
where squad.team_id = 't001' 
and squad.game_week = 'g08'
and squad.game_week = fixture.game_week
and fixture.fixture_id = playsin.fixture_id
and squad.player_id = playsin.player_id
and squad.team_id = fantasyteam.team_id
and in_first_team = true;


-- display all countries which are represented by birth in the Premier league
select distinct country_of_birth
from player;

-- display national teams represented in the Premier League
select distinct national_team
from player;

-- find the number of English players by birth who play in the Premier League
select count(Distinct player_id) as 'Players Born In England'
from player
where country_of_birth = "England";

-- find the number of Irish players by birth who play in the Premier League
select count(Distinct player_id) as 'Players Born In Ireland'
from player
where country_of_birth = "Rep. of Ireland";

-- find the number of Northern Irish player by birth who play in the Premier League
select count(Distinct player_id) as 'Players Born In Northern Ireland'
from player
where country_of_birth = "Northern Ireland";


-- display the number of players born in each country who play in the Premier League
select country_of_birth, count(Distinct player_id)
from player
group by country_of_birth;


-- display the number of players born in each country
-- who play in the Premier League, ordered by descending
select ifnull(country_of_birth, 'not assigned') as 'Country of birth', 
count(Distinct player_id) as 'Number of players'
from player
group by country_of_birth
order by count(Distinct player_id) desc;

-- display weekly fixtures
select homeTeam.club_name as 'Home Club',
awayTeam.club_name as 'Away Team',
game_week as 'Game Week',
venue
from fixture, homeTeam, awayTeam
where fixture.fixture_id = homeTeam.fixture_id and fixture.fixture_id = awayTeam.fixture_id and game_week = "g01";


-- display weekly results
select homeTeam.club_name as 'Home Club', 
homeTeam.goals as 'Goal',
awayTeam.club_name as 'Away Team', 
awayTeam.goals as 'Goal',
game_week as 'Game Week', 
venue
from fixture, homeTeam, awayTeam
where fixture.fixture_id = homeTeam.fixture_id and fixture.fixture_id = awayTeam.fixture_id and game_week = "g01";

-- what team has selected juan mata
select team_name, user_id from fantasyTeam
where team_id in
(select team_id from squad
where player_id in
(select player_id from squad
where player_id in
(select player_id from player
where player_id = '0262')));

-- what team has selected a player with first_name = wayne
select team_name, user_id from fantasyTeam
where team_id in
(select team_id from squad
where player_id in
(select player_id from squad
where player_id in
(select player_id from player
where first_name in
(select first_name from player
where first_name like '%wayne%'))));


-- who manages aaron ramsey
select distinct first_name, last_name, club_manager
from player, club
where player.club_name = club.club_name
and first_name = 'aaron' and last_name = 'ramsey';

-- individual player total score
select playsIn.player_id, sum(game_points), first_name, last_name
from playsIn, player
where playsIn.player_id = player.player_id
and playsIn.player_id = '0018';

-- only players selected Fantasy team
SELECT DISTINCT player.player_id, first_name, last_name, club_name, position
FROM player, playsin, squad 
WHERE player.player_id = playsin.player_id AND playsin.player_id = squad.player_id ORDER BY position;

-- select the youngest player overall
SELECT * 
FROM player
WHERE d_o_b = (SELECT max(d_o_b) FROM player);

 -- select the oldest from a certain team
SELECT * 
FROM player
WHERE d_o_b = (SELECT min(d_o_b) FROM player WHERE club_name LIKE "Chelsea");

-- multiple teams per personUser
SELECT DISTINCT p1.email, p1.first_name 
FROM user as p1, user AS p2 where p1.first_name = p2.first_name and p1.email <> p2.email ORDER BY email;







