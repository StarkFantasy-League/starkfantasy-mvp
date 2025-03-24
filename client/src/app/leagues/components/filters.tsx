import React, { useState } from "react";

interface FiltersProps {
  title: string;
  options: string[];
  selectedValue: string;
  onChange: (value: string) => void;
}

const Filters: React.FC<FiltersProps> = ({
  title,
  options,
  selectedValue,
  onChange,
}) => {
  return (
    <div className="flex flex-col items-center">
      <label className="text-gray-300 text-sm mb-1 text-center">{title}</label>

      <div className="relative w-48">
        <select
          value={selectedValue}
          onChange={(e) => onChange(e.target.value)}
          className="bg-indigo-900 text-white px-4 py-2 rounded-2xl w-full appearance-none focus:outline-none focus:ring-2 focus:ring-indigo-500 text-m "
        >
          {options.map((option) => (
            <option key={option} value={option}>
              {option}
            </option>
          ))}
        </select>
        <div className="absolute inset-y-0 bottom-3 right-3 flex items-center pointer-events-none text-2xl">
          ⌄
        </div>
      </div>
    </div>
  );
};

const PositionFilter = () => {
  const [selectedPosition, setSelectedPosition] = useState("All");

  return (
    <div className="p-4 min-h-screen flex items-center justify-center">
      <Filters
        title="Position"
        options={["All", "Forward", "Midfielder", "Defender", "Goalkeeper"]}
        selectedValue={selectedPosition}
        onChange={setSelectedPosition}
      />
    </div>
  );
};

export default PositionFilter;
