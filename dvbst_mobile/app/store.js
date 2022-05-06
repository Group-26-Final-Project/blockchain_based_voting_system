import { configureStore, getDefaultMiddleware } from '@reduxjs/toolkit';
import ideasReducer from '../features/ideasSlice';

export const store = configureStore({
  reducer: {
    ideasState: ideasReducer
  },
});