package com.huawei.test;


import com.huawei.bean.Department;
import com.huawei.bean.Employee;
import com.huawei.dao.DepartmentMapper;
import com.huawei.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring/spring-mybatis.xml"})
public class Demotest {
    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;
    @Test
    public void  CrudTest(){
        System.out.println(departmentMapper);

//        1、插入
//        departmentMapper.insertSelective(new Department(null,"开发部"));
//       departmentMapper.insertSelective(new Department(null,"测试部"));

       // employeeMapper.insertSelective(new Employee(null,"jerry" ,"M","156@qq.com",1));
        //批量插入

//        EmployeeMapper mapper=sqlSession.getMapper(EmployeeMapper.class);
//        for (int i=10;i<50;i++){
//            String uid=UUID.randomUUID().toString().substring(0,5)+i;
//            mapper.insertSelective(new Employee(null,uid ,"M",uid+"@qq.com",1));
//        }
//        for (int i=18;i<20;i++) {
//            departmentMapper.deleteByPrimaryKey(i);
//        }
    }
}
