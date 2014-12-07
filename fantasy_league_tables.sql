DROP TABLE IF EXISTS awayTeam;
DROP TABLE IF EXISTS homeTeam;
DROP TABLE IF EXISTS playsIn;
DROP TABLE IF EXISTS squad;
DROP TABLE IF EXISTS fantasyTeamLeague;
DROP TABLE IF EXISTS fixture;
DROP TABLE IF EXISTS fantasyLeague;
DROP TABLE IF EXISTS fantasyTeam;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS player;
DROP TABLE IF EXISTS club;

CREATE TABLE user (
  user_id VARCHAR (15) NOT NULL,
  first_name VARCHAR (20) NULL,
  last_name VARCHAR (20) NULL,
  email VARCHAR (40) NULL,
  PRIMARY KEY (user_id),
  INDEX (user_id)
);

CREATE TABLE fantasyLeague (
  league_id VARCHAR (15) NOT NULL,
  league_name VARCHAR (40) NULL,
  PRIMARY KEY (league_id),
  INDEX (league_id)
);

CREATE TABLE club (
  club_id VARCHAR (15) NOT NULL,
  club_name VARCHAR (30) NULL,
  club_manager VARCHAR (40) NULL,
  club_ground VARCHAR (30) NULL,
  PRIMARY KEY (club_id),
  INDEX (club_id)
);

CREATE TABLE fixture (
  fixture_id VARCHAR (15) NOT NULL,
  game_week VARCHAR (5) NOT NULL,
  PRIMARY KEY (fixture_id),
  INDEX (fixture_id)
);

CREATE TABLE player (
  player_id VARCHAR (15) NOT NULL,
  first_name VARCHAR (20) NULL,
  last_name VARCHAR (20) NULL,
  position VARCHAR (15) NULL,
  club_id VARCHAR (15) NOT NULL,
  d_o_b DATE NULL,
  country_of_birth VARCHAR (40) NULL,
  national_team VARCHAR (40) NULL,
  PRIMARY KEY (player_id),
  INDEX (player_id),
  FOREIGN KEY (club_id)
    REFERENCES club (club_id)
);

CREATE TABLE fantasyTeam (
  team_id VARCHAR (15) NOT NULL,
  team_name VARCHAR (40) NULL,
  user_id VARCHAR (15) NOT NULL,
  PRIMARY KEY (team_id),
  INDEX (team_id),
  FOREIGN KEY (user_id)
    REFERENCES user (user_id)
);

CREATE TABLE fantasyTeamLeague (
  team_id VARCHAR (15) NOT NULL,
  league_id VARCHAR (15) NOT NULL,
  game_week VARCHAR (5) NOT NULL,
  PRIMARY KEY (team_id, league_id),
  FOREIGN KEY (team_id)
    REFERENCES fantasyTeam (team_id),
  FOREIGN KEY (league_id)
    REFERENCES fantasyLeague (league_id)
);

CREATE TABLE squad (
  team_id VARCHAR (15) NOT NULL,
  player_id VARCHAR (15) NOT NULL,
  first_team BOOLEAN NOT NULL DEFAULT 0,
  game_week VARCHAR (5) NOT NULL, 
  PRIMARY KEY (team_id),
  FOREIGN KEY (team_id)
    REFERENCES fantasyTeam (team_id),
  FOREIGN KEY (player_id)
    REFERENCES player (player_id)
);

CREATE TABLE playsIn (
  player_id VARCHAR (15) NOT NULL,
  fixture_id VARCHAR (15) NOT NULL,
  game_points VARCHAR (5) NOT NULL,
  PRIMARY KEY (player_id, fixture_id),
  FOREIGN KEY (player_id)
    REFERENCES player (player_id),
  FOREIGN KEY (fixture_id)
    REFERENCES fixture (fixture_id)
);

CREATE TABLE homeTeam (
  fixture_id VARCHAR (15) NOT NULL,
  club_id VARCHAR (15) NOT NULL,
  goals VARCHAR (5) NOT NULL,
  venue VARCHAR (15) NULL,
  PRIMARY KEY (fixture_id),
  FOREIGN KEY (fixture_id)
    REFERENCES fixture (fixture_id),
  FOREIGN KEY (club_id)
    REFERENCES club (club_id)
);

CREATE TABLE awayTeam (
  fixture_id VARCHAR (15) NOT NULL,
  club_id VARCHAR (15) NOT NULL,
  goals VARCHAR (5) NOT NULL,
  PRIMARY KEY (fixture_id),
  FOREIGN KEY (fixture_id)
    REFERENCES fixture (fixture_id),
  FOREIGN KEY (club_id)
    REFERENCES club (club_id)
);
