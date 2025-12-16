CREATE TABLE puzzle_acceptable_answers (
puzzle_id UUID NOT NULL,
answer TEXT,
CONSTRAINT fk_puzzle_answers FOREIGN KEY (puzzle_id) REFERENCES puzzles(id) ON DELETE CASCADE
);

CREATE TABLE puzzle_hints (
puzzle_id UUID NOT NULL,
hint TEXT,
CONSTRAINT fk_puzzle_hints FOREIGN KEY (puzzle_id) REFERENCES puzzles(id) ON DELETE CASCADE
);

CREATE INDEX idx_puzzle_answers ON puzzle_acceptable_answers(puzzle_id);
CREATE INDEX idx_puzzle_hints ON puzzle_hints(puzzle_id);