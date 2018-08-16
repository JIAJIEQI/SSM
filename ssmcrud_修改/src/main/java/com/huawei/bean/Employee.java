package com.huawei.bean;


import javax.validation.constraints.Pattern;

public class Employee {
    private Integer empId;

    @Pattern(regexp = "(^[A-Za-z0-9_]{3,16}$)|(^[\\u2E80-\\u9FFF]{2,5}$)",
            message = "用户名必须是2-5位中文或者3-16位英文数字下划线组合")
    private String empUser;

    private String gender;

    @Pattern(regexp = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$",message = "邮箱格式不正确")
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