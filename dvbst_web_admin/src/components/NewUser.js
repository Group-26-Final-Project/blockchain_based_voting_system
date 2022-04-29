import React, { useState } from 'react'
// import User from '../models/user.model'
// import { useAddUserMutation } from '../services/usersApi'

export default function NewUser() {
    const [name, setName] = useState("")
    const [fname, setFname] = useState("")
    const [gname, setGname] = useState("")
    const [dept, setDept] = useState("--Select--")
    const [sect, setSect] = useState("--Select--")
    const [year, setYear] = useState("--Select--")
    const [id, setId] = useState("")
    const [phone, setPhone] = useState("")
    const [wallet, setWallet] = useState("")
    const [bio, setBio] = useState("")
    const [profile, setProfile] = useState()
    const [isFilePicked, setIsFilePicked] = useState(false);
    const [candidate, setCandidate] = useState(false)

    // const [addUser] = useAddUserMutation();
    // const user = User(name, fname, gname, id, dept, sect, year, wallet);


	const changeHandler = (event) => {
		setProfile(event.target.files[0]);
		setIsFilePicked(true);
	};

    const checkCandidate = () => {
        setCandidate(!candidate)
    }

    const handleSubmit = async (e) => {
        e.preventDefault();
        // await addUser(user);
    }

    return (
        <div class="min-h-screen w-full bg-white-800 flex flex-row align-center content-center py-8 px-4 lg:px-8">
            <div class="w-[50vw]">
                <div class="sm:mx-auto sm:w-full sm:max-w-md">
                    <h2 class="mt-6 mb-6 text-left text-2xl font-extrabold text-gray-900">Add New User</h2>
                </div>
                <form class="w-full max-w-lg sm:mx-auto sm:w-full sm:max-w-md">
                    <div class="flex flex-wrap -mx-3 mb-3">
                        <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                            <label class="block tracking-wide text-gray-700 text-xs font-bold mb-2" for="grid-name">
                                Name
                            </label>
                            <input class="appearance-none block w-full bg-white-200 text-sm text-gray-700 border border-gray-200 rounded py-2 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" id="grid-name" type="text" value={name} onChange={(e) => setName(e.target.value)} />
                            {/* <input class="appearance-none block w-full bg-gray-200 text-gray-700 border border-red-500 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-name" type="text" placeholder="Enter First Name" /> */}
                            {/* <p class="text-red-500 text-xs italic">Please fill out this field.</p> */}
                        </div>
                        <div class="w-full md:w-1/2 px-3">
                            <label class="block tracking-wide text-gray-700 text-xs font-bold mb-2" for="grid-father-name">
                                Father's Name
                            </label>
                            <input class="appearance-none block w-full bg-white-200 text-sm text-gray-700 border border-gray-200 rounded py-2 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" id="grid-father-name" type="text" value={fname} onChange={(e) => setFname(e.target.value)} />
                        </div>
                    </div>
                    <div class="flex flex-wrap -mx-3 mb-3">
                        <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                            <label class="block tracking-wide text-gray-700 text-xs font-bold mb-2" for="grid-grand-name">
                                Grandfather's Name
                            </label>
                            <input class="appearance-none block w-full bg-white-200 text-sm text-gray-700 border border-gray-200 rounded py-2 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" id="grid-grand-name" type="text" value={gname} onChange={(e) => setGname(e.target.value)} />
                        </div>
                        <div class="w-full md:w-1/2 px-3">
                            <label class="block tracking-wide text-gray-700 text-xs font-bold mb-2" for="grid-id">
                                ID
                            </label>
                            <input class="appearance-none block w-full bg-white-200 text-sm text-gray-700 border border-gray-200 rounded py-2 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" id="grid-id" type="text" value={id} onChange={(e) => setId(e.target.value)} />
                        </div>
                    </div>
                    <div class="flex flex-wrap -mx-3 mb-3">
                        <div class="w-full md:w-full px-3 mb-6 md:mb-0">
                            <label class="block tracking-wide text-gray-700 text-xs font-bold mb-2" for="grid-dept">
                                Department
                            </label>
                            <div class="relative">
                                <select class="block appearance-none w-full bg-white-200 text-sm text-gray-700 border border-gray-200 text-gray-700 py-2 px-4 pr-8 rounded leading-tight focus:outline-none focus:bg-white focus:border-gray-500" id="grid-dept" value={dept} onChange={(e) => setDept(e.target.value)}>
                                    <option>--Select--</option>
                                    <option>Biomedical Engineering</option>
                                    <option>Chemical Engineering</option>
                                    <option>Civil Engineering</option>
                                    <option>Electrical Engineering</option>
                                    <option>Leather Engineering</option>
                                    <option>Mechanical Engineering</option>
                                    <option>Software Engineering</option>
                                    <option>Information Technology</option>
                                </select>
                                <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                                    <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z" /></svg>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="flex flex-wrap -mx-3 mb-3">
                        <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                            <label class="block tracking-wide text-gray-700 text-xs font-bold mb-2" for="grid-year">
                                Year
                            </label>
                            <div class="relative">
                                <select class="block appearance-none w-full bg-white-200 text-sm text-gray-700 border border-gray-200 text-gray-700 py-2 px-4 pr-8 rounded leading-tight focus:outline-none focus:bg-white focus:border-gray-500" id="grid-section" value={year} onChange={(e) => setYear(e.target.value)}>
                                    <option>--Select--</option>
                                    <option>1</option>
                                    <option>2</option>
                                    <option>3</option>
                                    <option>4</option>
                                    <option>5</option>
                                </select>
                                <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                                    <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z" /></svg>
                                </div>
                            </div>
                        </div>
                        <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                            <label class="block tracking-wide text-gray-700 text-xs font-bold mb-2" for="grid-section">
                                Section
                            </label>
                            <div class="relative">
                                <select class="block appearance-none w-full bg-white-200 text-sm text-gray-700 border border-gray-200 text-gray-700 py-2 px-4 pr-8 rounded leading-tight focus:outline-none focus:bg-white focus:border-gray-500" id="grid-section" value={sect} onChange={(e) => setSect(e.target.value)}>
                                    <option>--Select--</option>
                                    <option>1</option>
                                    <option>2</option>
                                    <option>3</option>
                                </select>
                                <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                                    <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z" /></svg>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="flex flex-wrap -mx-3 mb-3">
                        <div class="w-full md:w-full px-3 mb-6 md:mb-0">
                            <label class="block tracking-wide text-gray-700 text-xs font-bold mb-2" for="grid-phone">
                                Phone Number
                            </label>
                            <input class="appearance-none block w-full bg-white-200 text-sm text-gray-700 border border-gray-200 rounded py-2 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" id="grid-phone" type="tel" value={phone} onChange={(e) => setPhone(e.target.value)} />
                            {/* <p class="text-gray-600 text-xs italic">Make it as long and as crazy as you'd like</p> */}
                        </div>
                    </div>
                    <div class="flex flex-wrap -mx-3 mb-3">
                        <div class="w-full md:w-full px-3 mb-6 md:mb-0">
                            <label class="block tracking-wide text-gray-700 text-xs font-bold mb-2" for="grid-wallet">
                                Wallet Address
                            </label>
                            <input class="appearance-none block w-full bg-white-200 text-sm text-gray-700 border border-gray-200 rounded py-2 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" id="grid-wallet" type="text" value={wallet} onChange={(e) => setWallet(e.target.value)} />
                            {/* <p class="text-gray-600 text-xs italic">Make it as long and as crazy as you'd like</p> */}
                        </div>
                    </div>
                    {candidate && (
                        <div>
                            <hr />
                            <div class="flex flex-wrap -mx-3 mb-3">
                                <div class="w-full md:w-full px-3 mb-6 md:mb-0">
                                    <label class="block tracking-wide text-gray-700 text-xs font-bold mb-2" for="grid-bio">
                                        Bio
                                    </label>
                                    <textarea class="appearance-none block w-full bg-white-200 text-sm text-gray-700 border border-gray-200 rounded py-2 px-2 leading-tight focus:outline-none focus:bg-white focus:border-gray-500 resize-none" id="grid-bio" value={bio} onChange={(e) => setBio(e.target.value)} placeholder="Enter Candidate Bio upto 250 characters" rows="4"/>
                                </div>
                            </div>
                            <div class="mb-3 w-96">
                                <label class="block tracking-wide text-gray-700 text-xs font-bold mb-2" for="grid-pic" >Candidate Picture</label>
                                <input class="appearance-none block w-full bg-white-200 text-sm text-gray-700 border border-gray-200 rounded py-2 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" id="grid-pic" type="file" onChange={changeHandler}/>
                            </div>
                        </div>
                    )}
            <div>
                <button type="submit" class="w-full flex justify-center py-3 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-[#00D05A] hover:bg-[#00D05A]/80 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500" onSubmit={handleSubmit}>Add User</button>
            </div>
            <div class="w-full flex items-start items-center py-3">
                <input class="bg-gray-50 border-gray-300 focus:ring-3 focus:ring-blue-300 h-4 w-4 rounded" id="flowbite" aria-describedby="flowbite" type="checkbox" checked={candidate} onChange={checkCandidate} />
                <label class="text-sm ml-3 font-medium text-gray-900" for="flowbite">Users wants to be a Candidate</label>
            </div>
        </form >
            </div >
        </div >
    );
}