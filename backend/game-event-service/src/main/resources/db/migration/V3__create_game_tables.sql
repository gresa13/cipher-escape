CREATE TABLE teams (
                       id BIGSERIAL PRIMARY KEY,
                       name VARCHAR(50) NOT NULL,
                       invite_code VARCHAR(10) UNIQUE,
                       leader_id BIGINT NOT NULL,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       CONSTRAINT fk_team_leader FOREIGN KEY (leader_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE team_members (
                              team_id BIGINT NOT NULL,
                              user_id BIGINT NOT NULL,
                              joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                              PRIMARY KEY (team_id, user_id),
                              CONSTRAINT fk_team_members_team FOREIGN KEY (team_id) REFERENCES teams(id) ON DELETE CASCADE,
                              CONSTRAINT fk_team_members_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE games (
                       id BIGSERIAL PRIMARY KEY,
                       mode VARCHAR(20) NOT NULL,
                       status VARCHAR(20) NOT NULL,
                       mystery_id BIGINT NOT NULL,
                       start_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       end_time TIMESTAMP,
                       total_score INT DEFAULT 0,
                       player_id BIGINT,
                       team_id BIGINT,
                       CONSTRAINT fk_game_mystery FOREIGN KEY (mystery_id) REFERENCES mysteries(id) ON DELETE CASCADE,
                       CONSTRAINT fk_game_player FOREIGN KEY (player_id) REFERENCES users(id) ON DELETE SET NULL,
                       CONSTRAINT fk_game_team FOREIGN KEY (team_id) REFERENCES teams(id) ON DELETE SET NULL,
                       CONSTRAINT chk_game_participant CHECK (player_id IS NOT NULL OR team_id IS NOT NULL)
);

CREATE TABLE puzzle_attempts (
                                 id BIGSERIAL PRIMARY KEY,
                                 game_id BIGINT NOT NULL,
                                 puzzle_id BIGINT NOT NULL,
                                 user_id BIGINT NOT NULL,
                                 submitted_answer TEXT NOT NULL,
                                 is_correct BOOLEAN NOT NULL,
                                 points_awarded INT DEFAULT 0,
                                 attempt_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                 CONSTRAINT fk_attempt_game FOREIGN KEY (game_id) REFERENCES games(id) ON DELETE CASCADE,
                                 CONSTRAINT fk_attempt_puzzle FOREIGN KEY (puzzle_id) REFERENCES puzzles(id) ON DELETE CASCADE,
                                 CONSTRAINT fk_attempt_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE game_results (
                              id BIGSERIAL PRIMARY KEY,
                              game_id BIGINT NOT NULL,
                              user_id BIGINT NOT NULL,
                              individual_score INT DEFAULT 0,
                              is_mvp BOOLEAN DEFAULT FALSE,
                              created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                              CONSTRAINT fk_result_game FOREIGN KEY (game_id) REFERENCES games(id) ON DELETE CASCADE,
                              CONSTRAINT fk_result_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Indexes
CREATE INDEX idx_games_player ON games(player_id);
CREATE INDEX idx_games_team ON games(team_id);
CREATE INDEX idx_games_mystery ON games(mystery_id);
CREATE INDEX idx_games_status ON games(status);
CREATE INDEX idx_attempts_game ON puzzle_attempts(game_id);
CREATE INDEX idx_attempts_user ON puzzle_attempts(user_id);
CREATE INDEX idx_results_game ON game_results(game_id);
CREATE INDEX idx_results_user ON game_results(user_id);
CREATE INDEX idx_team_members_user ON team_members(user_id);