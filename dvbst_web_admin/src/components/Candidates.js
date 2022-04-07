import React from 'react'
import CandidatesTable, { Detail, Lock, StatusPill } from './CandidatesTable'
import { candidatesData } from './CandidatesData'
// import { useUsersQuery } from '../services/usersApi';

export default function Candidates() {
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

    // const { data, error, isSuccess } = useUsersQuery();
    return (
        <div class="min-h-screen w-full bg-white-800 flex flex-col justify-center items-center py-4 px-4 lg:px-8">
            <div class="w-full py-4 px-4 lg:px-8 rounded-2xl bg-white-700">
                <CandidatesTable columns={columns} data={candidatesData} />
            </div>
            {/* {error && <div>
                <h2>Something Went Wrong!</h2>
            </div>}
            {isSuccess &&
                <div class="w-full py-4 px-4 lg:px-8 rounded-2xl bg-white-700">
                    <CandidatesTable columns={columns} data={data} />
                </div>
            } */}
        </div>
    )
}