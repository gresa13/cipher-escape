package com.cipherescape.gameeventservice.dto;

import lombok.Data;
import java.util.List;
import java.util.UUID;

@Data
public class PuzzleDTO {
    private UUID id;
    private Integer orderIndex;
    private String type;
    private String question;
    private String solution;
    private List<String> acceptableAnswers;
    private List<String> hints;
    private Integer basePoints;

}