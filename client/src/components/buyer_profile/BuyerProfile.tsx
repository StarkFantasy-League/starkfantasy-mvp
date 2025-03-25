import { FaPlus } from "react-icons/fa6";
export default function BuyerProfile() {
return (
    <div className="bg-[#111826]   #111826 #1F2937 #8DF0A6  #C7CBD1 text-[#9CA3AF]">
        <div className="px-8 pt-36 pb-12 flex flex-col gap-5">
        <h1 className="text-5xl font-extrabold text-[#A7F38D]">USER PROFILE</h1>
       <div className="flex gap-6">
        <div className="flex flex-col gap-3 md:w-[34%]">
            <div className="bg-[#1F2937] py-2 px-4 ">
                <h2 className="font-bold text-3xl text-gray-300">STATS</h2>
            </div>
            <div  className="bg-[#1F2937] uppercase  p-4  flex flex-col gap-3">
               
                <div className=" flex items-center justify-between">
                <p className=" text-xl">RM RANK : </p>
                <p className="font-semibold text-xl text-[#A7F38D]">70 </p>
                </div>

                <div className=" flex items-center justify-between">
                <p className=" text-xl">VOTING POWER voREBAZ : </p>
                <p className="font-semibold text-xl text-[#A7F38D]">170 </p>
                </div>
                <div className=" flex items-center justify-between">
                <p className=" text-xl">STAKED IP : </p>
                <p className="font-semibold text-xl text-[#A7F38D]">5 </p>
                </div>
                <div className=" flex items-center justify-between">
                <p className=" text-xl">APY FOR STAKED IP : </p>
                <p className="font-semibold text-xl text-[#A7F38D]">20% </p>
                </div>
                <div className=" flex items-center justify-between">
                <p className=" text-xl">STAKED $REBAZ </p>
                <p className="font-semibold text-xl text-[#A7F38D]">20000 </p>
                </div>
                <div className=" flex items-center justify-between">
                <p className=" text-xl">APY FOR STAKED TOKENS </p>
                <p className="font-semibold text-xl text-[#A7F38D]">5% </p>
                </div>






            </div>


        </div>

        <div className="flex flex-col gap-3">
        <div className="bg-[#1F2937] py-2 px-4  ">
                <h2 className="font-bold text-3xl text-gray-300">PURCHASED IMPACT PRODUCTS</h2>
            </div>
            <div className="flex gap-4">
                <div className="bg-[#1F2937] min-h-[400px]   flex flex-col gap-3">
                 <img src='/assets/images/market.png' />   
                    <div className="flex flex-col gap-2 p-4">
                        <h3 className="text-xl text-gray-300">Community Gardens </h3 >
                        <p className="text-sm flex items-center justify-between">
                            <span> price</span>
                            <span> impact vote</span>
                        </p>
                        <p className="text-xl text-[#A7F38D] flex items-center justify-between">
                            <span> Eth 0.0005</span>
                            <span> 0.1</span>
                        </p>



                    </div>
                    
                    </div> 

            <div >
                <div className="bg-[#1F2937] min-h-[400px]    flex flex-col gap-3">
                 <img src='/assets/images/market.png' />   
                    <div className="flex flex-col gap-2 p-4">
                        <h3 className="text-xl text-gray-300">Clean Phangan </h3 >
                        <p className="text-sm flex items-center justify-between">
                            <span> price</span>
                            <span> impact vote</span>
                        </p>
                        <p className="text-xl text-[#A7F38D] flex items-center justify-between">
                            <span> Eth 0.005</span>
                            <span> 5</span>
                        </p>



                    </div>
                    
                    </div> 


            </div>

            <div >
                <div className="bg-[#1F2937]  min-h-[400px]   flex flex-col gap-3">
                 <img src='/assets/images/market.png' className="" />   
                    <div className="flex flex-col gap-2 p-4">
                        <h3 className="text-xl text-gray-300">Decleanup </h3 >
                        <p className="text-sm flex items-center justify-between">
                            <span> price</span>
                            <span> impact vote</span>
                        </p>
                        <p className="text-xl text-[#A7F38D] flex items-center justify-between">
                            <span> Eth 0.02</span>
                            <span> 10</span>
                        </p>



                    </div>
                    
                    </div> 


            </div>

            <div >
                <div className="bg-[#1F2937] min-h-[400px]  text-gray-200 items-center flex justify-center">
                 
                <FaPlus className="text-[200px]"/>
                       </div> 


            </div>


            </div>



        </div>







       </div>
        </div>
    </div>
);
}
