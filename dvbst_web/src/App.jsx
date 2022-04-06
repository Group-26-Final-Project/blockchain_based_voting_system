import { makeStyles } from "@material-ui/core";
import { purple } from "@material-ui/core/colors";
import { BrowserRouter as Router, Route, Routes } from "react-router-dom";
import React from "react";
import HomeScreen from "./component/HomeScreen/HomeScreen";
import Idea from "./component/Idea/Idea";

import Login from "./component/Login/Login";
import Navbar from "./component/Navbar";
import Register from "./component/Register/Register";
import Register_by_face from "./component/Register_by_face/Register_by_face";
import Voting_underway from "./component/VotingUnderway/Voting_underway";
import Ideas from "./component/Idea/Ideas";
import CandidateList from "./component/candidate_list";

const useStyles = makeStyles({
  root: {
    background: purple,
    color: "white",
    height: 48,
  },
});

function App() {
  const classes = useStyles();

  return (
    <Router>
      <Navbar />
      <Routes>
        <Route path="/" element={<Register />} />
        <Route path="/auth/signin" element={<Login />} />
        <Route path="/auth/reg_face" element={<Register_by_face />} />
        <Route path="/auth/Homepage" element={<HomeScreen />} />
        <Route path="/auth/Voting_underway" element={<Voting_underway />} />
        <Route path="/auth/idea" element={<Idea />} />
        <Route path="/auth/ideas" element={<Ideas  />} />
        <Route path="/candidate_list" element={<CandidateList />} />
        
      </Routes>
      
    </Router>
  );
}

export default App;
