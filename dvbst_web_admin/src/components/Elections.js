import React from 'react'
import ElectionTable, { Detail, StatusPill } from './ElectionsTable'

export default function Election() {
    const columns = React.useMemo(() => 
    [
        {
            Header: "No.",
            accessor: "num",
        },
        {
            Header: "Election Name",
            accessor: "name",
        },
        {
            Header: "Time Remaining",
            accessor: "time",
        },
        {
            Header: "Status",
            accessor: "status",
            Cell: StatusPill,
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
            name: "Software Engineering Year 1 Section 1 Election",
            time: "05:04:29",
            status: "Pending",
            details: 1
        },
        {
            num: 2,
            name: "Software Engineering Year 1 Section 2 Election",
            time: "05:04:29",
            status: "Ongoing",
            details: 2
        },
        {
            num: 3,
            name: "Software Engineering Year 1 Section 3 Election",
            time: "05:04:29",
            status: "Finished",
            details: 3
        },
    ]
    return (
        <div class="min-h-screen w-full bg-white-800 flex flex-col justify-center items-center py-4 px-4 lg:px-8">
            <div class="w-full py-4 px-4 lg:px-8 rounded-2xl bg-white-700">
                <ElectionTable columns={columns} data={rowdata} />
            </div>
        </div>
    )
}