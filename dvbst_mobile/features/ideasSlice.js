import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';
import axios from 'axios'

const baseURL = "https://9593-197-156-86-9.eu.ngrok.io"

const initialState = {
    ideas: [],
    addIdeasStatus: "",
    addIdeasError: "",
    getIdeasStatus: "",
    getIdeasError: "",
}

function timeout(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

export const addIdeas = createAsyncThunk("ideas/addIdeas", async (idea, {
    rejectWithValue})=>{
        try{
            await timeout(1000)
            const response = await axios.post(baseURL+"/ideas", idea)
            return response.data
        } catch(err){
            return rejectWithValue(error.response.data)
        }
})

export const getIdeas = createAsyncThunk("ideas/getIdeas", async (id=null, {
    rejectWithValue})=>{
        try{
            await timeout(1000)
            const response = await axios.get(baseURL+"/ideas")
            return response.data
        } catch(err){
            return rejectWithValue(error.response.data)
        }
})

const ideasSlice = createSlice({
    name: "ideas",
    initialState,
    reducers: {},
    extraReducers: {
        [addIdeas.pending]: (state, action) => {
            return {
                ...state,
                addIdeasStatus: "pending",
            }
        },
        [addIdeas.fulfilled]: (state, action) => {
            return {
                ...state,
                ideas: [...state.ideas, action.payload],
                addIdeasStatus: "success"
            }
        },
        [addIdeas.rejected]: (state, action) => {
            return {
                ...state,
                addIdeasStatus: "failed",
                addIdeasError: action.payload
            }
        },
        [getIdeas.pending]: (state, action) => {
            return {
                ...state,
                getIdeasStatus: "pending",
            }
        },
        [getIdeas.fulfilled]: (state, action) => {
            return {
                ...state,
                ideas: action.payload,
                getIdeasStatus: "success"
            }
        },
        [getIdeas.rejected]: (state, action) => {
            return {
                ...state,
                getIdeasStatus: "failed",
                getIdeasError: action.payload,
            }
        },
    }
})

export default ideasSlice.reducer;