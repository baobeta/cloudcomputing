package com.example.dkmh.repository;

import com.example.dkmh.entity.Roles;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface RoleRepository extends CrudRepository<Roles,Integer> {

    @Query("Select ur.roles from Users ur where ur.id = ?1")
    public List<Roles>getRolesNames(Integer userId);
}
