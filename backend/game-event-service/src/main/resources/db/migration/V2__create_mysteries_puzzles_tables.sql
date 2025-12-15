CREATE TABLE mysteries (
                           id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                           title VARCHAR(100) NOT NULL,
                           theme VARCHAR(50) NOT NULL,
                           difficulty_level INT NOT NULL CHECK (difficulty_level BETWEEN 1 AND 5),
                           time_limit INT NOT NULL,
                           narrative TEXT NOT NULL,
                           status VARCHAR(20) DEFAULT 'DRAFT',
                           created_by UUID, -- Optional link to admin user
                           created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                           updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE puzzles (
                         id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                         mystery_id UUID NOT NULL REFERENCES mysteries(id) ON DELETE CASCADE,
                         order_index INT NOT NULL,
                         type VARCHAR(30) NOT NULL,
                         question TEXT NOT NULL,
                         solution VARCHAR(255) NOT NULL,
                         acceptable_answers TEXT[], -- Array of strings
                         hints TEXT[], -- Array of strings
                         base_points INT NOT NULL,
                         allow_ai_validation BOOLEAN DEFAULT FALSE,
                         created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_mysteries_diff_theme ON mysteries(difficulty_level, theme);
CREATE INDEX idx_puzzles_mystery_id ON puzzles(mystery_id);