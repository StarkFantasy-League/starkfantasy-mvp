"use client";

import { useState } from 'react';

interface Player {
  id: number;
  rank: number;
  name: string;
  team: string;
  goals: number;
  fantasyPoints: number;
}

const initialPlayers: Player[] = [
  {
    id: 1,
    rank: 1,
    name: "Player Name",
    team: "ABC",
    goals: 50,
    fantasyPoints: 243
  },
  {
    id: 2,
    rank: 2,
    name: "Player Name",
    team: "ABC",
    goals: 46,
    fantasyPoints: 213
  },
  {
    id: 3,
    rank: 3,
    name: "Player Name",
    team: "ABC",
    goals: 42,
    fantasyPoints: 198
  }
];

const TopScorers = () => {
  const [players] = useState<Player[]>(initialPlayers);

  return (
    <div className="w-full rounded-lg bg-[#0F172B]/80 p-4">
      <div className="flex items-center mb-4">
        <div className="text-[#FF6900] text-5xl mr-4">
          <img src="/icons/trophy.svg" alt="Trophy" width={72} height={72} />
        </div>
        <h1 className="text-white text-5xl font-bold">Top Scorers</h1>
      </div>

      <div className="bg-[#0F172B]/80 rounded-lg overflow-hidden">
        <div className="grid grid-cols-5 bg-[#0A0F1F] py-4 px-6">
          <div className="text-amber-500 font-semibold text-center">Rank</div>
          <div className="text-amber-500 font-semibold">Player</div>
          <div className="text-amber-500 font-semibold">Team</div>
          <div className="text-amber-500 font-semibold text-center">Goals</div>
          <div className="text-amber-500 font-semibold text-center">Fantasy Points</div>
        </div>

        <div className="divide-y divide-[#1E293B]">
          {players.map((player) => (
            <div key={player.id} className="grid grid-cols-5 py-4 px-6 hover:bg-[#1E293B]/70 transition-colors duration-150">
              <div className="text-white text-center">{player.rank}</div>
              <div className="text-white">{player.name}</div>
              <div className="text-white">{player.team}</div>
              <div className="text-white text-center">{player.goals}</div>
              <div className="text-white text-center">{player.fantasyPoints}</div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
};

export default TopScorers;
