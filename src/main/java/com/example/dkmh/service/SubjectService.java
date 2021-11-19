package com.example.dkmh.service;

import com.example.dkmh.entity.Subjects;
import com.example.dkmh.repository.SubjectRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
@Transactional
public class SubjectService {

    @Autowired
    private SubjectRepository subjectRepository;

    public List<Subjects> getAll() {
        return (List<Subjects>)subjectRepository.findAll();
    }
    public List<Subjects> getSubjects(String keyword){
        return (List<Subjects>)subjectRepository.findAll(keyword);
    }

    public Subjects getSubjectsById(Integer id) {return subjectRepository.findSubjectsById(id);}






}
