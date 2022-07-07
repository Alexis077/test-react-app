import React from  'react'
import axios from 'axios';
import CourseForm from './CourseForm';
import {useNavigate} from 'react-router-dom';

const NewCourse = () => {
    const navigate = useNavigate();
    const handleSubmit = (name) => {
        axios.post(`/api/v1/courses`, {name})
        .then(res => navigate("/courses"))
        .catch(resp => console.log(resp))
    }

    return(<CourseForm handleSubmit={handleSubmit}/>)
}
export default NewCourse