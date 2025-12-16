CREATE TABLE mysteries (
                           id BIGSERIAL PRIMARY KEY,
                           title VARCHAR(200) NOT NULL,
                           theme VARCHAR(100) NOT NULL,
                           difficulty_level INT NOT NULL CHECK (difficulty_level BETWEEN 1 AND 5),
                           time_limit INT NOT NULL,
                           narrative TEXT NOT NULL,
                           status VARCHAR(20) NOT NULL DEFAULT 'DRAFT',
                           created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE puzzles (
                         id BIGSERIAL PRIMARY KEY,
                         mystery_id BIGINT NOT NULL,
                         order_index INT NOT NULL,
                         type VARCHAR(20) NOT NULL,
                         question TEXT NOT NULL,
                         solution VARCHAR(255) NOT NULL,
                         base_points INT NOT NULL,
                         CONSTRAINT fk_puzzle_mystery FOREIGN KEY (mystery_id) REFERENCES mysteries(id) ON DELETE CASCADE
);

-- @ElementCollection tables
CREATE TABLE puzzle_hints (
                              puzzle_id BIGINT NOT NULL,
                              hint VARCHAR(500),
                              CONSTRAINT fk_puzzle_hints FOREIGN KEY (puzzle_id) REFERENCES puzzles(id) ON DELETE CASCADE
);

CREATE TABLE puzzle_acceptable_answers (
                                           puzzle_id BIGINT NOT NULL,
                                           answer VARCHAR(255),
                                           CONSTRAINT fk_puzzle_answers FOREIGN KEY (puzzle_id) REFERENCES puzzles(id) ON DELETE CASCADE
);

-- Indexes for performance
CREATE INDEX idx_puzzles_mystery ON puzzles(mystery_id, order_index);
CREATE INDEX idx_hints_puzzle ON puzzle_hints(puzzle_id);
CREATE INDEX idx_answers_puzzle ON puzzle_acceptable_answers(puzzle_id);