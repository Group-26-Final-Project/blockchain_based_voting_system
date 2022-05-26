import React, {useState} from 'react'
import { SidebarData } from './SidebarData'
import { NavLink } from 'react-router-dom'
import { classNames } from '../shared/Utils'

export default function Sidebar() {
    const [status, setStatus] = useState(window.location.pathname)

    function changePage(location){
        setStatus(location)
    }
    return (
        // <div className="top-0 left-0 fixed grid grid-cols-1 gap-3 bg-[#2F313D] w-[25vw] h-full p-10 content-center">
        <div className="grid grid-cols-1 gap-3 bg-[#2F313D] h-screen md:p-6 lg:p-10 content-center">
            {SidebarData.map((val, key) => {
                const temp = status === val.link ? "active" : "notactive"
                // console.log(val, temp)
                return (
                    <div key={key} onClick={()=>changePage(val.link)}>
                        <NavLink to={val.link}>
                            <div className={classNames("h-[7vh] flex flex-row items-center p-3 justify-start rounded-md", temp.startsWith('active') ? "bg-[#00D05A]/10": 'bg-[#2F313D]' )}>
                                <div className={classNames("text-xl hidden lg:block", temp.startsWith('active') ? 'text-[#00D05A]' : 'text-white' )}>{val.icon}</div>
                                <h2 className={classNames("p-6", temp.startsWith('active') ? 'text-[#00D05A]' : 'text-white')}>{val.title}</h2>
                            </div>
                        </NavLink>
                    </div>
                )
            })}
        </div>
    )
}