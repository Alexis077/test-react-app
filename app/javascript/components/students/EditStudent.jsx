import React from  'react'
import { useParams, useNavigate } from 'react-router-dom';
import axios from 'axios';
import StudentForm from './StudentForm';

const EditStudent = () => {
    const navigate = useNavigate();
    const {id} = useParams();

    const handleSubmit = (name, lastName) => {
        axios.put(`/api/v1/students/${id}`, {name, last_name: lastName})
        .then(res => navigate('/students'))
        .catch(resp => console.log(resp))
    }    
    return(<StudentForm handleSubmit={handleSubmit}/>)
}
export default EditStudent