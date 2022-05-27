import React, { useEffect, useState } from "react";
import { SpinnerCircularFixed } from "spinners-react";
import UserContract from "../contracts/AAiTUser.json";
import { useMoralis, useWeb3ExecuteFunction } from "react-moralis";
import { useNavigate } from "react-router";

export default function NewCandidate() {
  const {
    isInitialized,
    isWeb3Enabled,
    isAuthenticated,
    user,
    account,
    enableWeb3,
    Moralis,
  } = useMoralis();
  const navigate = useNavigate();

  const initialValues = {
    name: "",
    fname: "",
    gname: "",
    dept: "",
    section: "",
    year: "",
    email: "",
    id: "",
    phone: "",
    wallet: "",
    bio: "",
    profile: null,
  };
  const [formValues, setFormValues] = useState(initialValues);
  const [formErrors, setFormErrors] = useState({});
  const [isFilePicked, setIsFilePicked] = useState(false);
  const [isSubmit, setIsSubmit] = useState(false);

  const {
    data: addNewCandidateData,
    error: addNewCandidateError,
    fetch: addNewCandidate,
    isLoading: isAddNewCandidateLoading,
  } = useWeb3ExecuteFunction({
    contractAddress: process.env.REACT_APP_AAITUSER_CONTRACT_ADDRESS,
    functionName: "insertUser",
    abi: UserContract.abi,
    params: {
      studentId: formValues.id,
      fullName: formValues.name + " " + formValues.fname + " " + formValues.gname,
      currentYear: formValues.year,
      currentSection: formValues.section,
      currentDepartment: 1,
      email: formValues.email,
      phone: formValues.phone,
      profilePicture: formValues.profile,
      bio: formValues.bio,
      role: 1,
    },
  });

  const addCandidate = async () => {
    await addNewCandidate();
  };

  const isValidFileUploaded = (file) => {
    const validExtensions = ["png", "jpeg", "jpg"];
    const fileExtension = file.type.split("/")[1];
    return validExtensions.includes(fileExtension);
  };

  const changeHandler = (event) => {
    const { name, value } = event.target;
    setFormValues({ ...formValues, [name]: value });
  };

  const picHandler = (event) => {
    setFormValues({ ...formValues, profile: event.target.files[0] });
    setIsFilePicked(true);
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setFormErrors(validate(formValues));
    setIsSubmit(true);
    if (Object.keys(formErrors).length === 0 && isSubmit) {
      await addCandidate();
      navigate("/candidates");
      setFormValues(initialValues);
    }
  };

  useEffect(() => {
    if (isInitialized && isWeb3Enabled && isAuthenticated) {
      console.log(account);
      console.log(user);
    } else {
      enableWeb3();
    }
  }, [isInitialized, isWeb3Enabled, Moralis, isAuthenticated, account, user, enableWeb3]);

  const validate = (values) => {
    const errors = {};
    const nameRegex = new RegExp("^[a-zA-Z]{3,20}$");
    const idRegex = new RegExp("^[a-zA-Z]{3}/[0-9]{4}/[0-9]{2}$");
    const emailRegex = new RegExp("^[A-Za-z0-9]{1,64}@(.+)$");
    const phoneRegex = new RegExp("^09[0-9]{8}$");
    const walletRegex = new RegExp("^0x[a-fA-F0-9]{40}$");

    if (!values.name) {
      errors.name = "Name is a Required Field";
    } else if (!nameRegex.test(values.name)) {
      errors.name =
        "Invalid Name (Only Upper/Lower Case alphabets 3-20 characters long)";
    }
    if (!values.fname) {
      errors.fname = "Father's Name is a Required Field";
    } else if (!nameRegex.test(values.fname)) {
      errors.fname =
        "Invalid Name (Only Upper/Lower Case alphabets  3-20 characters long)";
    }
    if (!values.gname) {
      errors.gname = "Grandfather's Name is a Required Field";
    } else if (!nameRegex.test(values.gname)) {
      errors.gname =
        "Invalid Name (Only Upper/Lower Case alphabets  3-20 characters long)";
    }
    if (!values.dept) {
      errors.dept = "Select Department from dropdown";
    }
    if (!values.section) {
      errors.section = "Select Section from dropdown";
    }
    if (!values.year) {
      errors.year = "Select Year from dropdown";
    }
    if (!values.id) {
      errors.id = "ID is a Required Field";
    } else if (!idRegex.test(values.id)) {
      errors.id = "Invalid ID Format (eg. ATR/1234/09)";
    }
    if (!values.email) {
      errors.email = "Email is a Required Field";
    } else if (!emailRegex.test(values.email)) {
      errors.email = "Invalid Email Address (eg. useremail@email.com)";
    }
    if (!values.phone) {
      errors.phone = "Phone is a Required Field";
    } else if (!phoneRegex.test(values.phone)) {
      errors.phone = "Invalid Phone Number (eg. 0911123456)";
    }
    if (values.wallet && !walletRegex.test(values.wallet)) {
      errors.wallet =
        "Invalid Wallet Address (0x followed by 40 hexadecimal characters)";
    }
    if (!values.bio) {
      errors.bio = "Bio is a Required Field";
    }
    if (values.profile && !isValidFileUploaded(values.profile)) {
      errors.profile = "Invalid Image Type (only png, jpg, jpeg allowed)";
    }
    return errors;
  };

  return (
    <div class="min-h-screen w-full bg-white-800 flex flex-row justify-center items-center py-8 px-4 lg:px-8">
      {(isAddNewCandidateLoading || addNewCandidateData) && (
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
      {addNewCandidateError && (
        <div>
          <h2>{addNewCandidateError.message}</h2>
        </div>
      )}
      {!isAddNewCandidateLoading && !addNewCandidateData && (
        <div class="w-[50vw]">
          <div class="sm:mx-auto sm:w-full sm:max-w-md">
            <h2 class="mt-6 mb-6 text-left text-2xl font-extrabold text-gray-900">
              Add New Candidate
            </h2>
          </div>
          <form
            onSubmit={handleSubmit}
            class="w-full max-w-lg sm:mx-auto sm:w-full sm:max-w-md"
          >
            <div class="flex flex-wrap -mx-3 mb-3">
              <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                <label
                  class="block tracking-wide text-gray-700 text-xs font-bold mb-2"
                  for="grid-name"
                >
                  Name
                </label>
                <input
                  class="appearance-none block w-full bg-white-200 text-sm text-gray-700 border border-gray-200 rounded py-2 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
                  id="grid-name"
                  name="name"
                  type="text"
                  value={formValues.name}
                  onChange={changeHandler}
                />
                {/* <input class="appearance-none block w-full bg-gray-200 text-gray-700 border border-red-500 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-name" type="text" placeholder="Enter First Name" /> */}
                <p class="text-red-500 text-xs italic">{formErrors.name}</p>
              </div>
              <div class="w-full md:w-1/2 px-3">
                <label
                  class="block tracking-wide text-gray-700 text-xs font-bold mb-2"
                  for="grid-father-name"
                >
                  Father's Name
                </label>
                <input
                  class="appearance-none block w-full bg-white-200 text-sm text-gray-700 border border-gray-200 rounded py-2 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
                  id="grid-father-name"
                  name="fname"
                  type="text"
                  value={formValues.fname}
                  onChange={changeHandler}
                />
                <p class="text-red-500 text-xs italic">{formErrors.fname}</p>
              </div>
            </div>
            <div class="flex flex-wrap -mx-3 mb-3">
              <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                <label
                  class="block tracking-wide text-gray-700 text-xs font-bold mb-2"
                  for="grid-grand-name"
                >
                  Grandfather's Name
                </label>
                <input
                  class="appearance-none block w-full bg-white-200 text-sm text-gray-700 border border-gray-200 rounded py-2 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
                  id="grid-grand-name"
                  name="gname"
                  type="text"
                  value={formValues.gname}
                  onChange={changeHandler}
                />
                <p class="text-red-500 text-xs italic">{formErrors.gname}</p>
              </div>
              <div class="w-full md:w-1/2 px-3">
                <label
                  class="block tracking-wide text-gray-700 text-xs font-bold mb-2"
                  for="grid-id"
                >
                  ID
                </label>
                <input
                  class="appearance-none block w-full bg-white-200 text-sm text-gray-700 border border-gray-200 rounded py-2 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
                  id="grid-id"
                  name="id"
                  type="text"
                  value={formValues.id}
                  onChange={changeHandler}
                />
                <p class="text-red-500 text-xs italic">{formErrors.id}</p>
              </div>
            </div>
            <div class="flex flex-wrap -mx-3 mb-3">
              <div class="w-full md:w-full px-3 mb-6 md:mb-0">
                <label
                  class="block tracking-wide text-gray-700 text-xs font-bold mb-2"
                  for="grid-dept"
                >
                  Department
                </label>
                <div class="relative">
                  <select
                    class="block appearance-none w-full bg-white-200 text-sm text-gray-700 border border-gray-200 text-gray-700 py-2 px-4 pr-8 rounded leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
                    name="dept"
                    id="grid-dept"
                    value={formValues.dept}
                    onChange={changeHandler}
                  >
                    <option value="" selected disabled hidden>--Select--</option>
                    <option value={1}>Software Engineering</option>
                    <option value={2}>Biomedical Engineering</option>
                    <option value={3}>Chemical Engineering</option>
                    <option value={4}>Civil Engineering</option>
                    <option value={5}>Electrical Engineering</option>
                    <option value={6}>Mechanical Engineering</option>
                  </select>
                  <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                    <svg
                      class="fill-current h-4 w-4"
                      xmlns="http://www.w3.org/2000/svg"
                      viewBox="0 0 20 20"
                    >
                      <path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z" />
                    </svg>
                  </div>
                </div>
                <p class="text-red-500 text-xs italic">{formErrors.dept}</p>
              </div>
            </div>
            <div class="flex flex-wrap -mx-3 mb-3">
              <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                <label
                  class="block tracking-wide text-gray-700 text-xs font-bold mb-2"
                  for="grid-year"
                >
                  Year
                </label>
                <div class="relative">
                  <select
                    class="block appearance-none w-full bg-white-200 text-sm text-gray-700 border border-gray-200 text-gray-700 py-2 px-4 pr-8 rounded leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
                    name="year"
                    id="grid-year"
                    value={formValues.year}
                    onChange={changeHandler}
                  >
                    <option value="" selected disabled hidden>--Select--</option>
                    <option value={1}>1</option>
                    <option value={2}>2</option>
                    <option value={3}>3</option>
                    <option value={4}>4</option>
                    <option value={5}>5</option>
                  </select>
                  <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                    <svg
                      class="fill-current h-4 w-4"
                      xmlns="http://www.w3.org/2000/svg"
                      viewBox="0 0 20 20"
                    >
                      <path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z" />
                    </svg>
                  </div>
                  <p class="text-red-500 text-xs italic">{formErrors.year}</p>
                </div>
              </div>
              <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                <label
                  class="block tracking-wide text-gray-700 text-xs font-bold mb-2"
                  for="grid-section"
                >
                  Section
                </label>
                <div class="relative">
                  <select
                    class="block appearance-none w-full bg-white-200 text-sm text-gray-700 border border-gray-200 text-gray-700 py-2 px-4 pr-8 rounded leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
                    name="section"
                    id="grid-section"
                    value={formValues.section}
                    onChange={changeHandler}
                  >
                    <option value="" selected disabled hidden>--Select--</option>
                    <option value={1}>1</option>
                    <option value={2}>2</option>
                    <option value={3}>3</option>
                  </select>
                  <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                    <svg
                      class="fill-current h-4 w-4"
                      xmlns="http://www.w3.org/2000/svg"
                      viewBox="0 0 20 20"
                    >
                      <path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z" />
                    </svg>
                  </div>
                </div>
                <p class="text-red-500 text-xs italic">{formErrors.section}</p>
              </div>
            </div>
            <div class="flex flex-wrap -mx-3 mb-3">
              <div class="w-full md:w-full px-3 mb-6 md:mb-0">
                <label
                  class="block tracking-wide text-gray-700 text-xs font-bold mb-2"
                  for="grid-email"
                >
                  Email
                </label>
                <input
                  class="appearance-none block w-full bg-white-200 text-sm text-gray-700 border border-gray-200 rounded py-2 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
                  name="email"
                  id="grid-email"
                  type="text"
                  value={formValues.email}
                  onChange={changeHandler}
                />
                <p class="text-red-500 text-xs italic">{formErrors.email}</p>
              </div>
            </div>
            <div class="flex flex-wrap -mx-3 mb-3">
              <div class="w-full md:w-full px-3 mb-6 md:mb-0">
                <label
                  class="block tracking-wide text-gray-700 text-xs font-bold mb-2"
                  for="grid-phone"
                >
                  Phone Number
                </label>
                <input
                  class="appearance-none block w-full bg-white-200 text-sm text-gray-700 border border-gray-200 rounded py-2 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
                  name="phone"
                  id="grid-phone"
                  type="tel"
                  value={formValues.phone}
                  onChange={changeHandler}
                />
                {/* <p class="text-gray-600 text-xs italic">Make it as long and as crazy as you'd like</p> */}
                <p class="text-red-500 text-xs italic">{formErrors.phone}</p>
              </div>
            </div>
            <div class="flex flex-wrap -mx-3 mb-3">
              <div class="w-full md:w-full px-3 mb-6 md:mb-0">
                <label
                  class="block tracking-wide text-gray-700 text-xs font-bold mb-2"
                  for="grid-wallet"
                >
                  Wallet Address
                </label>
                <input
                  class="appearance-none block w-full bg-white-200 text-sm text-gray-700 border border-gray-200 rounded py-2 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
                  name="wallet"
                  id="grid-wallet"
                  type="text"
                  value={formValues.wallet}
                  onChange={changeHandler}
                />
                {/* <p class="text-gray-600 text-xs italic">Make it as long and as crazy as you'd like</p> */}
                <p class="text-red-500 text-xs italic">{formErrors.wallet}</p>
              </div>
            </div>
            <div>
              <hr />
              <div class="flex flex-wrap -mx-3 mb-3">
                <div class="w-full md:w-full px-3 mb-6 md:mb-0">
                  <label
                    class="block tracking-wide text-gray-700 text-xs font-bold mb-2"
                    for="grid-bio"
                  >
                    Bio
                  </label>
                  <textarea
                    class="appearance-none block w-full bg-white-200 text-sm text-gray-700 border border-gray-200 rounded py-2 px-2 leading-tight focus:outline-none focus:bg-white focus:border-gray-500 resize-none"
                    name="bio"
                    id="grid-bio"
                    value={formValues.bio}
                    onChange={changeHandler}
                    placeholder="Enter Candidate Bio upto 250 characters"
                    rows="4"
                  />
                  <p class="text-red-500 text-xs italic">{formErrors.bio}</p>
                </div>
              </div>
              <div class="mb-3 w-96">
                <label
                  class="block tracking-wide text-gray-700 text-xs font-bold mb-2"
                  for="grid-pic"
                >
                  Candidate Picture
                </label>
                <input
                  class="appearance-none block w-full bg-white-200 text-sm text-gray-700 border border-gray-200 rounded py-2 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
                  name="profile"
                  id="grid-pic"
                  type="file"
                  onChange={picHandler}
                />
                <p class="text-red-500 text-xs italic">{formErrors.profile}</p>
              </div>
            </div>

            <div>
              <button
                type="submit"
                class="w-full flex justify-center py-3 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-[#00D05A] hover:bg-[#00D05A]/80 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
              >
                Add Candidate
              </button>
            </div>
          </form>
        </div>
      )}
    </div>
  );
}
