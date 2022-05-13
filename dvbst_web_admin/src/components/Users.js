import React, { useEffect } from 'react'
import UsersTable, { Detail } from './UsersTable';
// import { UsersData } from './UsersData';
import { SpinnerCircularFixed } from 'spinners-react';
import StudentContract from "../contracts/AAiTStudent.json"
// import { useAPIContract } from "../hooks/useAPIContract";
import { useMoralisWeb3Api, useMoralisWeb3ApiCall } from "react-moralis";

export default function Users() {
    const { native } = useMoralisWeb3Api();
    const options = {
        chain: "eth",
        address: "0x07b2a6A18A8Bc3A954ac6f752E634779263a34AF",
        function_name: "getAllVoters",
        abi: StudentContract.abi,
    };
    const { fetch, data, error, isLoading } = useMoralisWeb3ApiCall(
        native.runContractFunction,
        { ...options }
    );

    console.log(data, error, isLoading)
    useEffect(() => {
        fetch()
    }, [fetch])


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
        [],
    );

    return (
        <div class="min-h-screen w-full bg-white-800 flex flex-col justify-center items-center py-4 px-4 lg:px-8">
            {isLoading && (
                <div>
                    <SpinnerCircularFixed size={50} thickness={100} speed={100} color="#36ad47" secondaryColor="rgba(0, 0, 0, 0.44)" />
                </div>
            )}
            {error && (
                <div>
                    <h3>Ooops something went wrong</h3>
                    <h2>{error.message}</h2>
                </div>
            )}
            {data && (
                <div class="w-full py-4 px-4 lg:px-8 rounded-2xl bg-white-700">
                    <UsersTable columns={columns} data={data} />
                </div>
            )}
        </div>
    )
}


    // const voterOptions = () => {

    // }
    // const { runContractFunction, contractResponse, error, isLoading } = useAPIContract();
    // const onGetAllVoters = ({ onSuccess, onError, onComplete }) => {
    //     runContractFunction({
    //         params: {
    //             chain: "eth",
    //             function_name: "getAllVoters",
    //             abi: StudentContract.abi,
    //             address: "0xABe6fEa796f4908496991ADCdaAFB28616659636"
    //         },
    //         onSuccess,
    //         onError,
    //         onComplete,
    //     });
    // };