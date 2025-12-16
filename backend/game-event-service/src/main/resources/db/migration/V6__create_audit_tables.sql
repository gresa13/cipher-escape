CREATE TABLE validation_log (
                                id BIGSERIAL PRIMARY KEY,
                                puzzle_id BIGINT,
                                user_answer TEXT,
                                ai_response TEXT,
                                is_correct BOOLEAN,
                                confidence_score FLOAT,
                                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                CONSTRAINT fk_validation_puzzle FOREIGN KEY (puzzle_id) REFERENCES puzzles(id) ON DELETE SET NULL
);

CREATE TABLE difficulty_progression_log (
                                            id BIGSERIAL PRIMARY KEY,
                                            user_id BIGINT NOT NULL,
                                            old_level INT,
                                            new_level INT,
                                            dp_change INT,
                                            reason VARCHAR(255),
                                            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                            CONSTRAINT fk_progression_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Indexes
CREATE INDEX idx_validation_log_puzzle ON validation_log(puzzle_id);
CREATE INDEX idx_validation_log_created ON validation_log(created_at DESC);
CREATE INDEX idx_progression_log_user ON difficulty_progression_log(user_id);
CREATE INDEX idx_progression_log_created ON difficulty_progression_log(created_at DESC);