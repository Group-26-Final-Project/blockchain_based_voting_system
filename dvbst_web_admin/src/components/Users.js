import React from 'react'
import UsersTable, { Detail } from './UsersTable';

export default function Users() {
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
            Header: "",
            accessor: "details",
            Cell: Detail,
        },
    ], 
    []);
    const rowdata = [
        {
            name: "Kaleb Mesfin",
            sect: 2,
            year: 5,
            dept: "Software Engineering",
            details: 1,
        },
        {
            name: "Hanna Samuel",
            sect: 3,
            year: 5,
            dept: "Software Engineering",
            details: 2,
        },
        {
            name: "Daniel Terefe",
            sect: 2,
            year: 5,
            dept: "Software Engineering",
            details: 3,
        },
        {
            name: "Kaleb Mesfin",
            sect: 2,
            year: 5,
            dept: "Software Engineering",
            details: 1,
        },
        {
            name: "Hanna Samuel",
            sect: 3,
            year: 5,
            dept: "Software Engineering",
            details: 2,
        },
        {
            name: "Daniel Terefe",
            sect: 2,
            year: 5,
            dept: "Software Engineering",
            details: 3,
        },
        {
            name: "Kaleb Mesfin",
            sect: 2,
            year: 5,
            dept: "Software Engineering",
            details: 1,
        },
        {
            name: "Hanna Samuel",
            sect: 3,
            year: 5,
            dept: "Software Engineering",
            details: 2,
        },
        {
            name: "Daniel Terefe",
            sect: 2,
            year: 5,
            dept: "Software Engineering",
            details: 3,
        },        {
            name: "Kaleb Mesfin",
            sect: 2,
            year: 5,
            dept: "Software Engineering",
            details: 1,
        },
        {
            name: "Hanna Samuel",
            sect: 3,
            year: 5,
            dept: "Software Engineering",
            details: 2,
        },
        {
            name: "Daniel Terefe",
            sect: 2,
            year: 5,
            dept: "Software Engineering",
            details: 3,
        },        
        {
            name: "Kaleb Mesfin",
            sect: 2,
            year: 5,
            dept: "Software Engineering",
            details: 1,
        },
        {
            name: "Hanna Samuel",
            sect: 3,
            year: 5,
            dept: "Software Engineering",
            details: 2,
        },
        {
            name: "Daniel Terefe",
            sect: 2,
            year: 5,
            dept: "Software Engineering",
            details: 3,
        },
    ]
    return (
        <div class="min-h-screen w-full bg-white-800 flex flex-col justify-center items-center py-4 px-4 lg:px-8">
            <div class="w-full py-4 px-4 lg:px-8 rounded-2xl bg-white-700">
                <UsersTable columns={columns} data={rowdata} />
            </div>
        </div>
    )
}