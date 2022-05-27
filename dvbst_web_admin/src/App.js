import './App.css';
import Home from './components/Home';
import Voters from './components/Voters';
import VoterDetail from './components/VoterDetail';
import NewVoter from './components/NewVoter';
import Candidates from './components/Candidates';
import CandidateDetail from './components/CandidateDetail';
import NewCandidate from './components/NewCandidate';
import Election from './components/Elections';
import NewElection from './components/NewElection';
import Blacklist from './components/Blacklist'
import Sidebar from './components/Sidebar';
import {
  BrowserRouter as Router,
  Routes,
  Route,
} from 'react-router-dom';
import { AiOutlineMenu } from "react-icons/ai";

function App() {
  return (
    <Router>
      <div class="md:flex bg-[#D3E8E6]/20 h-screen">
        <div class="bg-[#2F313D] text-white md:hidden">
          <button class="p-4">
            <AiOutlineMenu />
          </button>
        </div>
        <div class="w-[25vw] inset-y-0 left-0 absolute transform -translate-x-full md:relative md:translate-x-0 transition duration-200 ease-in-out">
          <Sidebar />
        </div>
        <div class="flex-1 h-screen md:overflow-y-auto">
          <Routes>
            <Route path="/" exact element={<Home />} />
            <Route path="/voters" element={<Voters />} />
            <Route path="/voterDetail" element={<VoterDetail />} />
            <Route path="/voters/newvoter" element={<NewVoter />} />
            <Route path="/candidates" element={<Candidates />} />
            <Route path="/candidateDetail" element={<CandidateDetail />} />
            <Route path="/candidates/newcandidate" element={<NewCandidate />} />
            <Route path="/elections" element={<Election />} />
            <Route path="/elections/newelection" element={<NewElection />} />
            <Route path="/blacklist" element={<Blacklist />} />
          </Routes>
        </div>
      </div>
    </Router>
  );
}

export default App;
