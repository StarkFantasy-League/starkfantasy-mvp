// src/app/leagues/components/table.tsx

import React, { useState, useMemo, useEffect } from "react";
import { motion, AnimatePresence } from "framer-motion";
import sortingArr from "../../../../public/icons/sortingArrows.svg";
import arrowDown from "../../../../public/icons/arrowDown.svg";
import search from "../../../../public/icons/search.svg";

interface Player {
	name: string;
	team: string;
	position: string;
	price: number;
	pointsPerMatch: number;
	selectedPercentage: number;
	goals: number;
	assists: number;
	minutesPlayed: number;
}

interface TableProps {
	players: Player[];
}

const Table: React.FC<TableProps> = ({ players: initialPlayers }) => {
	const [sortConfig, setSortConfig] = useState<{
		key: keyof Player;
		direction: "asc" | "desc";
	} | null>(null);
	const [positionFilter, setPositionFilter] = useState("ALL");
	const [teamFilter, setTeamFilter] = useState("ALL");
	const [priceFilter, setPriceFilter] = useState("ALL");
	const [searchQuery, setSearchQuery] = useState("");
	const [displayedPlayers, setDisplayedPlayers] = useState<Player[]>([]);
	const [isSearchExpanded, setIsSearchExpanded] = useState(false);

	useEffect(() => {
		const timer = setTimeout(() => {
			setDisplayedPlayers(initialPlayers);
		}, 100);
		return () => clearTimeout(timer);
	}, [initialPlayers]);

	const positions = useMemo(() => {
		const uniquePositions = Array.from(
			new Set(initialPlayers.map((player) => player.position))
		);
		return ["ALL", ...uniquePositions];
	}, [initialPlayers]);

	const teams = useMemo(() => {
		const uniqueTeams = Array.from(new Set(initialPlayers.map((player) => player.team)));
		return ["ALL", ...uniqueTeams];
	}, [initialPlayers]);

	const priceRanges = useMemo(() => {
		return ["ALL", "< 200", "200–249", "250+"];
	}, []);

	const filteredPlayers = useMemo(() => {
		let result = [...initialPlayers];

		if (searchQuery) {
			result = result.filter((player) =>
				player.name.toLowerCase().includes(searchQuery.toLowerCase())
			);
		}

		if (positionFilter !== "ALL") {
			result = result.filter((player) => player.position === positionFilter);
		}

		if (teamFilter !== "ALL") {
			result = result.filter((player) => player.team === teamFilter);
		}

		if (priceFilter !== "ALL") {
			if (priceFilter === "< 200") {
				result = result.filter((player) => player.price < 200);
			} else if (priceFilter === "200–249") {
				result = result.filter((player) => player.price >= 200 && player.price <= 249);
			} else if (priceFilter === "250+") {
				result = result.filter((player) => player.price >= 250);
			}
		}

		if (sortConfig) {
			result.sort((a, b) => {
				if (a[sortConfig.key] < b[sortConfig.key])
					return sortConfig.direction === "asc" ? -1 : 1;
				if (a[sortConfig.key] > b[sortConfig.key])
					return sortConfig.direction === "asc" ? 1 : -1;
				return 0;
			});
		}

		return result;
	}, [initialPlayers, searchQuery, positionFilter, teamFilter, priceFilter, sortConfig]);

	useEffect(() => {
		setDisplayedPlayers(filteredPlayers);
	}, [filteredPlayers]);

	const sortBy = (key: keyof Player) => {
		let direction: "asc" | "desc" = "asc";
		if (sortConfig && sortConfig.key === key && sortConfig.direction === "asc") {
			direction = "desc";
		}
		setSortConfig({ key, direction });
	};

	const handlePositionChange = (e: React.ChangeEvent<HTMLSelectElement>) => {
		setPositionFilter(e.target.value);
	};

	const handleTeamChange = (e: React.ChangeEvent<HTMLSelectElement>) => {
		setTeamFilter(e.target.value);
	};

	const handlePriceChange = (e: React.ChangeEvent<HTMLSelectElement>) => {
		setPriceFilter(e.target.value);
	};

	const rowVariants = {
		hidden: { opacity: 0 },
		visible: (i: number) => ({
			opacity: 1,
			transition: {
				delay: i * 0.1,
				duration: 0.8,
				ease: "easeInOut",
			},
		}),
		exit: { opacity: 0, transition: { duration: 0.2, ease: "easeInOut" } },
	};

	const arrowVariants = {
		rotate: {
			rotate: 360,
			transition: { duration: 0.5, ease: "easeInOut" },
		},
	};

	const searchVariants = {
		collapsed: {
			width: "60px",
			transition: { duration: 0.3, ease: "easeInOut" },
		},
		expanded: {
			width: "200px",
			transition: { duration: 0.3, ease: "easeInOut" },
		},
	};

	return (
		<div className="w-full px-[25px] pt-[30px] pb-[84px] bg-[#0F172BE5] text-white rounded-lg">
			<div className="flex justify-between gap-4 flex-wrap mb-[20px]">
				<div className="flex gap-[14px] flex-wrap md:flex-nowrap">
					<div className="flex flex-col w-full">
						<label className="text-gray-300 text-base font-medium mb-1 text-center">
							Position
						</label>
						<div className="relative">
							<select
								className="appearance-none bg-indigo-900 text-white text-[14px] font-medium py-[10px] px-[15px] rounded-[8px] focus:outline-none focus:ring-1 focus:transparent w-full md:w-[205px]"
								value={positionFilter}
								onChange={handlePositionChange}
								aria-label="Filter by position"
							>
								{positions.map((position) => (
									<option key={position} value={position}>
										{position}
									</option>
								))}
							</select>
							<span className="absolute right-3 top-1/2 transform -translate-y-1/2 text-white">
								<img src={arrowDown} alt="Dropdown arrow" />
							</span>
						</div>
					</div>

					<div className="flex flex-col w-full">
						<label className="text-gray-300 text-base font-medium mb-1 text-center">
							Team
						</label>
						<div className="relative">
							<select
								className="appearance-none bg-indigo-900 text-white text-[14px] font-medium py-[10px] px-[15px] rounded-[8px] focus:outline-none focus:ring-1 focus:transparent w-full md:w-[205px]"
								value={teamFilter}
								onChange={handleTeamChange}
								aria-label="Filter by team"
							>
								{teams.map((team) => (
									<option key={team} value={team}>
										{team}
									</option>
								))}
							</select>
							<span className="absolute right-3 top-1/2 transform -translate-y-1/2 text-white">
								<img src={arrowDown} alt="Dropdown arrow" />
							</span>
						</div>
					</div>

					<div className="flex flex-col w-full">
						<label className="text-gray-300 text-base font-medium mb-1 text-center">
							Price (STRK)
						</label>
						<div className="relative">
							<select
								className="appearance-none bg-indigo-900 text-white text-[14px] font-medium py-[10px] px-[15px] rounded-[8px] focus:outline-none focus:ring-1 focus:transparent w-full md:w-[205px]"
								value={priceFilter}
								onChange={handlePriceChange}
								aria-label="Filter by price"
							>
								{priceRanges.map((price) => (
									<option key={price} value={price}>
										{price}
									</option>
								))}
							</select>
							<span className="absolute right-3 top-1/2 transform -translate-y-1/2 text-white">
								<img src={arrowDown} alt="Dropdown arrow" />
							</span>
						</div>
					</div>
				</div>

				<div className="relative flex items-end">
					<motion.div
						className="relative"
						variants={searchVariants}
						animate={isSearchExpanded ? "expanded" : "collapsed"}
					>
						<input
							type="text"
							placeholder={isSearchExpanded ? "Search players..." : ""}
							className="bg-indigo-900 text-white text-[14px] font-medium py-[20px] px-[20px] rounded-[10px] focus:outline-none focus:ring-2 focus:transparent w-full"
							value={searchQuery}
							onChange={(e) => setSearchQuery(e.target.value)}
							onFocus={() => setIsSearchExpanded(true)}
							onBlur={() => {
								if (!searchQuery) setIsSearchExpanded(false);
							}}
							aria-label="Search players"
						/>
						<span
							className="absolute right-[20px] top-1/2 transform -translate-y-1/2 text-white cursor-pointer"
							onClick={() => setIsSearchExpanded(true)}
						>
							<img src={search} alt="search" />
						</span>
					</motion.div>
				</div>
			</div>

			<div
				className="overflow-x-auto overflow-y-auto"
				style={{
					height: "606px",
					position: "relative",
				}}
			>
				<table className="w-full text-left table-fixed min-w-[700px]">
					<thead className="z-40">
						<tr className="bg-indigo-800 text-gray-300 font-normal">
							<th className="table-ha text-left  text-[17px] rounded-tl-[10px]  w-[250px]">
								Player
							</th>
							<th className="table-ha text-center text-[17px]   border-r-[0.5px] border-gray-300 w-[120px]">
								Price
							</th>
							<motion.th
								className="table-ha cursor-pointer hover:bg-indigo-700 transition-colors text-center   w-[120px]"
								onClick={() => sortBy("pointsPerMatch")}
								aria-label="Sort by points per match"
								whileHover={{
									y: -2,
									transition: { duration: 0.2, ease: "easeInOut" },
								}}
							>
								<span className="flex font-normal text-[17px] items-center justify-center">
									Pts/Match
									<motion.img
										className="pl-2 w-[28px]"
										src={sortingArr}
										alt="Sort"
										variants={arrowVariants}
										animate={
											sortConfig?.key === "pointsPerMatch"
												? "rotate"
												: undefined
										}
										key={`pointsPerMatch-${
											sortConfig?.key === "pointsPerMatch"
												? sortConfig.direction
												: "none"
										}`}
									/>
								</span>
							</motion.th>
							<motion.th
								className="table-ha cursor-pointer  hover:bg-indigo-700 transition-colors text-center  w-[120px]"
								onClick={() => sortBy("selectedPercentage")}
								aria-label="Sort by selected percentage"
								whileHover={{
									y: -2,
									transition: { duration: 0.2, ease: "easeInOut" },
								}}
							>
								<span className="flex items-center text-base justify-center">
									Selected
									<motion.img
										className="pl-2 w-[28px]"
										src={sortingArr}
										alt="Sort"
										variants={arrowVariants}
										animate={
											sortConfig?.key === "selectedPercentage"
												? "rotate"
												: undefined
										}
										key={`selectedPercentage-${
											sortConfig?.key === "selectedPercentage"
												? sortConfig.direction
												: "none"
										}`}
									/>
								</span>
							</motion.th>
							<motion.th
								className="table-ha cursor-pointer hover:bg-indigo-700 transition-colors text-center  w-[100px]"
								onClick={() => sortBy("goals")}
								aria-label="Sort by goals"
								whileHover={{
									y: -2,
									transition: { duration: 0.2, ease: "easeInOut" },
								}}
							>
								<span className="flex items-center text-base justify-center">
									Goals
									<motion.img
										className="pl-2 w-[28px]"
										src={sortingArr}
										alt="Sort"
										variants={arrowVariants}
										animate={sortConfig?.key === "goals" ? "rotate" : undefined}
										key={`goals-${
											sortConfig?.key === "goals"
												? sortConfig.direction
												: "none"
										}`}
									/>
								</span>
							</motion.th>
							<motion.th
								className="table-ha cursor-pointer hover:bg-indigo-700 transition-colors text-center  w-[100px]"
								onClick={() => sortBy("assists")}
								aria-label="Sort by assists"
								whileHover={{
									y: -2,
									transition: { duration: 0.2, ease: "easeInOut" },
								}}
							>
								<span className="flex items-center text-base justify-center">
									Assists
									<motion.img
										className="pl-2 w-[28px]"
										src={sortingArr}
										alt="Sort"
										variants={arrowVariants}
										animate={
											sortConfig?.key === "assists" ? "rotate" : undefined
										}
										key={`assists-${
											sortConfig?.key === "assists"
												? sortConfig.direction
												: "none"
										}`}
									/>
								</span>
							</motion.th>
							<motion.th
								className="table-ha rounded-tr-[10px] cursor-pointer hover:bg-indigo-700 transition-colors text-center sticky top-0 bg-indigo-800 w-[150px]"
								onClick={() => sortBy("minutesPlayed")}
								aria-label="Sort by minutes played"
								whileHover={{
									y: -2,
									transition: { duration: 0.2, ease: "easeInOut" },
								}}
							>
								<p className="flex items-center text-base justify-center rounded-tr-[10px]">
									Mins. Played
									<motion.img
										className="pl-2 w-[28px]"
										src={sortingArr}
										alt="Sort"
										variants={arrowVariants}
										animate={
											sortConfig?.key === "minutesPlayed"
												? "rotate"
												: undefined
										}
										key={`minutesPlayed-${
											sortConfig?.key === "minutesPlayed"
												? sortConfig.direction
												: "none"
										}`}
									/>
								</p>
							</motion.th>
						</tr>
					</thead>
					<tbody>
						<AnimatePresence>
							{displayedPlayers.map((player, index) => (
								<motion.tr
									key={`${player.name}-${player.team}-${player.price}-${player.pointsPerMatch}-${index}`}
									className="border-b-[0.5px] border-gray-300 bg-gray-800 hover:bg-gray-900 transition-colors"
									variants={rowVariants}
									initial="hidden"
									animate="visible"
									exit="exit"
									custom={index}
									transition={{ duration: 0.3, ease: "easeInOut" }}
									style={{
										height: "50px",
									}}
								>
									<td
										className="px-[10px] py-[8px] flex  gap-3 items-center space-x-3"
										style={{ minHeight: "50px" }}
									>
										<div className="w-8 h-8 bg-[#D9D9D9] rounded-full"></div>
										<div>
											<p className="text-sm">{player.name}</p>
											<p className="text-amber-500 text-sm flex items-center gap-1">
												<span>{player.team}</span>{" "}
												<span className="font-bold">|</span>{" "}
												<span>{player.position}</span>
											</p>
										</div>
									</td>
									<td
										className="border-r-[0.5px] border-gray-300 w-[120px]"
										style={{ minHeight: "48px" }}
									>
										<div className="text-center">
											<p className="text-sm font-bold">{player.price}</p>
											<p className="text-sm font-bold">STRK</p>
										</div>
									</td>
									<td className="table-cell">{player.pointsPerMatch}</td>
									<td className="table-cell">{player.selectedPercentage}%</td>
									<td className="table-cell">{player.goals}</td>
									<td className="table-cell">{player.assists}</td>
									<td className="table-cell">{player.minutesPlayed}</td>
								</motion.tr>
							))}
						</AnimatePresence>
					</tbody>
				</table>
			</div>
		</div>
	);
};

export default Table;
