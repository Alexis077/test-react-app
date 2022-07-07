import React from  'react'
import { useState, useEffect } from 'react';
import { useParams, Link } from 'react-router-dom';
import axios from 'axios';

const CourseForm = (props) => {
    const [name, setName] = useState("")
    const {id} = useParams();

    const handleSubmit = (evt) => {
        evt.preventDefault();
        props.handleSubmit(name)
    }
    useEffect(() => {
        if (id){
            axios.get(`/api/v1/courses/${id}`).then(res => {
                setName(res.data.name ? res.data.name : "")
            }).catch(resp => console.log(resp))
        }
    },[]); 

    return(
    <div className='container' style={{marginTop: '150px'}}>
      <form onSubmit={handleSubmit}>
        <div className='row'>
            <div className='col'>
                <div className="input-group mb-3">
                    <span className="input-group-text" id="inputGroup-sizing-default">Name</span>
                    <input type="text" className="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default"  value={name} onChange={e => setName(e.target.value)}/>
                </div>
            </div>
        </div>
        <div className='row'>
            <div className='col'>
                <div className='col'><Link className='btn btn-secondary' to="/students">Back</Link></div>
            </div>
            <div className='col'>
                <input className='btn btn-primary' type="submit" value="Submit" />
            </div>
        </div>
      </form>
    </div>)
}

export default CourseForm