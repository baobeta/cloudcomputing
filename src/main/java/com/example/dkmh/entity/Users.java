package com.example.dkmh.entity;


import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name ="users")
public class Users {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(length =128, nullable = false)
    private String username;

    @Column(length =64, nullable = false)
    private String password;


    @Column(name = "Enabled", length = 1, nullable = false)
    private boolean enabled;

    @Column(name="name", length =45 , nullable =true)
    private String fullName;

    @Column(name="class", length =45 , nullable =true)
    private String className;

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(
            name ="dkmh",
            joinColumns = @JoinColumn(name ="users_id"),
            inverseJoinColumns = @JoinColumn(name="subject_id")
    )
    private Set<Subjects> subject = new HashSet<>();


    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(
            name ="users_roles",
            joinColumns = @JoinColumn(name ="users_id"),
            inverseJoinColumns = @JoinColumn(name="role_id")
    )
    private Set<Roles> roles = new HashSet<>();








    public Set<Subjects> getSubject() {
        return subject;
    }

    public void setSubject(Set<Subjects> subject) {
        this.subject = subject;
    }

    public Set<Roles> getRoles() {
        return roles;
    }

    public void setRoles(Set<Roles> roles) {
        this.roles = roles;
    }


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public boolean isEnabled() {
        return enabled;
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }




}
