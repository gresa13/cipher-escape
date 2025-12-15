CREATE TABLE leaderboards (
                              id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                              type VARCHAR(20) NOT NULL, -- GLOBAL, SOLO, TEAM, WEEKLY
                              user_id UUID NOT NULL REFERENCES users(id),
                              score INT NOT NULL,
                              rank INT NOT NULL,
                              updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE achievements (
                              id VARCHAR(50) PRIMARY KEY,
                              name VARCHAR(100) NOT NULL,
                              description TEXT NOT NULL,
                              category VARCHAR(20) NOT NULL,
                              points INT NOT NULL,
                              icon_url VARCHAR(255)
);

CREATE TABLE user_achievements (
                                   user_id UUID REFERENCES users(id) ON DELETE CASCADE,
                                   achievement_id VARCHAR(50) REFERENCES achievements(id),
                                   progress INT DEFAULT 0,
                                   is_unlocked BOOLEAN DEFAULT FALSE,
                                   unlocked_at TIMESTAMP,
                                   PRIMARY KEY (user_id, achievement_id)
);