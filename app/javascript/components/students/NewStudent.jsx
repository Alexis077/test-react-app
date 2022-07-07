import React from  'react'
import axios from 'axios';
import StudentForm from './StudentForm';
import {useNavigate} from 'react-router-dom';

const NewStudent = () => {
    const navigate = useNavigate();
    const handleSubmit = (name, lastName) => {
        axios.post(`/api/v1/students`, {name, last_name: lastName})
        .then(res => navigate("/students"))
        .catch(resp => console.log(resp))
    }

    return(<StudentForm handleSubmit={handleSubmit}/>)
}
export default NewStudent