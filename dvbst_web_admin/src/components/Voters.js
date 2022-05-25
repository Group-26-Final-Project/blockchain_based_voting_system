import React, { useEffect } from "react";
import VotersTable, { Detail } from "./VotersTable";
// import { UsersData } from './UsersData';
import { SpinnerCircularFixed } from "spinners-react";
import StudentContract from "../contracts/AAiTStudent.json";
// import { useAPIContract } from "../hooks/useAPIContract";
import { useMoralis, useWeb3ExecuteFunction } from "react-moralis";

export default function Voters() {
  const { isInitialized, isWeb3Enabled, account, enableWeb3, Moralis } =
    useMoralis();

  const {
    data: voters,
    error: getAllVotersError,
    fetch: getAllVoters,
    isLoading: getAllVotersLoading,
  } = useWeb3ExecuteFunction({
    //   chain: "eth",
    contractAddress: process.env.REACT_APP_AAITSTUDENT_CONTRACT_ADDRESS,
    functionName: "getAllVoters",
    abi: StudentContract.abi,
  });

  const extractVoters = (data) => {
    var voterData = [];
    if (data && data.length > 0) {
      for (var i = 0; i < data.length; i++) {
        var voter = {
          name:
            data[i].voterInfo.fName +
            " " +
            data[i].voterInfo.lName +
            " " +
            data[i].voterInfo.gName,
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
  }, [isInitialized, isWeb3Enabled]);

  const columns = React.useMemo(
    () => [
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
          <h2>{getAllVotersError.message}</h2>
        </div>
      )}
      {voters && (
        <div class="w-full py-4 px-4 lg:px-8 rounded-2xl bg-white-700">
          <VotersTable
            columns={columns}
            data={extractVoters(voters)}
          />
        </div>
      )}
    </div>
  );
}