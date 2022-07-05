import React from 'react'
import {
    BrowserRouter,
    Routes,
    Route,
  } from "react-router-dom";
import Home from '../components/home/Home'
import Students from '../components/students/Students'
import Courses from '../components/courses/Courses'

const App = () => {
    return(  
    <BrowserRouter>
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/students" element={<Students />} />
          <Route path="/courses" element={<Courses />} />
        </Routes>
    </BrowserRouter>)
}
export default App

