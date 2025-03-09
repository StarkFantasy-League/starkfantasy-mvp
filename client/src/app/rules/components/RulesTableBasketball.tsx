export default function RulesTableBasketball() {
  return (
    <div className="overflow-x-auto w-full flex justify-center py-10">
      <table className="w-[95%] lg:w-[75%] border-2 border-gray-500 text-white">
        <thead>
          <tr className="bg-indigo-800 text-center border-b-2">
            <th className="py-1 border-r-4">Category</th>
            <th className="py-1">Points Per action</th>
          </tr>
        </thead>
        <tbody >
          <tr className="border border-gray-500 border-b-2">
            <td className="p-1 border-r-4 text-center  ">Points Scored</td>
            <td className="p-1 text-center">1 score ={">"} +1 point</td>
          </tr>

          <tr className="border border-gray-500 border-b-2">
            <td className="p-1 border-r-4 text-center  ">Assists</td>
            <td className="p-1 text-center">+2 points</td>
          </tr>

          <tr className="border border-gray-500 border-b-2">
            <td className="p-1 border-r-4 text-center  ">Rebounds</td>
            <td className="p-1 text-center">+2 points</td>
          </tr>

          <tr className="border border-gray-500 border-b-2">
            <td className="p-1 border-r-4 text-center  ">Steals </td>
            <td className="p-1 text-center">+5 points</td>
          </tr>

          <tr className="border border-gray-500 border-b-2">
            <td className="p-1 border-r-4 text-center  "> Blocks</td>
            <td className="p-1 text-center">+5 points</td>
          </tr>
        </tbody>
      </table>
    </div>
  );
}
