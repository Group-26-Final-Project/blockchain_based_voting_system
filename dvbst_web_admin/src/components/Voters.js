import React, { useEffect, useState } from "react";
import VotersTable, { Detail } from "./VotersTable";
import { SpinnerCircularFixed } from "spinners-react";
import { AiOutlineClose } from "react-icons/ai";
import UserContract from "../contracts/AAiTUser.json";
import { useMoralis, useWeb3ExecuteFunction } from "react-moralis";
import { useNavigate } from "react-router-dom";

export default function Voters() {
  const [searchQuery, setSearchQuery] = useState("")

    const clearSearch = () => {
        setSearchQuery("")
    }

  const { isInitialized, isWeb3Enabled, account, enableWeb3, Moralis } =
    useMoralis();

  const {
    data: voters,
    error: getAllVotersError,
    fetch: getAllVoters,
    isLoading: getAllVotersLoading,
  } = useWeb3ExecuteFunction({
    //   chain: "eth",
    contractAddress: process.env.REACT_APP_AAITUSER_CONTRACT_ADDRESS,
    functionName: "getAllVoters",
    abi: UserContract.abi,
  });

  const extractVoters = (data) => {
    var voterData = [];
    if (data && data.length > 0) {
      for (var i = 0; i < data.length; i++) {
        console.log("Voters", data[i])
        var voter = {
          name: data[i].voterInfo.fullName,
          sect: data[i].voterInfo.currentSection.toNumber(),
          year: data[i].voterInfo.currentYear.toNumber(),
          dept: data[i].voterInfo.currentDepartment,
          details: i,
        };
        voterData.push(voter);
      }
    }
    return voterData;
  };

  let navigate = useNavigate();
  const routeChange = () => {
    let path = window.location.pathname + '/newvoter';
    navigate(path);
  }

  useEffect(() => {
    const fetchData = async () => {
      await enableWeb3();
      await getAllVoters();
    };
    if (isInitialized && isWeb3Enabled) {
      fetchData();
    } else {
      enableWeb3();
      // authenticate();
    }
  }, [enableWeb3, getAllVoters, isInitialized, isWeb3Enabled]);

  const columns = React.useMemo(
    () => [
      {
        Header: "Full Name",
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
    ],
    []
  );

  return (
    <div class="min-h-screen w-full bg-white-800 flex flex-col justify-center items-center py-4 px-4 lg:px-8">
      {getAllVotersLoading && (
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
      {getAllVotersError && (
        <div>
          <h3>Ooops something went wrong</h3>
          <button onClick={() => window.location.reload(false)}>Reload!</button>
          {/* <h2>{getAllVotersError.message}</h2> */}
        </div>
      )}
      {voters && (
        <div class="w-full py-4 px-4 lg:px-8 rounded-2xl bg-white-700">
          <div class="flex justify-between items-center">
            <div class="p-2 pl-0">
              <label for="table-search" class="sr-only">Search</label>
              <div class="relative flex items-center mt-1">
                <div class="flex absolute inset-y-0 left-0 items-center pl-3 pointer-events-none">
                  <svg class="w-5 h-5 text-gray-500 dark:text-gray-400" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z" clip-rule="evenodd"></path></svg>
                </div>
                <input type="text" id="table-search" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-80 pl-10 p-2.5  dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" onChange={e => setSearchQuery(e.target.value)} value={searchQuery} placeholder="Search..." />
                <div class="p-2 pl-0 -ml-6 text-gray-50">
                  <AiOutlineClose onClick={clearSearch} />
                </div>
              </div>
            </div>
            <div class="bg-[#00D05A] text-white mt-1 p-3 rounded-xl font-body font-light text-sm">
              <button onClick={routeChange}>Add Voter</button>
            </div>
          </div>
          <VotersTable
            columns={columns}
            data={extractVoters(voters)}
          />
        </div>
      )}
    </div>
  );
}