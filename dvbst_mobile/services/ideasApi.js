import { createApi, fetchBaseQuery } from '@reduxjs/toolkit/query/react';

export const ideasApi = createApi({
    reducerPath: 'ideasApi',
    baseQuery: fetchBaseQuery({
        baseUrl: "http://localhost:8080/"
    }),
    endpoints: (builder) => ({
        ideas: builder.query({
            query:() => '/ideas'
        }),
        addIdea: builder.mutation({
            query: idea => ({
                url: '/idea',
                method: 'POST',
                body: idea
            })
        }),

        updateIdea: builder.mutation({
            query: (id, ...rest) => ({
                url: `/idea/${id}`,
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