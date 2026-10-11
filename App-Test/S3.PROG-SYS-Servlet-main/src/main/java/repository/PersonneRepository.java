package repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import model.Personne;

public interface PersonneRepository extends JpaRepository<Personne, Long> {

    Optional<Personne> findByEmail(String email);

    List<Personne> findByNomContainingIgnoreCase(String nom);
}