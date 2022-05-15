import React, { useEffect } from "react";
import UsersTable, { Detail } from "./UsersTable";
// import { UsersData } from './UsersData';
import { SpinnerCircularFixed } from "spinners-react";
import StudentContract from "../contracts/AAiTStudent.json";
// import { useAPIContract } from "../hooks/useAPIContract";
import { useMoralis, useWeb3ExecuteFunction } from "react-moralis";

export default function Users() {
  const { isInitialized, isWeb3Enabled, account, enableWeb3, Moralis } =
    useMoralis();

  const {
    data: data1,
    error: eror1,
    fetch: fetch1,
    isFetching: isFetching1,
    isLoading: isLoading1,
  } = useWeb3ExecuteFunction({
    //   chain: "eth",
    contractAddress: "0x051d8ceA67B51Ed411AAfb3b7D2E11A6Ae0aDD58",
    functionName: "getAllVoters",
    abi: StudentContract.abi,
  });

  const {
    data: data2,
    error: eror2,
    fetch: fetch2,
    isFetching: isFetching2,
    isLoading: isLoading2,
  } = useWeb3ExecuteFunction({
    //   chain: "eth",
    contractAddress: "0x051d8ceA67B51Ed411AAfb3b7D2E11A6Ae0aDD58",
    functionName: "insertVoter",
    abi: StudentContract.abi,
    params: {
      voterInfo: {
        index: 0,
        userAddress: "0xe86DC0f7e6588A82e9096F2b719Ed975d3c4994d",
        studentId: "ATR/8098/09",
        fName: "second",
        lName: "hand",
        gName: "dude",
        DOB: 1985,
        currentYear: 2009,
        currentSection: 1,
        currentDepartment: 1,
      },
      email: "mygmail@gmail.com",
      password: "admin234123123",
    },
  });

  const addVoter = async () => {
    await enableWeb3();
    await fetch2();
    console.log("fetch2", data2);
    await fetch1();
    console.log("fetch1", data1);
  };

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
      await fetch1();
      console.log(data1);
    };
    console.log(isWeb3Enabled, isInitialized, account);
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
      {(isLoading1 || isLoading2) && (
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
      {eror1 && (
        <div>
          <h3>Ooops something went wrong</h3>
          <h2>{eror1.message}</h2>
        </div>
      )}
      {eror2 && (
        <div>
          <h2>{eror2.data.message.split("revert ")[1]}</h2>
        </div>
      )}
      {data1 && data1.length !== 0 && (
        <div class="w-full py-4 px-4 lg:px-8 rounded-2xl bg-white-700">
          <UsersTable
            columns={columns}
            data={extractVoters(data1)}
            childFunc={() => {
              addVoter();
            }}
          />
        </div>
      )}
    </div>
  );
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
