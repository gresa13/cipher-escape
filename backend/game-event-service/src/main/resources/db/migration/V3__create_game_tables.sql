CREATE TABLE teams (
                       id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                       name VARCHAR(50) NOT NULL,
                       invite_code VARCHAR(10) UNIQUE,
                       leader_id UUID NOT NULL REFERENCES users(id),
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE team_members (
                              team_id UUID REFERENCES teams(id) ON DELETE CASCADE,
                              user_id UUID REFERENCES users(id) ON DELETE CASCADE,
                              joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                              PRIMARY KEY (team_id, user_id)
);

CREATE TABLE games (
                       id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                       mode VARCHAR(20) NOT NULL,
                       status VARCHAR(20) NOT NULL,
                       mystery_id UUID NOT NULL REFERENCES mysteries(id),
                       start_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       end_time TIMESTAMP,
                       total_score INT DEFAULT 0,
                       player_id UUID REFERENCES users(id),
                       team_id UUID REFERENCES teams(id),
                       CHECK (player_id IS NOT NULL OR team_id IS NOT NULL)
);

CREATE TABLE puzzle_attempts (
                                 id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                 game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
                                 puzzle_id UUID NOT NULL REFERENCES puzzles(id),
                                 user_id UUID NOT NULL REFERENCES users(id),
                                 submitted_answer TEXT NOT NULL,
                                 is_correct BOOLEAN NOT NULL,
                                 points_awarded INT DEFAULT 0,
                                 attempt_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Result table for final scores
CREATE TABLE game_results (
                              id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                              game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
                              user_id UUID NOT NULL REFERENCES users(id),
                              individual_score INT DEFAULT 0,
                              is_mvp BOOLEAN DEFAULT FALSE,
                              created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_games_player ON games(player_id);
CREATE INDEX idx_games_team ON games(team_id);