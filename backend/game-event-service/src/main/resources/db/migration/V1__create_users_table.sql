CREATE TABLE users (
                       id BIGSERIAL PRIMARY KEY,
                       email VARCHAR(255) UNIQUE NOT NULL,
                       username VARCHAR(50) UNIQUE NOT NULL,
                       password_hash VARCHAR(255) NOT NULL,
                       difficulty_level INT DEFAULT 1 CHECK (difficulty_level BETWEEN 1 AND 5),
                       difficulty_points INT DEFAULT 0 CHECK (difficulty_points >= 0),
                       total_score INT DEFAULT 0,
                       solo_score INT DEFAULT 0,
                       team_score INT DEFAULT 0,
                       total_games INT DEFAULT 0,
                       total_wins INT DEFAULT 0,
                       mvp_count INT DEFAULT 0,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       last_login TIMESTAMP
);

CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_username ON users(username);
CREATE INDEX idx_users_difficulty ON users(difficulty_level, difficulty_points);