"use client";

import Header from "../../../components/header/page";
import Sidebar from "../../../components/sidebar/Sidebar";
import TopScorers from "./components/topScorers";
import { useState } from "react";

const PremierLeague = () => {
  const [user, setUser] = useState({
    isConnected: true,
    walletAddress: "0x1234abcd5678efgh",
  });

  return (
    <div className="relative w-full h-screen text-white flex flex-col">
      <Sidebar currentImage="assets/images/premier-logo.jpeg" className="fixed left-0 top-0 h-full w-64 bg-[#1F1B2C] z-[1000]" />

      <div className="ml-8 flex flex-col flex-grow">
        <Header className="relative z-30" />

        <img
          src="assets/images/premier-league.png"
          alt="Premier League Background"
          className="absolute top-0 left-0 w-full h-full object-cover z-0"
        />

        <div className="absolute top-0 left-0 w-full h-full bg-gradient-to-b from-[#221D2F]/[0.82] via-[#1F1B2C]/[0.31] to-[#1D1829]/[0] z-10" />

        <div className="relative z-20 flex flex-col p-4 flex-grow">
          {user.isConnected ? (
            <>
              <div className="text-center mb-8">
                <h2 className="text-lg md:text-2xl tracking-[0.2em] uppercase">Welcome to</h2>
                <h1 className="text-[40px] sm:text-[70px] md:text-[95px] lg:text-[90px] font-black mt-2">Premier League</h1>
                <h3 className="text-sm sm:text-xl font-medium tracking md:text-2xl lg:text-3xl lg:tracking-[1.7em] md:mt-5 sm:tracking-[1.8em] mt-2">
                  Tournament
                </h3>
              </div>
              
              <div className="mt-8 max-w-4xl mx-auto w-full">
                <TopScorers />
              </div>
            </>
          ) : (
            <p className="mt-4 text-sm md:text-base">
              Connect your wallet to join the tournament
            </p>
          )}
        </div>
      </div>
    </div>
  );
};

export default PremierLeague;
