import React, { useState } from 'react'

export default function NewElection() {
    return (
        <div class="min-h-screen w-full bg-white-800 flex items-center py-8 px-4 lg:px-8">
            <div class="w-[50vw] bg-white-800 ">
                <div class="sm:mx-auto sm:w-full sm:max-w-md">
                    <h2 class="mt-6 mb-6 text-left text-2xl font-extrabold text-gray-900">Add New Election</h2>
                </div>
                <form class="w-full max-w-lg sm:mx-auto sm:w-full sm:max-w-md">
                    <div class="flex flex-wrap -mx-3 mb-3">
                        <div class="w-full md:w-full px-3 mb-6 md:mb-0">
                            <label class="block tracking-wide text-gray-700 text-xs font-bold mb-2" for="grid-name">
                                Name
                            </label>
                            <input class="appearance-none block w-full bg-white-200 text-sm text-gray-700 border border-[#C4C4C4] rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" id="grid-name" type="text" />
                            {/* <p class="text-gray-600 text-xs italic">Make it as long and as crazy as you'd like</p> */}
                        </div>
                    </div>
                    <div class="flex flex-wrap -mx-3 mb-5 contents-center">
                        <div class="w-full md:w-full px-3 mb-6 md:mb-0 flex justify-between">
                            <div class="form-check">
                                <input class="form-check-input appearance-none rounded-full h-4 w-4 border border-[#C4C4C4] bg-white checked:bg-blue-600 checked:border-blue-600 focus:outline-none transition duration-200 mt-1 align-top bg-no-repeat bg-center bg-contain float-left mr-2 cursor-pointer" type="radio" name="flexRadioDefault" id="flexRadioDefault1"/>
                                <label class="form-check-label inline-block text-gray-800" for="flexRadioDefault1">
                                    Section
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input appearance-none rounded-full h-4 w-4 border border-[#C4C4C4] bg-white checked:bg-blue-600 checked:border-blue-600 focus:outline-none transition duration-200 mt-1 align-top bg-no-repeat bg-center bg-contain float-left mr-2 cursor-pointer" type="radio" name="flexRadioDefault" id="flexRadioDefault2" />
                                <label class="form-check-label inline-block text-gray-800" for="flexRadioDefault2">
                                    Year
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input appearance-none rounded-full h-4 w-4 border border-[#C4C4C4] bg-white checked:bg-blue-600 checked:border-blue-600 focus:outline-none transition duration-200 mt-1 align-top bg-no-repeat bg-center bg-contain float-left mr-2 cursor-pointer" type="radio" name="flexRadioDefault" id="flexRadioDefault2" />
                                <label class="form-check-label inline-block text-gray-800" for="flexRadioDefault2">
                                    Department
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="flex flex-wrap -mx-3 mb-3">
                        <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                            <label class="block tracking-wide text-gray-700 text-xs font-bold mb-2" for="grid-dept">
                                Candidates From:
                            </label>
                            <div class="relative">
                                <select class="block appearance-none w-full bg-white-200 text-sm text-gray-700 border border-[#C4C4C4] text-gray-700 py-2 px-4 pr-8 rounded leading-tight focus:outline-none focus:bg-white focus:border-gray-500" id="grid-dept">
                                    <option>--Select--</option>
                                    <option>Software Section 1 Election</option>
                                </select>
                                <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                                    <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z" /></svg>
                                </div>
                            </div>
                        </div>
                        <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                            <label class="block tracking-wide text-gray-700 text-xs font-bold mb-2" for="grid-dept">
                                Voters From:
                            </label>
                            <div class="relative">
                                <select class="block appearance-none w-full bg-white-200 text-sm text-gray-700 border border-[#C4C4C4] text-gray-700 py-2 px-4 pr-8 rounded leading-tight focus:outline-none focus:bg-white focus:border-gray-500" id="grid-dept">
                                    <option>--Select--</option>
                                    <option>Software 3rd Year Election</option>
                                </select>
                                <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                                    <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z" /></svg>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div>
                        <button type="submit" class="w-full py-2 px-4 mt-8 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-[#00D05A] hover:bg-[#00D05A]/80 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">Add Election</button>
                    </div>
                </form >
            </div >
        </div>
    );
}