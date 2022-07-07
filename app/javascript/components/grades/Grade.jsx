import React from  'react'
import { useState, useEffect } from 'react';
import { useParams, Link } from 'react-router-dom';

import axios from 'axios';

const Grade = () => {
    const [grade, setGrade] = useState({})
    const [student, setStudent] = useState("")
    const [course, setCourse] = useState("")
    const {id} = useParams();
    useEffect(() => {
        axios.get(`/api/v1/grades/${id}`).then(res => {
            setGrade(res.data)
            setStudent(res.data.student.name)
            setCourse(res.data.course.name)
        }).catch(resp => console.log(resp))
    },[]); 

    return(
    <div className='container' style={{marginTop: '150px'}}>
        <div className='row'>
            <div className='col'>
                <label><b>Student</b></label>: {student}
            </div>
            <div className='col'>
                <label><b>Course</b></label>: {course}
            </div>
            <div className='col'>
                <label><b>Quarter</b></label>: {grade.quarter}
            </div>
            <div className='col'>
                <label><b>Score</b></label>: {grade.score}
            </div>
        </div>
        <div className='row'>
            <div className='col'><Link className='btn btn-secondary' to="/grades">Back</Link></div>
        </div>
    </div>)
}

export default Grade