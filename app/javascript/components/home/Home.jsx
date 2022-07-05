import React from 'react'
import {
    Link
  } from "react-router-dom";
const Home = () => {
    return(
        <div className='container'>
            <div className='row'>
                <div className='col'>
                    <Link to="/students">Students</Link>
                </div>
                <div className='col'>
                    <Link to="/courses">Courses</Link>
                </div>
            </div>
        </div>
    )
}
export default Home
