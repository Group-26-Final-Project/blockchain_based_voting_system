import { useMoralisWeb3Api, useMoralisWeb3ApiCall } from "react-moralis";

import StudentContract from "../contracts/AAiTStudent.json"

const voterOptions = {
    chain: "eth",
    address: "0xABe6fEa796f4908496991ADCdaAFB28616659636",
    function_name: "",
    abi: StudentContract.abi
}

export function useCustomMoralisHook(functionName, params) {
    const { native } = useMoralisWeb3Api();
    var customVoterOptions = voterOptions;
    customVoterOptions.function_name = functionName;
    customVoterOptions.params = params;
    const { data, error } = useMoralisWeb3ApiCall(
        native.runContractFunction,
        { ...customVoterOptions }
    );
    return { data, error };
}