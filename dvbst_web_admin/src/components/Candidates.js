import React, { useEffect } from 'react'
import CandidatesTable, { Detail, Lock, StatusPill } from './CandidatesTable'
import { SpinnerCircularFixed } from "spinners-react";
import StudentContract from "../contracts/AAiTStudent.json";
import { useMoralis, useWeb3ExecuteFunction } from "react-moralis";
// import { candidatesData } from './CandidatesData'

export default function Candidates() {
    const { isInitialized, isWeb3Enabled, account, enableWeb3, Moralis } = useMoralis();

    const {
        data: candidatesData,
        error: getCandidatesError,
        fetch: getAllCandidates,
        isLoading: isGetAllCandidatesLoading,
    } = useWeb3ExecuteFunction({
        contractAddress: process.env.REACT_APP_AAITSTUDENT_CONTRACT_ADDRESS,
        functionName: "getAllCandidates",
        abi: StudentContract.abi,
    });

    const fetchAllCandidates = (candidatesData) => {
        var candidates = [];
        if (candidatesData && candidatesData.length > 0) {
            for (var i = 0; i < candidatesData.length; i++) {
                var candidate = {
                    name:
                        candidatesData[i].candidateInfo.fName +
                        " " +
                        candidatesData[i].candidateInfo.lName +
                        " " +
                        candidatesData[i].candidateInfo.gName,
                    sect: candidatesData[i].candidateInfo.currentSection.toNumber(),
                    year: candidatesData[i].candidateInfo.currentYear.toNumber(),
                    dept: candidatesData[i].candidateInfo.currentDepartment,
                    status: "Active",
                    lock: true,
                    details: i,
                };
                candidates.push(candidate);
            }
        }
        return candidates;
    };

    const fetchData = async () => {
        await enableWeb3();
        await getAllCandidates();
    };

    useEffect(() => {
        if (isInitialized && isWeb3Enabled) {
            fetchData();
        } else {
            enableWeb3();
        }
    }, [isInitialized, isWeb3Enabled]);

    const columns = React.useMemo(() =>
    [
        {
            Header: "Name",
            accessor: "name",
        },
        {
            Header: "Section",
            accessor: "sect",
        },
        {
            Header: "Year",
            accessor: "year",
        },
        {
            Header: "Department",
            accessor: "dept",
        },
        {
            Header: "Status",
            accessor: "status",
            Cell: StatusPill,
        },
        {
            Header: "",
            accessor: "lock",
            Cell: Lock,
        },
        {
            Header: "",
            accessor: "details",
            Cell: Detail,
        },
    ],
    []);

    return (
        <div class="min-h-screen w-full bg-white-800 flex flex-col justify-center items-center py-4 px-4 lg:px-8">
            {isGetAllCandidatesLoading && (
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
            {getCandidatesError && (
                <div>
                    <h3>Ooops something went wrong</h3>
                    <h2>{getCandidatesError.message}</h2>
                </div>
            )}
            < div class="w-full py-4 px-4 lg:px-8 rounded-2xl bg-white-700">
                <CandidatesTable columns={columns} data={fetchAllCandidates(candidatesData)} />
            </div>
        </div >
    )
}