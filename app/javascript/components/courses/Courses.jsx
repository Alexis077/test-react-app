import React from  'react'
import { useState, useEffect } from 'react';
import { Link } from 'react-router-dom'
import axios from 'axios';

const Courses = () => {
    const [courses, setCourses] = useState([])

    const deleteCourse = (e, id) =>{
        e.preventDefault()
        axios.delete(`/api/v1/courses/${id}`).then(res => {
            getCourses()
        }).catch(resp => console.log(resp))
    }

    const getCourses = () =>{
        axios.get('/api/v1/courses').then(res => {
            setCourses(res.data)
        }).catch(resp => console.log(resp))
    }

    useEffect(() => {
        getCourses()
    },[]); 
    
    const list = courses.map(item => {
        return (<tr key={item.id} >
            <td>{item.id}</td>
            <td>{item.name}</td>
            <td>
                <Link className='btn btn-primary me-1' to={`/courses/${item.id}`} >Show</Link>
                <Link className='btn btn-warning me-1' to={`/courses/${item.id}/edit`} >Edit</Link>
                <a className='btn btn-danger' onClick={e => deleteCourse(e, item.id)}>Delete</a>
            </td>
        </tr>)
    })



    return(
        <div className='container'>
            <div className='row'>
                <div className='col-md-11'></div>
                <div className='col-md-1'>
                    <Link className='btn btn-info' to={`/courses/new`} >New</Link>
                </div>
            </div>
            <div className='row'>
            <table className='table'>
                <thead>
                    <tr>
                        <th scope="col">Id</th>
                        <th scope="col">Name</th>
                        <th scope="col">Options</th>
                    </tr>
                </thead>
                <tbody>
                    {list.length
                        ? list
                        : <tr><td className='text-center' colSpan="3">No data</td></tr>
                    }
                </tbody>
            </table>
            </div>
        </div>
    )
}

export default Courses