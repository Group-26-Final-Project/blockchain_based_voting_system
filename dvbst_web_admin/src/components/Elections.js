import React, { useEffect, useState } from "react";
import ElectionTable, { Detail, StatusPill } from "./ElectionsTable";
import { useNavigate } from "react-router-dom";
import { AiOutlineClose } from "react-icons/ai";
import ElectionContract from "../contracts/AAiTElection.json";
import { useMoralis, useWeb3ExecuteFunction } from "react-moralis";
import { SpinnerCircularFixed } from "spinners-react";
// import Moment from "react-moment";
import moment from "moment";

export default function Election() {
  const [searchQuery, setSearchQuery] = useState("");
  const { isInitialized, isWeb3Enabled, account, enableWeb3, Moralis } =
    useMoralis();

  // const allElections = getAllElections();
  const clearSearch = () => {
    setSearchQuery("");
  };
  const electionStatus = ["PENDING", "ONGOING", "COMPLETED"];
  const {
    data: electionsData,
    error: getElectionsError,
    fetch: getAllElections,
    isLoading: isGetAllElectionsLoading,
  } = useWeb3ExecuteFunction({
    contractAddress: process.env.REACT_APP_AAITELECTION_CONTRACT_ADDRESS,
    functionName: "getAllElections",
    abi: ElectionContract.abi,
  });

  let navigate = useNavigate();
  const routeChange = () => {
    let path = window.location.pathname + "/newelection";
    navigate(path);
  };

  const extractElections = (electionsData) => {
    var elections = [];
    if (electionsData && electionsData.length > 0) {
      for (var i = 0; i < electionsData.length; i++) {
        // console.log("Candidates", candidatesData[i])
        var t = new Date();
        // t.setSeconds(electionsData[i].endDate);
        var formatted = moment(t).format("DD MMMM, yyyy hh:MM:ss");

        var election = {
          num: i + 1,
          name: electionsData[i].name,
          status: electionStatus[electionsData[i].electionType],
          details: "Details",
          time: formatted,
        };
        elections.push(election);
      }
    }
    return elections;
  };

  useEffect(() => {
    const fetchData = async () => {
      await enableWeb3();
      await getAllElections();
    };
    if (isInitialized && isWeb3Enabled) {
      fetchData();
    } else {
      enableWeb3();
    }
  }, [enableWeb3, getAllElections, isInitialized, isWeb3Enabled]);

  const columns = React.useMemo(
    () => [
      {
        Header: "No.",
        accessor: "num",
      },
      {
        Header: "Election Name",
        accessor: "name",
      },
      {
        Header: "End Date",
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
    []
  );
  console.log("electionsData", electionsData);

  return (
    <div class="min-h-screen w-full bg-white-800 flex flex-col justify-center items-center py-4 px-4 lg:px-8">
      {isGetAllElectionsLoading && (
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
      {getElectionsError && (
        <div>
          <h3>Ooops something went wrong</h3>
          <button onClick={() => window.location.reload(false)}>Reload!</button>
          {/* <h2>{getCandidatesError.message}</h2> */}
        </div>
      )}
      {electionsData && (
        <div class="w-full py-4 px-4 lg:px-8 rounded-2xl bg-white-700">
          <div class="flex justify-between items-center">
            <div class="p-2 pl-0">
              <label for="table-search" class="sr-only">
                Search
              </label>
              <div class="relative flex items-center mt-1">
                <div class="flex absolute inset-y-0 left-0 items-center pl-3 pointer-events-none">
                  <svg
                    class="w-5 h-5 text-gray-500 dark:text-gray-400"
                    fill="currentColor"
                    viewBox="0 0 20 20"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path
                      fill-rule="evenodd"
                      d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z"
                      clip-rule="evenodd"
                    ></path>
                  </svg>
                </div>
                <input
                  type="text"
                  id="table-search"
                  class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-80 pl-10 p-2.5  dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                  onChange={(e) => setSearchQuery(e.target.value)}
                  value={searchQuery}
                  placeholder="Search..."
                />
                <div class="p-2 pl-0 -ml-6 text-gray-50">
                  <AiOutlineClose onClick={clearSearch} />
                </div>
              </div>
            </div>
          </div>
          <ElectionTable
            columns={columns}
            data={extractElections(electionsData)}
          />
        </div>
      )}
    </div>
  );
}
