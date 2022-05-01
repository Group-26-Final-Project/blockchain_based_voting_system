import { configureStore } from '@reduxjs/toolkit';
import { setupListeners } from '@reduxjs/toolkit/query';
import { ideasApi } from '../services/ideasApi';

export const store = configureStore({
  reducer: {
    [ideasApi.reducerPath]: ideasApi.reducer,
  },
  middleware: (getDefaultMiddleware) =>
    getDefaultMiddleware().concat(ideasApi.middleware),
});

setupListeners(store.dispatch);