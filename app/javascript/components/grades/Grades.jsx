import React from  'react'
import { useState, useEffect } from 'react';
import { Link } from 'react-router-dom'
import axios from 'axios';

const Grades = () => {
    const [grades, setGrades] = useState([])

    const deleteGrade = (e, id) =>{
        e.preventDefault()
        axios.delete(`/api/v1/grades/${id}`).then(res => {
            getGrades()
        }).catch(resp => console.log(resp))
    }

    const getGrades = () =>{
        axios.get('/api/v1/grades').then(res => {
            setGrades(res.data)
        }).catch(resp => console.log(resp))
    }

    useEffect(() => {
        getGrades()
    },[]); 
    
    const list = grades.map(item => {
        return (<tr key={item.id} >
            <td>{item.id}</td>
            <td>{item.student.name}</td>
            <td>{item.course.name}</td>
            <td>{item.quarter}</td>
            <td>{item.score}</td>
            <td>{item.status}</td>
            <td>
                <Link className='btn btn-primary me-1' to={`/grades/${item.id}`} >Show</Link>
                <Link className='btn btn-warning me-1' to={`/grades/${item.id}/edit`} >Edit</Link>
                <a className='btn btn-danger' onClick={e => deleteGrade(e, item.id)}>Delete</a>
            </td>
        </tr>)
    })



    return(
        <div className='container'>
            <div className='row'>
                <div className='col-md-11'></div>
                <div className='col-md-1'>
                    <Link className='btn btn-info' to={`/grades/new`} >New</Link>
                </div>
            </div>
            <div className='row'>
            <table className='table'>
                <thead>
                    <tr>
                        <th scope="col">Id</th>
                        <th scope="col">Student</th>
                        <th scope="col">Course</th>
                        <th scope="col">Quarter</th>
                        <th scope="col">Score</th>
                        <th scope="col">Status</th>
                        <th scope="col">Options</th>
                    </tr>
                </thead>
                <tbody>
                    {list.length
                        ? list
                        : <tr><td className='text-center' colSpan="7">No data</td></tr>
                    }
                </tbody>
            </table>
            </div>
            <div className='row'>
                <div className='col'><Link className='btn btn-secondary' to="/">Back</Link></div>
            </div>
        </div>
    )
}

export default Grades