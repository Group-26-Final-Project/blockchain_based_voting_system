import React, { useState } from 'react'
import { useMoralis, useWeb3ExecuteFunction } from "react-moralis";
import { SpinnerCircularFixed } from "spinners-react";
import { useNavigate } from 'react-router';

export default function Login() {
    const { authenticate, isAuthenticated, isAuthenticating } = useMoralis();
    const navigate = useNavigate();

    // const initialValues = { email: "", password: "" }

    // const [formValues, setFormValues] = useState(initialValues)
    // const [formErrors, setFormErrors] = useState({})
    // const [isSubmit, setIsSubmit] = useState(false)

    // const changeHandler = (event) => {
    //     const { name, value } = event.target;
    //     setFormValues({ ...formValues, [name]: value })
    // };

    const handleSubmit = async (e) => {
        e.preventDefault()
        // setFormErrors(validate(formValues))
        // setIsSubmit(true)
        // if (Object.keys(formErrors).length === 0 && isSubmit){
        await authenticate()
        // navigate('/')
        // setFormValues(initialValues)
    }
    // }

    // const validate = (values) => {
    //     const errors = {}

    //     if (!values.email) {
    //         errors.email = "Email is a Required Field"
    //     }
    //     if (!values.password) {
    //         errors.password = "Password is a Required Field"
    //     }
    //     return errors
    // }

    return (
        <div class="flex items-center justify-center min-h-screen bg-[#2F313D]">
            <div class="px-12 py-8 mt-4 text-left bg-white shadow-lg  w-[25vw]">
                <div class="w-[5vw]">
                    <h3 class="text-2xl font-bold text-left">Login</h3>
                    <div class="h-1 w-10 bg-[#00D05A] float-right"></div>
                </div>
                <form onSubmit={handleSubmit}>
                    <div class="mt-4">
                        {/* <div>
                            <label class="block" for="email">Email</label>
                            <input type="text" name="email" onChange={changeHandler}
                                class="w-full px-2 py-1 mt-2 border rounded-md focus:outline-none focus:ring-1 focus:ring-blue-600" />
                            <p class="text-red-500 text-xs italic">{formErrors.email}</p>
                        </div>
                        <div class="mt-4">
                            <label class="block">Password</label>
                            <input type="password" name="password" onChange={changeHandler}
                                class="w-full px-2 py-1 mt-2 border rounded-md focus:outline-none focus:ring-1 focus:ring-blue-600" />
                            <p class="text-red-500 text-xs italic">{formErrors.password}</p>
                        </div> */}
                        <div class="flex items-baseline justify-center">
                            <button class="px-6 py-2 mt-4 text-white bg-[#00D05A] rounded-lg hover:bg-blue-900">Login with Metamask</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    )
}