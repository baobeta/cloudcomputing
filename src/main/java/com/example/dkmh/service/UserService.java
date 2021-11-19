package com.example.dkmh.service;

import com.example.dkmh.entity.Users;
import com.example.dkmh.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

@Service
@Transactional
public class UserService {
    @Autowired
    UserRepository userRepository;

    public Users findByUsername(String name) {
        return userRepository.findUsersByUsername(name);
    }
    public void save(Users user ) {
        userRepository.save(user);
    }
}
