package com.cipherescape.gameeventservice.repository;


import com.cipherescape.gameeventservice.model.Mystery;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.UUID;

public interface MysteryRepository extends JpaRepository<Mystery, UUID> {

    List<Mystery> findByTheme(String theme);
    List<Mystery> findByDifficultyLevel(Integer level);
    List<Mystery> findByThemeAndDifficultyLevel(String theme, Integer level);
}