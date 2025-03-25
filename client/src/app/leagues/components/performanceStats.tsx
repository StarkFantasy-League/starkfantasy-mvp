import React from "react";
import userClock from "../../../../public/leagues/user-clock.svg";

interface PerformanceStatsProps {
  title: string;
  value: string | number;
}

const performanceStats: PerformanceStatsProps[] = [
  {
    title: "Matches Played",
    value: 56,
  },
  {
    title: "Current Rank",
    value: 128,
  },
  {
    title: "Total Points",
    value: 1236,
  },
  {
    title: "Team Value",
    value: "12.234STRK",
  },
];

const PerformanceStats = () => {
  return (
    <div className="w-[650px] bg-[#0F172BCC] -z-10 rounded-[20px] text-white p-5">
      <div className="flex items-center pb-3.5 space-x-4">
        <img src={userClock} alt="icon" />
        <h1 className="text-[40px]">Your Performance</h1>
      </div>

      <div>
        {performanceStats.map((stats, id) => {
          return (
            <div
              key={id}
              className="flex bg-[#1E2939] py-2.5 px-4 my-3 rounded-full justify-between items-center text-xl  "
            >
              <h4>{stats.title}</h4>
              <p>{stats.value}</p>
            </div>
          );
        })}
      </div>

      <button className="bg-[#F54900] p-2.5 mt-2 w-full rounded-2xl">
        Manage Team
      </button>
    </div>
  );
};

export default PerformanceStats;
