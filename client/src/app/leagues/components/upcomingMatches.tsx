"use client";

import Button from "@/components/ui/button";

interface Match {
  id: number;
  team1: string;
  team2: string;
  date: string;
  time: string;
}

export default function UpcomingMatches() {
  const matches: Match[] = [
    {
      id: 1,
      team1: "Team 1",
      team2: "Team 2",
      date: "dd/mm/yyyy",
      time: "HH:MM",
    },
    {
      id: 2,
      team1: "Team 1",
      team2: "Team 2",
      date: "dd/mm/yyyy",
      time: "HH:MM",
    },
    {
      id: 3,
      team1: "Team 1",
      team2: "Team 2",
      date: "dd/mm/yyyy",
      time: "HH:MM",
    },
    {
      id: 4,
      team1: "Team 1",
      team2: "Team 2",
      date: "dd/mm/yyyy",
      time: "HH:MM",
    },
  ];

  return (
    <div className="text-white bg-neutral/80 w-full space-y-[30px] max-w-sm md:max-w-3xl rounded-lg p-6 backdrop-blur-sm">
      <div className="flex items-center gap-3 ">
        <img src="/icons/calendar.svg" alt="" />

        <h3 className="text-xl sm:text-4xl font-medium sm:font-semibold">Upcoming matches</h3>
      </div>

      <div className="flex flex-col gap-4">
        {matches.map((match) => (
          <div
            key={match.id}
            className="bg-gray-800/80 rounded-lg px-5 py-2.5 flex justify-between items-center"
          >
            <div>
              <div className="text-base sm:text-xl font-medium text-white">
                {match.team1} vs {match.team2}
              </div>
              <div className="text-gray-300 text-xs sm:text-base ">
                {match.date} - {match.time}
              </div>
            </div>
            <Button
              onClick={() => {}}
              className="bg-orange-500 hover:bg-orange-600 text-white border-none"
            >
              Set Lineup
            </Button>
          </div>
        ))}
      </div>
    </div>
  );
}
