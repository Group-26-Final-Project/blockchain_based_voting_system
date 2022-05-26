import React from 'react'
import { AiOutlineUserAdd } from "react-icons/ai";
import { IoHomeSharp } from "react-icons/io5";
import { BsListTask } from "react-icons/bs";
import { FaUserLock } from "react-icons/fa";
import { MdHowToVote } from "react-icons/md";

export const SidebarData = [
    {
        title: 'Home',
        icon: <IoHomeSharp/>,
        link: "/" 
    },
    {
        title: 'Elections',
        icon: <MdHowToVote/>,
        link: "/elections" 
    },
    {
        title: 'Voters',
        icon: <AiOutlineUserAdd/>,
        link: "/voters" 
    },
    {
        title: 'Candidates',
        icon: <BsListTask/>,
        link: "/candidates" 
    },
    {
        title: 'Blacklist',
        icon: <FaUserLock/>,
        link: "/blacklist" 
    },
]