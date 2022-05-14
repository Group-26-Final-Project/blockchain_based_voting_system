import React from 'react'
import UsersTable, { Detail } from './UsersTable';
import { UsersData } from './UsersData';

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

    return (
        <div class="min-h-screen w-full bg-white-800 flex flex-col justify-center items-center py-4 px-4 lg:px-8">
            <div class="w-full py-4 px-4 lg:px-8 rounded-2xl bg-white-700">
                <UsersTable columns={columns} data={UsersData} />
            </div>
        </div>
    )
}