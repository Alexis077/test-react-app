import React from  'react'
import { useParams, useNavigate } from 'react-router-dom';
import axios from 'axios';
import CourseForm from './CourseForm';

const EditCourse = () => {
    const navigate = useNavigate();
    const {id} = useParams();

    const handleSubmit = (name) => {
        axios.put(`/api/v1/courses/${id}`, {name})
        .then(res => navigate('/courses'))
        .catch(resp => console.log(resp))
    }    
    return(<CourseForm handleSubmit={handleSubmit}/>)
}
export default EditCourse