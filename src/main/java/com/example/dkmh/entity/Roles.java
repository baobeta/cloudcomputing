package com.example.dkmh.entity;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name="roles")
public class Roles {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(length =40 , nullable =false , unique =true)
    private String name ;


    @Column(length =400, nullable =false )
    private String description;


    public Roles() {
    }


    public Roles(Integer id) {
        this.id = id;
    }


    public Roles(String name) {
        this.name = name;
    }

    public Roles(String name, String description) {
        this.name = name;
        this.description = description;
    }

    public Integer getId() {
        return id;
    }
    public void setId(Integer id) {
        this.id = id;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }


    @Override
    public int hashCode() {
        return Objects.hash(id);
    }


    @Override
    public String toString() {
        return this.name;
    }

}
