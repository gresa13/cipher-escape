package com.cipherescape.gameeventservice.service;

import com.cipherescape.gameeventservice.dto.MysteryDTO;
import com.cipherescape.gameeventservice.model.Mystery;
import com.cipherescape.gameeventservice.repository.MysteryRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
public class MysteryService {

    private final MysteryRepository repository;

    public MysteryService(MysteryRepository repository) {
        this.repository = repository;
    }

    public List<MysteryDTO> getAllMysteries(String theme, Integer difficulty) {
        List<Mystery> mysteries;

        if (theme != null && difficulty != null) {
            mysteries = repository.findByThemeAndDifficultyLevel(theme, difficulty);
        } else if (theme != null) {
            mysteries = repository.findByTheme(theme);
        } else if (difficulty != null) {
            mysteries = repository.findByDifficultyLevel(difficulty);
        } else {
            mysteries = repository.findAll();
        }

        return mysteries.stream()
                .map(Mystery::toDTO)
                .collect(Collectors.toList());
    }

    public MysteryDTO getMysteryById(Long id) {
        Mystery mystery = repository.findById(id)
                .orElseThrow(() -> new RuntimeException("Mystery not found"));
        return mystery.toDTO();
    }

    @Transactional
    public MysteryDTO createMystery(MysteryDTO mysteryDTO) {
        Mystery mystery = Mystery.fromDTO(mysteryDTO);
        Mystery savedMystery = repository.save(mystery);
        return savedMystery.toDTO();
    }

    public MysteryDTO updateMystery(Long id, MysteryDTO mysteryDetails) {
        Mystery existing = repository.findById(id)
                .orElseThrow(() -> new RuntimeException("Mystery not found"));

        existing.setTitle(mysteryDetails.getTitle());
        existing.setTheme(mysteryDetails.getTheme());
        existing.setDifficultyLevel(mysteryDetails.getDifficultyLevel());
        existing.setTimeLimit(mysteryDetails.getTimeLimit());
        existing.setNarrative(mysteryDetails.getNarrative());
        existing.setStatus(mysteryDetails.getStatus());

        Mystery updated = repository.save(existing);
        return updated.toDTO();
    }


    public void deleteMystery(Long id) {
        // TODO: In Phase 2, inject GameRepository and check count > 0
        boolean hasBeenPlayed = false; // Mocking this as false for now so you can test delete

        if (hasBeenPlayed) {
            throw new RuntimeException("Cannot delete a mystery that has already been played by users.");
        }

        repository.deleteById(id);
    }
}