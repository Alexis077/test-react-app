import React from  'react'
import { useState, useEffect } from 'react';
import { useParams, Link } from 'react-router-dom';
import axios from 'axios';

const Course = () => {
    const [course, setCourse] = useState({})
    const {id} = useParams();
    useEffect(() => {
        axios.get(`/api/v1/courses/${id}`).then(res => {
            setCourse(res.data)
        }).catch(resp => console.log(resp))
    },[]); 

    return(
    <div className='container' style={{marginTop: '150px'}}>
        <div className='row'>
            <div className='col'>
                <label><b>Name</b></label>: {course.name}
            </div>
        </div>
        <div className='row'>
            <div className='col'><Link className='btn btn-secondary' to="/courses">Back</Link></div>
        </div>
    </div>)
}

export default Course