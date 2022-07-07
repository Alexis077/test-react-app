import React from  'react'
import { useState, useEffect } from 'react';
import axios from 'axios';

const Courses = () => {
    const [students, setStudents] = useState([])
    useEffect(() => {
        axios.get('api/v1/students').then(res => {
            console.log(res.data)
            setStudents(res.data)
        }).catch(resp => console.log(resp))
    },[]); 

    const list = students.map(item => <tr key={item.id} ><td>{item.id}</td><td>{item.name}</td><td>{item.last_name}</td></tr>)

    return(
        <table className='table'>
        <thead>
            <tr>
            <th scope="col">id</th>
            <th scope="col">Name</th>
            <th scope="col">Last name</th>
            </tr>
        </thead>
        <tbody>
            {list}
        </tbody>
        </table>
    )
}

export default Courses