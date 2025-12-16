package com.cipherescape.gameeventservice.model;

import com.cipherescape.gameeventservice.dto.MysteryDTO; // Import DTO
import com.cipherescape.gameeventservice.dto.PuzzleDTO; // Import DTO
import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Entity
@Table(name = "mysteries")
@Data
public class Mystery {
    @Id
    @GeneratedValue
    private UUID id;

    private String title;
    private String theme;

    @Column(name = "difficulty_level")
    private Integer difficultyLevel;

    @Column(name = "time_limit")
    private Integer timeLimit;

    @Column(columnDefinition = "TEXT")
    private String narrative;

    private String status;

    @OneToMany(mappedBy = "mystery", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Puzzle> puzzles;

    @Column(name = "created_at")
    private LocalDateTime createdAt = LocalDateTime.now();

    public MysteryDTO toDTO() {
        MysteryDTO dto = new MysteryDTO();
        dto.setId(this.id);
        dto.setTitle(this.title);
        dto.setTheme(this.theme);
        dto.setDifficultyLevel(this.difficultyLevel);
        dto.setTimeLimit(this.timeLimit);
        dto.setNarrative(this.narrative);
        dto.setStatus(this.status);
        dto.setCreatedAt(this.createdAt);

        if (this.puzzles != null) {
            dto.setPuzzles(this.puzzles.stream()
                    .map(Puzzle::toDTO) // Calls the method inside Puzzle
                    .collect(Collectors.toList()));
        }
        return dto;
    }


    public static Mystery fromDTO(MysteryDTO dto) {
        Mystery mystery = new Mystery();
        mystery.setTitle(dto.getTitle());
        mystery.setTheme(dto.getTheme());
        mystery.setDifficultyLevel(dto.getDifficultyLevel());
        mystery.setTimeLimit(dto.getTimeLimit());
        mystery.setNarrative(dto.getNarrative());
        mystery.setStatus(dto.getStatus());

        if (dto.getPuzzles() != null) {
            List<Puzzle> puzzleList = new ArrayList<>();
            for (PuzzleDTO pDto : dto.getPuzzles()) {
                Puzzle p = Puzzle.fromDTO(pDto); // Calls the method inside Puzzle
                p.setMystery(mystery); // Link back to parent
                puzzleList.add(p);
            }
            mystery.setPuzzles(puzzleList);
        }
        return mystery;
    }
}