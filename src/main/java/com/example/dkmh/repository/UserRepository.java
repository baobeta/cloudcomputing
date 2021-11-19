package com.example.dkmh.repository;

import com.example.dkmh.entity.Users;
import org.springframework.data.repository.CrudRepository;

public interface UserRepository extends CrudRepository<Users,Integer> {
    Users findUsersByUsername(String username);


}
