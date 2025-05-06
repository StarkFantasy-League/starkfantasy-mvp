import Image from "@/components/image";
const playerCards = [
  { rarity: "Legendary", color: "bg-orange-500", price: 250 },
  { rarity: "Rare", color: "bg-blue-500", price: 250 },
  { rarity: "Epic", color: "bg-purple-600", price: 250 },
];

export default function MarketPage() {
  return (
    <div className="min-h-screen bg-gradient-to-b from-black via-blue-900 to-black text-white font-sans">
      {/* <nav className="flex justify-between items-center px-8 py-4 bg-black shadow-md">
        <div className="text-2xl font-bold">StarkFantasy League</div>
        <div className="flex gap-6 text-sm">
          <a href="#" className="text-orange-400">
            Home
          </a>
          <a href="#">About</a>
          <a href="#">Tournaments</a>
          <a href="#">Rules</a>
          <a href="#">Support</a>
        </div>
        <div className="text-sm bg-yellow-400 text-black px-3 py-1 rounded-full">
          0.10000 STRK
        </div>
      </nav> */}

      <div className="flex">
        <aside className="w-52 bg-gray-900 text-white min-h-screen p-6">
          <div className="mb-8 text-lg font-semibold">Premier League</div>
          <ul className="space-y-4">
            <li> Team</li>
            <li> Pools</li>
            <li className="bg-orange-500 rounded px-2 py-1">Market</li>
            <li> Results</li>
          </ul>
        </aside>

        <main className="flex-1 p-10">
          <h1 className="text-4xl font-bold mb-6">Market</h1>

          <div className="relative">
            <Image src="/assets/images/imagemvp.png" alt="Group" width={1500} height={50} />
            <p className="absolute  md:top-10 md:right-20 md:text-5xl text-3xl top-3 right- font-bold">
              CRICKET
            </p>
          </div>

          <section>
            <div className="flex gap-20 md:gap-[30rem] items-center mt-2 mb-4">
              <h2 className="text-2xl font-semibold">Player Cards</h2>
              <a href="#" className="text-orange-400 ">
                View all →
              </a>
            </div>
            <div className="block md:flex gap-4">
              <div className="grid grid-cols-1 md:grid-cols-3 gap-2 w-[70%] md:w-[45rem]">
                {playerCards.map((card, idx) => (
                  <div
                    key={idx}
                    className="bg-gray-800 p-4 rounded-xl shadow-lg"
                  >
                    <div className="w-full h-40 bg-gray-700 mb-4 rounded" />
                    <span
                      className={`text-xs font-semibold text-white px-2 py-1 rounded-full ${card.color}`}
                    >
                      {card.rarity}
                    </span>
                    <div className="mt-4 font-bold text-lg">Player Name</div>
                    <p className="text-sm text-gray-300 mb-4">
                      Description of the card element
                    </p>
                    <div className="flex justify-between items-center text-sm">
                      <span>
                        {card.price}{" "}
                        <span className="text-purple-400 font-bold">
                          STARKS
                        </span>
                      </span>
                      <span>💜 120</span>
                    </div>
                    <button className="mt-4 w-full bg-orange-500 text-white py-2 rounded-lg hover:bg-orange-600 transition">
                      Buy Now
                    </button>
                  </div>
                ))}
              </div>
              <div className=" mt-3 w-[70%] md:w-[30%] rounded-lg h-96 bg-blue-50 opacity-10 ">
                empty
              </div>
            </div>
          </section>
        </main>
      </div>
    </div>
  );
}
