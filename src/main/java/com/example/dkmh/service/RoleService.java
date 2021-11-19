package com.example.dkmh.service;

import com.example.dkmh.entity.Roles;
import com.example.dkmh.repository.RoleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;

@Service
@Transactional
public class RoleService {

    @Autowired
    RoleRepository roleRepository;
    public List<String> getRoleNames(Integer userId) {
        List<String> roleName = new ArrayList<>();
        List<Roles> roles = roleRepository.getRolesNames(userId);
        for(Roles role : roles) {
            roleName.add(role.getName());
        }
        return  roleName;
    }
}
