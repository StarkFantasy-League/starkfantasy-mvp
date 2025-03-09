'use client'

import { motion } from "framer-motion"; 
import Image from "@/components/image";
import Button from "@/components/ui/button";

export default function Home() {
  return (
    <div className="bg-slate-950">
      {/* Hero Section */}
      <section className="relative w-full h-screen">
        <div className="absolute inset-0">
          <motion.div
            initial={{ scale: 0.8, opacity: 0 }}
            whileInView={{ scale: 1, opacity: 1 }}
            transition={{ duration: 0.6 }}
            viewport={{ once: true }}
          >
            <Image
              src="welcomepageImages/Background.png"
              alt="Background"
              className="object-cover -z-10"
            />
          </motion.div>
        </div>

        <div className="absolute left-0 right-0 bottom-[100px] flex flex-col-reverse items-center md:flex-row md:justify-between max-w-[90%] sm:max-w-[85%] lg:max-w-[70%] mx-auto text-center sm:text-left">
          <div className="text-white mt-4 sm:mt-0">
            <h1 className="sm:text-5xl font-bold sm:w-[28rem] md:text-6xl">
              StarkFantasy <span className="text-orange-500">League</span>
            </h1>
            <p className="mt-6">
              Experience the future of fantasy sports with cutting-edge blockchain technology
            </p>
            <Button variant="primary" onClick={() => console.log("Start Adventure")} className="mt-6 mx-auto sm:mx-0">
              Start Adventure
            </Button>
          </div>

          <motion.div
            className="w-[500px] h-[500px] flex items-center justify-center"
            initial={{ scale: 0.8, opacity: 0 }}
            whileInView={{ scale: 1, opacity: 1 }}
            transition={{ duration: 0.6, delay: 0.2 }}
            viewport={{ once: true }}
          >
            <Image
              src="/welcomepageImages/starkFantasyLogo.png"
              alt="Logo"
              className="w-full"
            />
          </motion.div>
        </div>
      </section>

      {/* Info Section */}

      <section className="bg-slate-950 py-16 px-4">
        <div className="flex flex-col-reverse sm:flex-row items-center justify-between max-w-[90%] sm:max-w-[85%] lg:max-w-[70%] mx-auto gap-6">
          <motion.div
            className="max-w-[600px] flex items-center justify-center"
            initial={{ scale: 0.8, opacity: 0 }}
            whileInView={{ scale: 1, opacity: 1 }}
            transition={{ duration: 0.6 }}
            viewport={{ once: true }}
          >
            <Image src="/welcomepageImages/Icon.png" alt="Icon" width={600} height={100} className="w-full sm:w-auto" />
          </motion.div>
          <div className="text-white text-center sm:text-right w-full sm:w-[550px]">
            <h2 className="text-4xl lg:text-5xl tracking-wider mb-4">What is Stark Fantasy League?</h2>
            <p>
              An innovative Web3 <span className="text-orange-500">Fantasy Sports</span> game where players assemble virtual teams, compete in tournaments, and earn rewards.
            </p>
          </div>
        </div>

        <div className="flex flex-col sm:flex-row items-center justify-center max-w-[90%] sm:max-w-[80%] mx-auto mt-10 gap-6 relative">
          <div className="lg:relative"> {/* Relative container for absolute positioning */}
            {/* Image */}
            <motion.div
              className="h-[]"
              initial={{ scale: 0.8, opacity: 0 }}
              whileInView={{ scale: 1, opacity: 1 }}
              transition={{ duration: 0.6 }}
              viewport={{ once: true }}
            >
              <Image
                src="/welcomepageImages/Group4.png"
                alt="Group"
                width={900}
                height={200}
                className="hidden lg:block"
              />
            </motion.div>

            {/* Text Overlay */}

            <div className="lg:absolute lg:left-[210px] inset-0 flex flex-col text-sm justify-center items-center sm:items-start text-white text-center sm:text-left">
              <h2 className="mb-2 text-4xl lg:text-5xl">Start your Journey</h2>
              <p className=" max-w-[80%] sm:max-w-full leading-normal">
                Create your profile, connect your wallet, and build your dream team as a professional manager. <br />
                Get into the tournaments and fight to see who is the best! The winners will get rewarded for their skills.
              </p>
              <Button variant="primary" onClick={() => console.log("Become a Manager")} className="mt-6">
                Become a Manager
              </Button>
            </div>
          </div>
          <motion.div
            initial={{ scale: 0.8, opacity: 0 }}
            whileInView={{ scale: 1, opacity: 1 }}
            transition={{ duration: 0.6, delay: 0.2 }}
            viewport={{ once: true }}
          >
            <Image src="/welcomepageImages/vector.png" alt="Vector" width={500} height={500} className="" />
          </motion.div>
        </div>
      </section>

      {/* Features Section */}
      <section className="bg-slate-900 pb-11 px-4">
        <div className="text-center py-8 text-xl sm:text-2xl font-semibold">
          <h2 className="text-white">
            Powering Fantasy Sports with <br />
            <span className="text-orange-500">Starknet</span>
          </h2>
        </div>

        <div className="flex flex-wrap justify-center gap-6">
          {[
            {
              img: "transactionlogo1.png",
              title: (
                <>
                  Scalability and Low <br /> Fees
                </>
              ),
              desc: "Enjoy fast and cost-efficient transactions powered by Starknet's Layer 2 scaling solution."
            },
            {
              img: "securitycars1.png",
              title: "Decentralization and Security",
              desc: "Your assets and game data are secured on a reliable, decentralized blockchain network."
            },
            {
              img: "securitycars2.png",
              title: "Transparency and Ownership",
              desc: "Every transaction is verifiable on-chain, ensuring fair play and full user control over digital assets."
            }
          ].map(({ img, title, desc }) => (
            <motion.div
              key={desc}
              initial={{ scale: 0.8, opacity: 0 }}
              whileInView={{ scale: 1, opacity: 1 }}
              transition={{ duration: 0.6 }}
              viewport={{ once: true }}
              className="w-full sm:w-[350px] border-orange-500 border-4 rounded-xl"
            >
              <Image src={`/welcomepageImages/${img}`} alt={desc} width={350} height={200} className="w-full" />
              <div className="text-white bg-indigo-900 p-4 rounded-b-xl">
                <h3 className="text-xl sm:text-2xl font-semibold text-center py-4 tracking-wide">{title}</h3>
                <p className="text-sm mx-auto max-w-[230px]">{desc}</p>
              </div>
            </motion.div>
          ))}
        </div>

        <div className="flex justify-center mt-9">
          <button className="bg-indigo-900 text-white px-4 py-2 rounded-lg">Learn about Starknet</button>
        </div>
      </section>

      {/* Call to Action Section */}
      <section className="bg-slate-950 text-white flex flex-col justify-center items-center py-16 px-4">
        <h2 className="text-2xl sm:text-3xl mb-6 text-center">What are you waiting for?</h2>

        <div className="flex flex-col sm:flex-row gap-10 max-w-4xl mx-auto text-center sm:text-left">
          {/* Left Section */}
          <div className="flex-1">
            <p>Start now by registering on our platform and join the Ultimate Fantasy Sports Experience!</p>
            <p className="mt-2">
              Build your dream team, compete with players worldwide, and earn real rewards—all powered by Starknet’s secure blockchain.
              Sign up now and start playing! 🚀
            </p>
            <div className="mt-6 flex justify-center">
              <button className="bg-orange-500 text-white px-5 py-2 rounded-lg shadow-md">
                Register Now
              </button>
            </div>
          </div>

          {/* Right Section */}
          <div className="flex-1">
            <p>
              Want to learn more about us? All you need is right here! From the game rules to the complete working of the on-chain system.
            </p>
            <div className="mt-4 flex justify-center flex-col items-center sm:items-start gap-3">
              <button className="bg-indigo-900 text-white px-5 py-2 rounded-lg w-full sm:w-auto shadow-md">
                About Us
              </button>
              <button className="bg-indigo-900 text-white px-5 py-2 rounded-lg w-full sm:w-auto shadow-md">
                View Our Rules
              </button>
            </div>
          </div>
        </div>
      </section>

    </div>
  );

}


