import React from  'react'
import { useState, useEffect } from 'react';
import { Link } from 'react-router-dom'
import axios from 'axios';

const Students = () => {
    const [students, setStudents] = useState([])

    const deleteStudent = (e, id) =>{
        e.preventDefault()
        axios.delete(`/api/v1/students/${id}`).then(res => {
            getStudents()
        }).catch(resp => console.log(resp))
    }

    const getStudents = () =>{
        axios.get('/api/v1/students').then(res => {
            setStudents(res.data)
        }).catch(resp => console.log(resp))
    }

    useEffect(() => {
        getStudents()
    },[]); 
    
    const list = students.map(item => {
        return (<tr key={item.id} >
            <td>{item.id}</td>
            <td>{item.name}</td>
            <td>{item.last_name}</td>
            <td>
                <Link className='btn btn-primary me-1' to={`/students/${item.id}`} >Show</Link>
                <Link className='btn btn-warning me-1' to={`/students/${item.id}/edit`} >Edit</Link>
                <a className='btn btn-danger' onClick={e => deleteStudent(e, item.id)}>Delete</a>
            </td>
        </tr>)
    })



    return(
        <div className='container'>
            <div className='row'>
                <div className='col-md-11'></div>
                <div className='col-md-1'>
                    <Link className='btn btn-info' to={`/students/new`} >New</Link>
                </div>
            </div>
            <div className='row'>
            <table className='table'>
                <thead>
                    <tr>
                        <th scope="col">Id</th>
                        <th scope="col">Name</th>
                        <th scope="col">Last name</th>
                        <th scope="col">Options</th>
                    </tr>
                </thead>
                <tbody>
                    {list
                        ? list
                        : <tr><td colspan="4">No data</td></tr>
                    }
                </tbody>
            </table>
            </div>
        </div>
    )
}

export default Students