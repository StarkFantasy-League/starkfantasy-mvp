export default function RulesTableFootball() {
    return (
      <div className="overflow-x-auto pt-10 pb-10 w-full flex justify-center">
        <table className="w-[100%] lg:w-[75%] border border-gray-500 text-white">
          {/* Forwards and Midfielders */}
          <thead>
            <tr className="bg-indigo-800 text-center">
              <th colSpan={2} className="py-1">Forwards and Midfielders</th>
            </tr>
          </thead>
          <tbody className="text-[15px]">
            <tr className="border border-gray-500 ">
              <td className="p-1 border-r-4 text-center">Assist</td>
              <td className="p-1 text-center">+5 points</td>
            </tr>
            <tr className="border border-gray-500">
              <td className="p-1 border-r-4 text-center">Goal</td>
              <td className="p-1 text-center">+10 points</td>
            </tr>
          </tbody>
  
          {/* Defenders */}
          <thead>
            <tr className="bg-indigo-800 text-center">
              <th colSpan={2} className="py-1">Defenders</th>
            </tr>
          </thead>
          <tbody className="text-[15px]">
            <tr className="border border-gray-500">
              <td className="p-1 border-r-4 text-center">Clean Sheet</td>
              <td className="p-1 text-center">+10 points</td>
            </tr>
            <tr className="border border-gray-500">
              <td className="p-1 border-r-4 text-center">Assist</td>
              <td className="p-1 text-center">+10 points</td>
            </tr>
            <tr className="border border-gray-500">
              <td className="p-1 border-r-4 text-center ">Goal</td>
              <td className="p-1 text-center">+10 points</td>
            </tr>
          </tbody>
  
          {/* Goalkeepers */}
          <thead>
            <tr className="bg-indigo-800 text-center">
              <th colSpan={2} className="py-1">Goalkeepers</th>
            </tr>
          </thead>
          <tbody className="text-[15px]">
            <tr className="border border-gray-500">
              <td className="p-1 border-r-4 text-center  ">Clean Sheet</td>
              <td className="p-1 text-center">+20 points</td>
            </tr>
          </tbody>
        </table>
      </div>
    );
  }
  