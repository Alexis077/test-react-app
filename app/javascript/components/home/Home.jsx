import React from 'react'
import {
    Link, Outlet
  } from "react-router-dom";
const Home = () => {
    return(
        <div className='container'>
            <div className="row" style={{marginTop: '150px'}}>
                <div className="col-sm-6">
                    <div className="card">
                    <div className="card-body">
                        <h5 className="card-title">Students</h5>
                        <Link className='btn btn-primary' to="/students">Show</Link>
                    </div>
                    </div>
                </div>
                <div className="col-sm-6">
                    <div className="card">
                    <div className="card-body">
                        <h5 className="card-title">Curses</h5>
                        <Link className='btn btn-primary' to="/courses">Show</Link>
                    </div>
                    </div>
                </div>
            </div>
        </div>
    )
}
export default Home
