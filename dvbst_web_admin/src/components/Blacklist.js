import React from 'react'
import BlacklistTable, { Detail } from './BlacklistTable'

export default function Blacklist() {
    const columns = React.useMemo(() => 
    [
        {
            Header: "No.",
            accessor: "num",
        },
        {
            Header: "Candidate's Name",
            accessor: "name",
        },
        {
            Header: "Date Added",
            accessor: "date",
        },
        {
            Header: "",
            accessor: "details",
            Cell: Detail,
        },
    ], 
    []);
    const rowdata = [
        {
            num: 1,
            name: "Candidate #1",
            date: "01/01/2022",
            details: 1,
        },
        {
            num: 2,
            name: "Candidate #2",
            date: "02/01/2022",
            details: 2,
        },
        {
            num: 3,
            name: "Candidate #3",
            date: "03/01/2022",
            details: 3,
        },
    ]
    return (
        <div class="min-h-screen w-full bg-white-800 flex flex-col justify-center items-center py-4 px-4 lg:px-8">
            <div class="w-full py-4 px-4 lg:px-8 rounded-2xl bg-white-700">
                <BlacklistTable columns={columns} data={rowdata} />
            </div>
        </div>
    )
}