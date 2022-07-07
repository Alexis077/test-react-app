import React from  'react'
import { useParams, useNavigate } from 'react-router-dom';
import axios from 'axios';
import GradeForm from './GradeForm';

const EditGrade = () => {
    const navigate = useNavigate();
    const {id} = useParams();

    const handleSubmit = (student, course, quarter, score) => {
        axios.put(`/api/v1/grades/${id}`, {student_id: student, course_id: course, quarter, score})
        .then(res => navigate('/grades'))
        .catch(resp => console.log(resp))
    }    
    return(<GradeForm handleSubmit={handleSubmit}/>)
}
export default EditGrade