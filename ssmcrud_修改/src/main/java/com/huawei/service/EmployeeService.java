package com.huawei.service;

import com.huawei.bean.Employee;
import com.huawei.bean.EmployeeExample;
import com.huawei.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    public List<Employee> getAll() {
        return employeeMapper.selectByExampleWithDept(null);
    }

    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    public boolean checkUser(String empUser) {
        EmployeeExample example= new EmployeeExample();
        EmployeeExample.Criteria criteria=example.createCriteria();
        criteria.andEmpUserEqualTo(empUser);
        long count = employeeMapper.countByExample(example);
        return  count==0;
    }
}
