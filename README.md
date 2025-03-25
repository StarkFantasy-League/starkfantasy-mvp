# StarkFantasy League 🏆⚽

![image](https://github.com/user-attachments/assets/9c3bfd85-71c5-4f7e-ae09-07f35f5da6af)


## Overview 💫

StarkFantasy is the next generation of fantasy sports built on Starknet, bringing football excitement to the blockchain world! Our platform combines the thrill of fantasy football with blockchain technology, creating a seamless, transparent, and rewarding experience.

## Features ✨

- **Create Dream Teams** 🌟 - Build your ideal squad with Premier League stars
- **Tournament Competition** 💰 - Enter tournaments with real stakes and rewards
- **Private Leagues** 👥 - Challenge friends in exclusive competitions
- **Performance-Based Rewards** 📈 - Earn based on your players' real-world performance
- **Web3 Integration** 🔗 - True ownership of your teams and rewards

## Tech Stack 🛠️

- **Frontend**: React, TypeScript, Vite
- **Smart Contracts**: Cairo (Starknet's native language)
- **Backend Framework**: Dojo (Game development framework for Starknet)
- **Testing**: Cairo Testing
- **Infrastructure**: Deployed on Starknet

## Roadmap 🗺️

### Q2 2025 (April - June): MVP Launch
- ⚽ Premier League API integration and data consumption
- 👥 Team creation system with 11-player selection
- 🧮 Core game mechanics and scoring logic implementation
- 🏆 Tournament creation and participation features
- 🔌 Cartridge Controller integration
- 🧪 Comprehensive testing and MVP launch on testnet

### Q3 2025 (July - September): Enhanced Features & Mainnet
- 💸 Payment and fee collection system implementation
- 📊 Leaderboards and competitive rankings
- 📈 Advanced statistics and analytics dashboard
- 📱 Enhanced UI/UX with mobile responsiveness
- 🚀 Mainnet deployment
- 🔐 Security audits and optimization

### Q4 2025 (October - December): Expansion Phase
- 🌍 Additional European leagues integration (La Liga, Serie A, Bundesliga)
- 🏆 FIFA World Cup special mode implementation
- 🤖 AI Manager assistant feature
- 🔄 Cross-league tournaments

### Q1 2026 (January - March): Advanced Features
- ⚡ Team synergy and chemistry bonuses system
- 🔮 Prediction pools with fantasy points
- 🏅 Seasonal rewards and achievements system
- 📊 Historical player performance tracking
- 👨‍👩‍👧‍👦 Enhanced social and community features

### Q2 2026 (April - June): Ecosystem Growth
- 🤝 Partnerships with sports data providers
- 📱 Mobile app development
- 🌐 International market expansion

## Getting Started 🚀

The branch need to follows the next format: 
(if a feature)
feat/name-branch

And commits need to have the next messages: 
(If feature)
feat: change-description
(if update)
update: change-description
(if remove)
remove: change-description

## 🚀 Installation

Clone the repository** to your local machine:

```sh
git clone https://github.com/StarkFantasy-League/starkfantasy-mvp.git
```

## 📌 Client Requirements

- Node.js `>= 18.x`
- pnpm `>= 8.x` (optional) or npm `>= 9.x`

Install dependencies using your preferred package manager:

### Enter frontend:
```sh
cd client
```

### Using pnpm:
```sh
pnpm install
```

### Using npm:
```sh
npm install
```

## 🔥 Running the Project

To start the development server on port `5173`:

### With pnpm:
```sh
pnpm dev
```

### With npm:
```sh
npm run dev
```

The application will be available at `http://localhost:5173`.

## 📌 Contract/Dojo Requirements

- Scarb `>= 2.9.2`
- Dojo `>= 1.2.2`

### Enter contract:
```sh
cd contract
```
### Run these commands to verify everything is working as expected:
```sh
sozo build / sozo test
```
