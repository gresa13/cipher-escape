CREATE TABLE validation_log (
                                id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                puzzle_id UUID,
                                user_answer TEXT,
                                ai_response TEXT,
                                is_correct BOOLEAN,
                                confidence_score FLOAT,
                                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE difficulty_progression_log (
                                            id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                            user_id UUID REFERENCES users(id),
                                            old_level INT,
                                            new_level INT,
                                            dp_change INT,
                                            reason VARCHAR(255),
                                            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);