package com.huawei.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.huawei.bean.Employee;
import com.huawei.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;


    //查询员工数据
    @RequestMapping("/emps")
    public  String getEmps(@RequestParam(value = "pn",defaultValue = "1")Integer pn, Model model){

        //引入分页插件PageHelper
        //传入页码，每页数量
        PageHelper.startPage(pn,5);
        //分页查询
        List<Employee> emps=employeeService.getAll();
        //使用pageinfo包装查询后的结果，将pageinfo交给页面
        PageInfo page=new PageInfo(emps,5);
        model.addAttribute("pageInfo",page);
        return "list";
    }
}
