package employee.model.service;

import java.sql.*;
import java.sql.Date;
import java.util.*;

import common.JDBCtemplate;
import employee.model.dao.EmployeeDao;
import employee.model.vo.Employee;
import static common.JDBCtemplate.*;

public class EmployeeService {
	// 의존성 주입
	private EmployeeDao empDao = new EmployeeDao();

	public EmployeeService() {}

	public Employee selectOne(String empId) {
		//Connection 얻고
		Connection conn = getConnection();
		//Dao 메소드 실행
		Employee emp = empDao.selectOne(conn, empId);
		//Connection 반납
		close(conn);
		return emp;
	}

	public ArrayList<Employee> selectList() {
		Connection conn = getConnection();
		ArrayList<Employee> list = empDao.selectList(conn);
		close(conn);
		return list;
	}

	public HashMap<String, Employee> selectMap() {
		Connection conn = getConnection();
		HashMap<String, Employee> map = empDao.selectMap(conn);
		close(conn);
		return map;
	}

	public ArrayList<Employee> selectSearchName(String empName) {
		Connection conn = getConnection();
		ArrayList<Employee> list = empDao.selectSearchName(conn,empName);
		close(conn);
		return list;
	}

	public ArrayList<Employee> selectSearchHireDate(String hireDate) {
		Connection conn = getConnection();
		ArrayList<Employee> list = empDao.selectSearchHireDate(conn, hireDate);
		close(conn);
		return list;
	}

	public ArrayList<Employee> selectSearchSalary(int minSal, int maxSal) {
		Connection conn = getConnection();
		ArrayList<Employee> list = empDao.selectSearchSalary(conn, minSal, maxSal);
		close(conn);
		return list;
	}

	public int insertEmployee(Employee emp) {
		Connection conn = getConnection();
		int result = empDao.insertEmployee(conn, emp);
		if(result>0){
			commit(conn);
		}else{
			rollback(conn);
		}
		close(conn);
		return result;
	}
	
	public int deleteEmployee(String empId){
		Connection conn = getConnection();
		int result = empDao.deleteEmployee(conn, empId);
		if(result>0){
			commit(conn);
		}else{
			rollback(conn);
		}
		close(conn);
		return result;
	}
	
	public int updateEmployee(Employee emp){
		Connection conn = getConnection();
		int result = empDao.updateEmployee(conn, emp);
		if(result>0){
			commit(conn);
		}else{
			rollback(conn);
		}
		close(conn);
		return result;		
	}

}
