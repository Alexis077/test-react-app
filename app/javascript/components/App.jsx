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
import Course from '../components/courses/Course'
import NewCourse from '../components/courses/NewCourse'
import EditCourse from '../components/courses/EditCourse'

const App = () => {
    return(
        <Routes>
            <Route path="/" element={<Home />} />
            <Route path="/students" element={<Students />} />
            <Route path="/students/:id" element={<Student />} />
            <Route path="/students/new" element={<NewStudent />} />
            <Route path="/students/:id/edit" element={<EditStudent />} />
            <Route path="/courses" element={<Courses />} />
            <Route path="/courses/:id" element={<Course />} />
            <Route path="/courses/new" element={<NewCourse />} />
            <Route path="/courses/:id/edit" element={<EditCourse />} />
        </Routes>
    )
}
export default App
