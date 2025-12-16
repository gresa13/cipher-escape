CREATE TABLE leaderboards (
                              id BIGSERIAL PRIMARY KEY,
                              type VARCHAR(20) NOT NULL, -- GLOBAL, SOLO, TEAM, WEEKLY
                              user_id BIGINT NOT NULL,
                              score INT NOT NULL,
                              rank INT NOT NULL,
                              updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                              CONSTRAINT fk_leaderboard_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE achievements (
                              id VARCHAR(50) PRIMARY KEY, -- Keep as VARCHAR for named IDs like "FIRST_WIN"
                              name VARCHAR(100) NOT NULL,
                              description TEXT NOT NULL,
                              category VARCHAR(20) NOT NULL,
                              points INT NOT NULL,
                              icon_url VARCHAR(255)
);

CREATE TABLE user_achievements (
                                   user_id BIGINT NOT NULL,
                                   achievement_id VARCHAR(50) NOT NULL,
                                   progress INT DEFAULT 0,
                                   is_unlocked BOOLEAN DEFAULT FALSE,
                                   unlocked_at TIMESTAMP,
                                   PRIMARY KEY (user_id, achievement_id),
                                   CONSTRAINT fk_user_achievement_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
                                   CONSTRAINT fk_user_achievement_achievement FOREIGN KEY (achievement_id) REFERENCES achievements(id) ON DELETE CASCADE
);

-- Indexes
CREATE INDEX idx_leaderboards_type_rank ON leaderboards(type, rank);
CREATE INDEX idx_leaderboards_user ON leaderboards(user_id);
CREATE INDEX idx_user_achievements_user ON user_achievements(user_id);
CREATE INDEX idx_user_achievements_unlocked ON user_achievements(user_id, is_unlocked);