import './App.css';
// import Users from './components/Users';
import Candidates from './components/Candidates';
import Home from './components/Home';
import NewElection from './components/NewElection';
// import NewUser from './components/NewUser';
import Sidebar from './components/Sidebar';
import {
  BrowserRouter as Router,
  Routes,
  Route,
} from 'react-router-dom';
import { AiOutlineMenu } from "react-icons/ai";
import Election from './components/Elections';
import Blacklist from './components/Blacklist'
import NewCandidate from './components/NewCandidate';
import Voters from './components/Voters';
import NewVoter from './components/NewVoter';

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
            {/* <Route path="/users" element={<Users />} /> */}
            <Route path="/voters" element={<Voters />} />
            <Route path="/voters/newvoter" element={<NewVoter />} />

            <Route path="/candidates" element={<Candidates />} />
            <Route path="/candidates/newcandidate" element={<NewCandidate />} />
            {/* <Route path="/users/newuser" element={<NewUser />} /> */}
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
