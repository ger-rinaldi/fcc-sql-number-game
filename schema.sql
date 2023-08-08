CREATE TABLE players(
  player_id SERIAL PRIMARY KEY,
  name VARCHAR(22) UNIQUE NOT NULL,
  games_played INT NOT NULL DEFAULT -1,
  best_game INT NOT NULL DEFAULT -1);

INSERT INTO players(name, games_played, best_game) VALUES ('tester_1', 2, 5), ('tester_2', 9, 3);