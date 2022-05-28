import React, { useEffect } from 'react'
import { useNavigate, useLocation } from "react-router-dom";
import { SpinnerCircularFixed } from "spinners-react";
import UserContract from "../contracts/AAiTUser.json";
import { useMoralis, useWeb3ExecuteFunction } from "react-moralis";

export default function VoterDetail() {
    const { isInitialized, isWeb3Enabled, account, enableWeb3, Moralis } = useMoralis();
    let location = useLocation();
    let navigate = useNavigate();
    const voterEmail = location.state

    const {
        data: voterDetail,
        error: getVoterDetailError,
        fetch: getVoterDetail,
        isLoading: isGetAllVoterDetailLoading,
    } = useWeb3ExecuteFunction({
        contractAddress: process.env.REACT_APP_AAITUSER_CONTRACT_ADDRESS,
        functionName: "getUserByEmail",
        abi: UserContract.abi,
        params: {
            email: voterEmail
        }
    });

    const deptTypes = [
        "Biomedical Engineering",
        "Chemical Engineering",
        "Civil Engineering",
        "Electrical Engineering",
        "Mechanical Engineering",
        "Software Engineering",
      ];

    const onCancel = () => {
        navigate(-1);
    }

    useEffect(() => {
        const fetchData = async () => {
            await enableWeb3();
            await getVoterDetail();
        }
        if (isInitialized && isWeb3Enabled) {
            fetchData();
        } else {
            enableWeb3();
        }
    }, [enableWeb3, getVoterDetail, isInitialized, isWeb3Enabled]);

    return (
        <div class="min-h-screen w-full bg-white-800 flex flex-col justify-center items-center py-4 px-4 lg:px-8">
            {isGetAllVoterDetailLoading && (
                <div>
                    <SpinnerCircularFixed
                        size={50}
                        thickness={100}
                        speed={100}
                        color="#36ad47"
                        secondaryColor="rgba(0, 0, 0, 0.44)"
                    />
                </div>
            )}
            {getVoterDetailError && (
                <div>
                    <h3>Ooops something went wrong</h3>
                    <button onClick={() => window.location.reload(false)}>Reload!</button>
                    {/* <h2>{getVotersError.message}</h2> */}
                </div>
            )}
            {voterDetail && !isGetAllVoterDetailLoading && (
                <div class="min-h-screen w-full bg-white-800">
                    <div class="flex flex-col justify-center items-center py-8 px-8 lg:px-16">
                        {/* <div class="relative w-28 h-28">
                            <img class="rounded-full border border-gray-100 shadow-sm object-cover" alt="" src="https://randomuser.me/api/portraits/women/81.jpg" />
                        </div> */}
                        <div>
                            <h2 class="my-4 text-xl font-bold text-gray-900">{voterDetail.zvoter.voterInfo.fullName}</h2>
                        </div>
                        <div class="w-[50vw] py-2 px-4 lg:px-8">
                            <div class="flex flex-row justify-between items-center mb-6 md:mb-1">
                                <label class="w-full md:w-1/3 px-3 block tracking-wide text-gray-700 text-xs font-bold my-2 mx-4" for="grid-name">
                                    Name
                                </label>
                                <input class="appearance-none block w-full md:w-2/3 bg-white-200 text-sm text-gray-700 border border-gray-200 rounded py-2 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" readOnly={true} id="grid-name" name='name' type="text" value={voterDetail.zvoter.voterInfo.fullName.split(' ')[0]} />
                            </div>
                            <div class="flex flex-row justify-between items-center mb-6 md:mb-1">
                                <label class="w-full md:w-1/3 px-3 block tracking-wide text-gray-700 text-xs font-bold my-2 mx-4" for="grid-fname">
                                    Father's Name
                                </label>
                                <input class="appearance-none block w-full md:w-2/3 bg-white-200 text-sm text-gray-700 border border-gray-200 rounded py-2 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" readOnly={true} id="grid-fname" name='fname' type="text" value={voterDetail.zvoter.voterInfo.fullName.split(' ')[1]} />
                            </div>
                            <div class="flex flex-row justify-between items-center mb-6 md:mb-1">
                                <label class="w-full md:w-1/3 px-3 block tracking-wide text-gray-700 text-xs font-bold my-2 mx-4" for="grid-gname">
                                    Grandfather's Name
                                </label>
                                <input class="appearance-none block w-full md:w-2/3  bg-white-200 text-sm text-gray-700 border border-gray-200 rounded py-2 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" readOnly={true} id="grid-gname" name='gname' type="text" value={voterDetail.zvoter.voterInfo.fullName.split(' ')[2]} />
                            </div>
                            <div class="flex flex-row justify-between items-center">
                                <label class="w-full md:w-1/3 px-3  block tracking-wide text-gray-700 text-xs font-bold my-2 mx-4" for="grid-id">
                                    ID
                                </label>
                                <input class="appearance-none block w-full md:w-2/3  bg-white-200 text-sm text-gray-700 border border-gray-200 rounded py-2 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" readOnly={true} id="grid-id" name='id' type="text" value={voterDetail.zvoter.voterInfo.studentId} />
                            </div>
                            <div class="flex flex-row justify-between items-center">
                                <label class="w-full md:w-1/3 px-3  block tracking-wide text-gray-700 text-xs font-bold my-2 mx-4" for="grid-email">
                                    Email
                                </label>
                                <input class="appearance-none block w-full md:w-2/3  bg-white-200 text-sm text-gray-700 border border-gray-200 rounded py-2 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" readOnly={true} id="grid-email" name='email' type="text" value={voterDetail.zvoter.voterInfo.email} />
                            </div>
                            <div class="flex flex-row justify-between items-center">
                                <label class="w-full md:w-1/3 px-3  block tracking-wide text-gray-700 text-xs font-bold my-2 mx-4" for="grid-phone">
                                    Phone Number
                                </label>
                                <input class="appearance-none block w-full md:w-2/3  bg-white-200 text-sm text-gray-700 border border-gray-200 rounded py-2 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" readOnly={true} id="grid-phone" name='phone' type="text" value={voterDetail.zvoter.voterInfo.phone} />
                            </div>
                            <div class="flex flex-row justify-between items-center mb-6 md:mb-1">
                                <label class="w-full md:w-1/3 px-3 block tracking-wide text-gray-700 text-xs font-bold my-2 mx-4" for="grid-dept">
                                    Department
                                </label>
                                <input class="appearance-none block w-full md:w-2/3 bg-white-200 text-sm text-gray-700 border border-gray-200 rounded py-2 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" readOnly={true} id="grid-dept" name='dept' type="text"  value={deptTypes[voterDetail.zvoter.voterInfo.currentDepartment]} />
                            </div>
                            <div class="flex flex-row justify-between items-center mb-6 md:mb-1">
                                <label class="w-full md:w-1/3 px-3 block tracking-wide text-gray-700 text-xs font-bold my-2 mx-4" for="grid-year">
                                    Year
                                </label>
                                <input class="appearance-none block w-full md:w-2/3 bg-white-200 text-sm text-gray-700 border border-gray-200 rounded py-2 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" readOnly={true} id="grid-year" name='year' type="text" value={voterDetail.zvoter.voterInfo.currentYear} />
                            </div>
                            <div class="flex flex-row justify-between items-center">
                                <label class="w-full md:w-1/3 px-3  block tracking-wide text-gray-700 text-xs font-bold my-2 mx-4" for="grid-sect">
                                    Section
                                </label>
                                <input class="appearance-none block w-full md:w-2/3  bg-white-200 text-sm text-gray-700 border border-gray-200 rounded py-2 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" readOnly={true} id="grid-sect" name='sect' type="text" value={voterDetail.zvoter.voterInfo.currentSection} />
                            </div>
                        </div>
                    </div>
                    <div class="flex flex-row justify-end">
                        <div class="bg-[#C70039] float-right text-white border border-white text-center py-3 mr-2 px-4 rounded-xl font-body font-light text-sm">
                            <button>Remove Voter</button>
                        </div>
                        <div class="bg-white float-right text-[#00D05A] border border-[#00D05A] text-center py-3 px-4 mr-10 rounded-xl font-body font-light text-sm">
                            <button onClick={onCancel}>Cancel</button>
                        </div>
                    </div>
                </div >
            )}
        </div>
    );
}