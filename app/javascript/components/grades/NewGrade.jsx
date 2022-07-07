import React from  'react'
import axios from 'axios';
import GradeForm from './GradeForm';
import {useNavigate} from 'react-router-dom';

const NewGrade = () => {
    const navigate = useNavigate();
    const handleSubmit = (student, course, quarter, score) => {
        console.log({student, course, quarter, score})
        axios.post(`/api/v1/grades`, {grade:{student_id: student, course_id: course, quarter, score}})
        .then(res => navigate("/grades"))
        .catch(resp => console.log(resp))
    }

    return(<GradeForm handleSubmit={handleSubmit}/>)
}
export default NewGrade