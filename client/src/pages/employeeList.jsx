import React, { useState, useEffect } from 'react';
import axios from 'axios';
import '../css/employeeList.css';

const EmployeeList = () => {
  const [employees, setEmployees] = useState([]);

  useEffect(() => {
    const fetchEmployees = async () => {
      try {
        const response = await axios.get('/api/employees');
        setEmployees(response.data);
      } catch (error) {
        console.error('Error fetching employees:', error);
      }
    };

    fetchEmployees();
  }, []);

  return (
    <div className='employees'>
        <h2>Employee List</h2>
          <table>
            <thead>
              <tr>
                <th>EmployeeID</th>
                <th>First Name</th>
                <th>Middle Init</th>
                <th>Last Name</th>
                <th>SSN</th>
                <th>Phone Number</th>
                <th>Email</th>
                <th>Address</th>
                <th>Sex</th>
                <th>Salary</th>
                <th>Role</th>
                <th>Department ID</th>
                <th>Hire Date</th>
                <th>DOB</th>
              </tr>
            </thead>
            <tbody>
            {employees && employees.map((employee) => (
                <tr key={employee.EmployeeID}>
                  <td>{employee.EmployeeID}</td>
                    <td>{employee.Fname}</td>
                    <td>{employee.Minit}</td>
                    <td>{employee.Lname}</td>
                    <td>{employee.Ssn}</td>
                    <td>{employee.Phone}</td>
                    <td>{employee.Email}</td>
                    <td>{employee.Address}</td>
                    <td>{employee.Sex}</td>
                    <td>{employee.Salary}</td>
                    <td>{employee.role}</td>
                    <td>{employee.DepartmentID}</td>
                    <td>{new Date(employee.HireDate).toLocaleDateString("en-US")}</td>
                    <td>{new Date(employee.Dob).toLocaleDateString("en-US")}</td>
                </tr>
          
            ))}
            </tbody>
          </table>
        </div>
  );
};

export default EmployeeList;
