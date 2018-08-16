package com.huawei.service;

import com.huawei.bean.Department;
import com.huawei.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentService {
    @Autowired
    DepartmentMapper departmentMapper;

    public List<Department> getDepts() {
        List<Department> list=departmentMapper.selectByExample(null);
        return list;
    }
}
