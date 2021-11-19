package com.example.dkmh.entity;

import javax.persistence.*;


@Entity
@Table(name ="subjects")
public class Subjects {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(length =128, nullable = false)
    private String nameSubject;

    @Column(length =128, nullable = false)
    private String categorySubject;

    @Column
    private Integer totalCredits;











    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNameSubject() {
        return nameSubject;
    }

    public void setNameSubject(String nameSubject) {
        this.nameSubject = nameSubject;
    }

    public String getCategorySubject() {
        return categorySubject;
    }

    public void setCategorySubject(String categorySubject) {
        this.categorySubject = categorySubject;
    }

    public Integer getTotalCredits() {
        return totalCredits;
    }

    public void setTotalCredits(Integer totalCredits) {
        this.totalCredits = totalCredits;
    }



}
