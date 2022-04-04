import React from 'react'
import HomeTable, { StatusPill } from './HomeTable'

export default function Home() {
    const columns = React.useMemo(() => 
    [
        {
            Header: "No.",
            accessor: "number",
        },
        {
            Header: "Election Name",
            accessor: "name",
        },
        {
            Header: "Status",
            accessor: "status",
            Cell: StatusPill,
        },
    ], 
    []);
    const rowdata = [
        {
            number: 1,
            name: "Software Engineering Year 1 Section 1 Election",
            status: "Finished"
        },
        {
            number: 2,
            name: "Software Engineering Year 1 Section 2 Election",
            status: "Ongoing"
        },
        {
            number: 3,
            name: "Software Engineering Year 1 Section 3 Election",
            status: "Pending"
        },
    ]
    return (
        <div class="h-screen w-full bg-white-800 flex flex-col overflow-auto justify-center items-center py-8 px-8 lg:px-16">
            <div class="w-full bg-[#2F313D] flex py-8 px-4 lg:px-8 rounded-xl">
                <div class="px-1">
                    <h3 class="text-md text-white font-body font-semibold">Ongoing</h3>
                    <h2 class="text-3xl text-white font-body font-bold">12</h2>
                    <p class="text-sm text-white font-body font-light">Lorem ipsum dolor sit amet, consectetur adipiscing elit. </p>
                </div>
                <div class="px-1">
                    <h3 class="text-md text-white font-body font-semibold">Finished</h3>
                    <h2 class="text-3xl text-white font-body font-bold">3</h2>
                    <p class="text-sm text-white font-body font-light">Lorem ipsum dolor sit amet, consectetur adipiscing elit. </p>
                </div>
                <div class="px-1">
                    <h3 class="text-md text-white font-body font-semibold">Pending</h3>
                    <h2 class="text-3xl text-white font-body font-bold">5</h2>
                    <p class="text-sm text-white font-body font-light">Lorem ipsum dolor sit amet, consectetur adipiscing elit. </p>
                </div>
            </div>
            <div class="w-full flex py-8 px-4 mt-8 lg:px-8 rounded-2xl bg-white-700">
                <HomeTable columns={columns} data={rowdata} />
            </div>
        </div>
    )
}