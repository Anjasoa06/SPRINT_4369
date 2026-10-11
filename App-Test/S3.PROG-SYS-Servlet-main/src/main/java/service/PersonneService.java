package service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import model.Personne;
import repository.PersonneRepository;

@Service
public class PersonneService {

    @Autowired
    private PersonneRepository personneRepository;

    @Transactional(readOnly = true)
    public List<Personne> findAll() {
        return personneRepository.findAll();
    }

    @Transactional(readOnly = true)
    public Optional<Personne> findById(Long id) {
        return personneRepository.findById(id);
    }

    @Transactional(readOnly = true)
    public Optional<Personne> findByEmail(String email) {
        return personneRepository.findByEmail(email);
    }

    @Transactional
    public Personne save(Personne personne) {
        return personneRepository.save(personne);
    }

    @Transactional
    public void deleteById(Long id) {
        personneRepository.deleteById(id);
    }

    @Transactional(readOnly = true)
    public long count() {
        return personneRepository.count();
    }
}