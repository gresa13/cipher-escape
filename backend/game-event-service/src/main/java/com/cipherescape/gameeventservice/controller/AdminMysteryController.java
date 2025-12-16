package com.cipherescape.gameeventservice.controller;

import com.cipherescape.gameeventservice.dto.MysteryDTO;
import com.cipherescape.gameeventservice.service.MysteryService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

        import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/admin/mysteries")
public class AdminMysteryController {

    private final MysteryService service;

    public AdminMysteryController(MysteryService service) {
        this.service = service;
    }

    @GetMapping
    public ResponseEntity<List<MysteryDTO>> getAllMysteries(
            @RequestParam(required = false) String theme,
            @RequestParam(required = false) Integer difficulty) {
        return ResponseEntity.ok(service.getAllMysteries(theme, difficulty));
    }

    @GetMapping("/{id}")
    public ResponseEntity<MysteryDTO> getMysteryById(@PathVariable UUID id) {
        return ResponseEntity.ok(service.getMysteryById(id));
    }

    @PostMapping
    public ResponseEntity<MysteryDTO> createMystery(@RequestBody MysteryDTO mysteryDTO) {
        return ResponseEntity.ok(service.createMystery(mysteryDTO));
    }

    @PutMapping("/{id}")
    public ResponseEntity<MysteryDTO> updateMystery(@PathVariable UUID id, @RequestBody MysteryDTO mysteryDTO) {
        return ResponseEntity.ok(service.updateMystery(id, mysteryDTO));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteMystery(@PathVariable UUID id) {
        service.deleteMystery(id);
        return ResponseEntity.noContent().build();
    }
}