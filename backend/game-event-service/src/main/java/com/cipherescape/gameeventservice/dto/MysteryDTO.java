package com.cipherescape.gameeventservice.dto;

import lombok.Data;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Data
public class MysteryDTO {
    private UUID id;
    private String title;
    private String theme;
    private Integer difficultyLevel;
    private Integer timeLimit;
    private String narrative;
    private String status;
    private LocalDateTime createdAt;
    private List<PuzzleDTO> puzzles;
}