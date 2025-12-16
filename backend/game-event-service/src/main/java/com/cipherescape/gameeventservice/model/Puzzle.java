package com.cipherescape.gameeventservice.model;


import com.cipherescape.gameeventservice.dto.PuzzleDTO; // Import the DTO
import jakarta.persistence.*;
import lombok.Data;
import java.util.List;
import java.util.UUID;

@Entity
@Table(name = "puzzles")
@Data
public class Puzzle {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "mystery_id")
    private Mystery mystery;

    @Column(name = "order_index")
    private Integer orderIndex;

    private String type;
    private String question;
    private String solution;

    @ElementCollection
    @CollectionTable(name = "puzzle_acceptable_answers", joinColumns = @JoinColumn(name = "puzzle_id"))
    @Column(name = "answer")
    private List<String> acceptableAnswers;

    @ElementCollection
    @CollectionTable(name = "puzzle_hints", joinColumns = @JoinColumn(name = "puzzle_id"))
    @Column(name = "hint")
    private List<String> hints;

    @Column(name = "base_points")
    private Integer basePoints;


    public PuzzleDTO toDTO() {
        PuzzleDTO dto = new PuzzleDTO();
        dto.setId(this.id);
        dto.setOrderIndex(this.orderIndex);
        dto.setType(this.type);
        dto.setQuestion(this.question);
        dto.setSolution(this.solution);
        dto.setBasePoints(this.basePoints);
        dto.setAcceptableAnswers(this.acceptableAnswers);
        dto.setHints(this.hints);
        return dto;
    }

    public static Puzzle fromDTO(PuzzleDTO dto) {
        Puzzle puzzle = new Puzzle();
        puzzle.setOrderIndex(dto.getOrderIndex());
        puzzle.setType(dto.getType());
        puzzle.setQuestion(dto.getQuestion());
        puzzle.setSolution(dto.getSolution());
        puzzle.setBasePoints(dto.getBasePoints());
        puzzle.setAcceptableAnswers(dto.getAcceptableAnswers());
        puzzle.setHints(dto.getHints());
        return puzzle;
    }
}