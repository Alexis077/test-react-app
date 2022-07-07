import React from  'react'
import { useState, useEffect } from 'react';
import { useParams, useNavigate, Link } from 'react-router-dom';

import axios from 'axios';

const Student = () => {
    const [student, setStudent] = useState({})
    const {id} = useParams();
    useEffect(() => {
        axios.get(`/api/v1/students/${id}`).then(res => {
            setStudent(res.data)
        }).catch(resp => console.log(resp))
    },[]); 

    return(
    <div className='container' style={{marginTop: '150px'}}>
        <div className='row'>
            <div className='col'>
                <label><b>Name</b></label>: {student.name}
            </div>
            <div className='col'>
                <label><b>Last name</b></label>: {student.last_name}
            </div>
        </div>
        <div className='row'>
            <div className='col'><Link className='btn btn-secondary' to="/students">Back</Link></div>
        </div>
    </div>)
}

export default Student