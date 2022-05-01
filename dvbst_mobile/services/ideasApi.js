import { createApi, fetchBaseQuery } from '@reduxjs/toolkit/query/react';

export const ideasApi = createApi({
    reducerPath: 'ideasApi',
    baseQuery: fetchBaseQuery({
        baseUrl: "https://9617-196-190-61-31.eu.ngrok.io"
    }),
    endpoints: (builder) => ({
        ideas: builder.query({
            query:() => '/ideas'
        }),
        addIdea: builder.mutation({
            query: idea => ({
                url: '/ideas',
                method: 'POST',
                body: idea
            })
        }),

        updateIdea: builder.mutation({
            query: (id, ...rest) => ({
                url: `/ideas/${id}`,
                method: 'PATCH',
                body: rest
            })
        }), 
    }),
})

export const { 
    useIdeasQuery, 
    useAddIdeaMutation,
    useUpdateIdeaMutation
 } = ideasApi;