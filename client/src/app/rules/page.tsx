import RulesTableFootball from "./components/RulesTableFootball";
import RulesTableBasketball from "./components/RulesTableBasketball";
import { FaExclamationTriangle } from "react-icons/fa";
import { FaTrophy } from "react-icons/fa";
import { FaMedal } from "react-icons/fa";

export default function RulesContent() {
  return (
    <div className="flex justify-center bg-slate-950 text-white pb-5">
      <div className="container max-w-[1250px] pt-9 flex">
        <div id="content" className="px-2 max-w-[1000px] flex flex-col gap-10">
          <h1 className="text-left  font-semibold">
            Game <span className="text-orange-500">Rules</span>
          </h1>
          <section id="1">
            <div>
              <h2 className="font-semibold text-left mb-2 ">Introduction</h2>
              <p className="text-left py-2">
                StarkFantasy League is an inovative{" "}
                <span className="text-orange-600">
                  Web3 Fantasy Sports game{" "}
                </span>
                where players assembly virtual teams, compete in a monthly
                tournament, and can recieve reward based on their results. to
                enter the tournament, players must pay a participation fee in{" "}
                <span className="text-orange-600">Starknet</span> directly from
                their wallets, ensuring a decentralized and transparent
                competiton system. In the following sections, you will learn
                about the point assignation rules and different aspects of how
                to play properly.
              </p>
            </div>
          </section>
          <section id="2">
            <div>
              <h2 className="text-left pt-3 pb-2 lg:pt-5">Soccer Rules</h2>
              <p className="text-left py-2">
                Create your team with a max of <span className="text-orange-600">16 players per soccer team</span>
                , there will be 11 in the <span className="text-orange-600">inital team</span> and 5 in the <span className="text-orange-600">bench</span>, 
                the inital players will recieve the following metrics for punctuation based
                in the different positions:
              </p>
              <RulesTableFootball />

              <div id="3" className="py-5">
                <h3 className="text-left pb-3">
                  Card Punctuation Metrics
                </h3>
                <div className="text-left">
                  <p>
                    Additionally the cards affect in a negative way the performance of your team. 
                    The yellow card has the following rules:
                  </p>
                  <ul className="ml-16 list-disc my-8">
                    <li>
                      For{" "}
                      <span className="text-orange-600">
                        players in the field
                      </span>{" "}
                      a yellow card penalize with{" "}
                      <span className="text-orange-600">-2 points</span> for the
                      player.
                    </li>
                    <li>
                      For <span className="text-orange-600">goalkeepers</span> a
                      yellow card penalize with{" "}
                      <span className="text-orange-600">-5 points</span> for the
                      player.
                    </li>
                  </ul>
                </div>
                <p className="text-left">
                  In the case of{" "}
                  <span className="text-orange-600">red card</span> it will set
                  to 0 the point of the player in that match.
                </p>
              </div>
              <div id="4" className="py-5">
                <h3 className="text-left pb-3">
                  Additional Rules
                </h3>
                <div className="text-left">
                  <div>
                    <span className="text-orange-600 font-bold">Substitutes</span>: Bench players <span className="text-orange-600">earn half the points</span> (e.g., a goal = +5 points instead of 10)
                  </div>
                  <div>
                    <span className="text-orange-600 font-bold">
                      Team Captain
                    </span>: You can select a captain for your team, these player earns <span className="text-orange-600">double point</span> (e.g.,
                    a goal <br /> = +20 points instead of 10).
                  </div>
                </div>
              </div>
            </div>
          </section>
          <section id="5">
            <h2 className="font-semibold text-left pb-2 ">
              NBA Rules
            </h2>
            <p className="text-left">
              Create your team with a max of{" "}
              <span className="text-orange-600">8 players per NBA team</span>,
              there will be 5 in the{" "}
              <span className="text-orange-600">inital team</span> and 3 in the{" "}
              <br />
              <span className="text-orange-600">bench</span>, the inital players
              will recieve the following metrics for punctuation based in the
              different positions:
            </p>
            <RulesTableBasketball />
            <div>
              <h3 className="text-left pb-2 ">
                Additional Rules
              </h3>
              <div className="text-left">
                <div>
                  <span className="text-orange-600 font-bold">
                    Substitutes
                  </span>: Bench players <span className="text-orange-600">earn half the points</span> (e.g., a player scored 20 points = +10 points instead of 20)
                </div>
                <div>
                  <span className="text-orange-600 font-bold">
                    Team Captain
                  </span>
                  : You can select a captain for your team, these player earns{" "}
                  <span className="text-orange-600">double point</span>(e.g., a
                  player <br /> scored 10 points = +20 points instead of 10).
                </div>
              </div>
            </div>
          </section>
          <section>
            <div id="6">
              <h2 className="text-left py-3 ">
                Entry Fee
              </h2>
              <p className="text-left ">
                Each official competition will have <span className="text-orange-600">different entry fee</span>,
                this is calculated based on the league performance and the amount of users in the platform.<br/>
                The private leagues or <span className="text-orange-600">friends leaugue</span> willhave an entry fee of{" "}
                <span className="text-orange-600 font-bold">210 STRK</span>
              </p>
            </div>
            
          </section>
          <section>
            <div id="7">
              <h2 className="py-2 text-left">
                Rewards
              </h2>
              <div className="text-left">
                <p>
                  Each tournament offers different rewards based on the entry fee.
                </p>
                <p>
                  <FaTrophy className="text-yellow-400 mx-3 inline-block" /> Top 3 Winnes - Earn a <span className="text-orange-600">STRK</span> prize.
                </p>
                <p>
                  <FaMedal className="text-yellow-500 mx-3 inline-block" /> 4th & 5th Place - Recive an <span className="text-orange-600"> exclusive NFT</span>
                </p>
              </div>
              <div className="flex rounded-md bg-slate-900 mt-2 p-5">
                
                <p>
                    <span className="inline-block"><FaExclamationTriangle className="text-yellow-500" /></span> <span className="font-bold">Note:</span> Private
                  tournaments (
                  <span className="text-orange-600">Friends League</span>) do
                  not qualify for rewards. Play in <span>Official</span>{" "}
                  competitions to win!
                </p>
              </div>
            </div>
          </section>
        </div>
        <div className="relative hidden md:block pt-5">
          <span className="sticky top-10">
            <ul className="border-l-2 border-white pl-4 list-inside list-disc  ">
              <li className="hover:text-orange-500">
                <a href="#1">Introduction</a>
              </li>
              <li className="hover:text-orange-500">
                <a href="#2">Soccer Rules</a>
              </li>
              <ul className="list-inside list-disc ml-3">
                <li className="hover:text-orange-500">
                  <a href="#3">Card punctuation metrics</a>
                </li>
                <li className="hover:text-orange-500">
                  <a href="#4">Additional rules</a>
                </li>
              </ul>
              <li className="hover:text-orange-500">
                <a href="#5">NBA Rules</a>
              </li>
              <li className="hover:text-orange-500">
                <a href="#6">Entry Fee</a>
              </li>
              <li className="hover:text-orange-500">
                <a href="#7">Rewards</a>
              </li>
            </ul>
          </span>
        </div>
      </div>
    </div>
  );
}
