package com.huawei.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.huawei.bean.Employee;
import com.huawei.bean.Msg;
import com.huawei.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    @RequestMapping(value = "checkUser",method = RequestMethod.POST)
    @ResponseBody
    public Msg checkUser(@RequestParam("empUser")String empUser){
        //先判断用户名是否是合法的表达式;
        String regx = "(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{2,5})";
        if(!empUser.matches(regx)){
            return Msg.fail().add("va_msg", "用户名必须是3-16位数字和字母的组合或者2-5位中文");
        }
        boolean b=employeeService.checkUser(empUser);
        if (b){
            return Msg.success();
        }
        else {
            return Msg.fail().add("va_msg", "用户名不可用");
        }
    }

    @RequestMapping(value = "empSave",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        if (result.hasErrors()){
            Map<String,Object> map=new HashMap<>();
            List<FieldError> errors=result.getFieldErrors();
            for (FieldError fieldError:errors){
                System.out.println("错误的字段名，"+fieldError.getField());
                System.out.println("错误的信息，"+fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        }else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    @RequestMapping(value ="emps",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1")Integer pn, Model model){
        //引入分页插件PageHelper
        //传入页码，每页数量
        PageHelper.startPage(pn,5);
        //分页查询
        List<Employee> emps=employeeService.getAll();
        //使用pageinfo包装查询后的结果，将pageinfo交给页面
        PageInfo page=new PageInfo(emps,5);
        return Msg.success().add("pageInfo",page);
    }


    //查询员工数据
    //@RequestMapping("/emps")
//    public  String getEmps(@RequestParam(value = "pn",defaultValue = "1")Integer pn, Model model){
//
//        //引入分页插件PageHelper
//        //传入页码，每页数量
//        PageHelper.startPage(pn,5);
//        //分页查询
//        List<Employee> emps=employeeService.getAll();
//        //使用pageinfo包装查询后的结果，将pageinfo交给页面
//        PageInfo page=new PageInfo(emps,5);
//        model.addAttribute("pageInfo",page);
//        return "list";
//    }
}
