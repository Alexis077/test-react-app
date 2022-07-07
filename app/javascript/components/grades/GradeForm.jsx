import React from  'react'
import { useState, useEffect } from 'react';
import { useParams, Link } from 'react-router-dom';
import axios from 'axios';

const GradeForm = (props) => {
    const [name, setName] = useState("")
    const [lastName, setLastName] = useState("")
    const [students, setStudents] = useState([])
    const [courses, setCourses] = useState([])
    const [student, setStudent] = useState("")
    const [course, setCourse] = useState("")
    const [score, setScore] = useState("")
    const [quarter, setQuarter] = useState("")
    const {id} = useParams();

    const handleSubmit = (evt) => {
        evt.preventDefault();
        props.handleSubmit(student, course, quarter, score)
    }
    useEffect(() => {
        axios.get(`/api/v1/students`).then(res => {
            setStudents(res.data)
        }).catch(resp => console.log(resp))

        axios.get(`/api/v1/courses`).then(res => {
            setCourses(res.data)
        }).catch(resp => console.log(resp))
        if (id){
            axios.get(`/api/v1/grades/${id}`).then(res => {
                setStudent(res.data.student ? res.data.student.id : "")
                setCourse(res.data.course ? res.data.course.id : "")
                setQuarter(res.data.quarter ? res.data.quarter : "")
                setScore(res.data.score? res.data.score : "")
            }).catch(resp => console.log(resp))
        }
    },[]); 

    const studentList = students.map(item => {
        return (<option key={item.id} value={item.id}>{item.name} {item.last_name}</option>)
    })

    const courseList = courses.map(item => {
        return (<option key={item.id} value={item.id}>{item.name}</option>)
    })
    
    return(
    <div className='container' style={{marginTop: '150px'}}>
      <form onSubmit={handleSubmit}>
        <div className='row'>
            <div className='col'>
                <div className="input-group mb-3">
                    <select className="form-select" value={student} onChange={e => setStudent(e.target.value)}>
                        <option value="">Select an Option</option>
                        {studentList}
                    </select>
                </div>
            </div>
            <div className='col'>
                <div className="input-group mb-3">
                    <select className="form-select" value={course} onChange={e => setCourse(e.target.value)}>
                        <option value="">Select an Option</option>
                        {courseList}
                    </select>
                </div>
            </div>
            <div className='col'>
                <div className="input-group mb-3">
                    <select className="form-select" value={quarter} onChange={e => setQuarter(e.target.value)}>
                        <option value="">Select an Option</option>
                        <option value="q1">Quarter 1</option>
                        <option value="q2">Quarter 2</option>
                        <option value="q3">Quarter 3</option>
                        <option value="q4">Quarter 4</option>
                    </select>
                </div>
            </div>
            <div className='col'>
                <div className="input-group mb-3">
                    <span className="input-group-text" id="inputGroup-sizing-default">Score</span>
                    <input type="text" className="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default"  value={score} onChange={e => setScore(e.target.value)}/>
                </div>
            </div>
        </div>
        <div className='row'>
            <div className='col'>
                <div className='col'><Link className='btn btn-secondary' to="/grades">Back</Link></div>
            </div>
            <div className='col'>
                <input className='btn btn-primary' type="submit" value="Submit" />
            </div>
        </div>
      </form>
    </div>)
}

export default GradeForm