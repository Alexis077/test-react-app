import React from 'react'
import {
    Routes,
    Route,
    Outlet,
  } from "react-router-dom";
import Home from '../components/home/Home'
import Students from '../components/students/Students'
import Student from '../components/students/Student'
import NewStudent from '../components/students/NewStudent'
import EditStudent from '../components/students/EditStudent'
import Courses from '../components/courses/Courses'

const App = () => {
    return(
        <Routes>
            <Route path="/" element={<Home />} />
            <Route path="/students" element={<Students />} />
            <Route path="/students/:id" element={<Student />} />
            <Route path="/students/new" element={<NewStudent />} />
            <Route path="/students/:id/edit" element={<EditStudent />} />
            <Route path="/courses" element={<Courses />} />
        </Routes>
    )
}
export default App
