package com.huawei.bean;

public class Employee {
    private Integer empId;

    private String empUser;

    private String gender;

    private String email;

    private Integer dId;
//查询员工的同时还有部门信息
    private  Department department;

    public Employee() {
        super();
    }

    public Employee(Integer empId, String empUser, String gender, String email, Integer dId) {
        this.empId = empId;
        this.empUser = empUser;
        this.gender = gender;
        this.email = email;
        this.dId = dId;
    }

    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }

    public Integer getEmpId() {
        return empId;
    }

    public void setEmpId(Integer empId) {
        this.empId = empId;
    }

    public String getEmpUser() {
        return empUser;
    }

    public void setEmpUser(String empUser) {
        this.empUser = empUser == null ? null : empUser.trim();
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender == null ? null : gender.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public Integer getdId() {
        return dId;
    }

    public void setdId(Integer dId) {
        this.dId = dId;
    }
}