package com.cipherescape.gameeventservice.controller;

import com.cipherescape.gameeventservice.dto.MysteryDTO;
import com.cipherescape.gameeventservice.service.MysteryService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/admin/mysteries")
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
    public ResponseEntity<MysteryDTO> getMysteryById(@PathVariable Long id) {
        return ResponseEntity.ok(service.getMysteryById(id));
    }

    @PostMapping
    public ResponseEntity<MysteryDTO> createMystery(@RequestBody MysteryDTO mysteryDTO) {
        return ResponseEntity.ok(service.createMystery(mysteryDTO));
    }

    @PutMapping("/update/{id}")
    public ResponseEntity<MysteryDTO> updateMystery(@PathVariable Long id, @RequestBody MysteryDTO mysteryDTO) {
        return ResponseEntity.ok(service.updateMystery(id, mysteryDTO));
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<Void> deleteMystery(@PathVariable Long id) {
        service.deleteMystery(id);
        return ResponseEntity.noContent().build();
    }
}