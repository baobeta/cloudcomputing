package com.example.dkmh.repository;

import com.example.dkmh.entity.Subjects;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface SubjectRepository extends CrudRepository<Subjects,Integer> {

    @Query("SELECT s FROM Subjects s WHERE s.nameSubject LIKE %?1% ")
    List<Subjects>  findAll(String keyword);

    @Query("SELECT s FROM Subjects s WHERE s.id = ?1 ")
    Subjects findSubjectsById(Integer id);


}
