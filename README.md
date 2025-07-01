# -Dead-Man-s-Switch-A-Smart-Contract-for-Life-After-Death
Give your crypto a second chance. 
# 🧠 Dead Man's Switch – Smart Contract for ETH Legacy

This is a fully on-chain Ethereum smart contract that ensures your ETH won't get lost if you're gone.

It allows you to:
- Deposit ETH and register a nominee
- Set a check-in deadline (e.g., 30 days)
- Periodically check in to prove you're active
- Automatically transfer funds to your nominee if you don’t check in on time

## 💡 Use Cases

- **Death Planning**: If you pass away, your nominee can claim your ETH
- **Seed Phrase Backup**: Use your second wallet as a fallback if you forget your main key

## 🔐 Features

- Self-custodial, no third parties
- Nominee can't claim until timeout passes
- Top-up supported
- Nominee can be updated
- Time left checker
- Solidity-only logic, no oracles needed (yet)

## 🧱 Contract Overview

### Structs & Storage
- `struct Owner` holds fund data, nominee, check-in timestamp, etc.
- `mapping(address => Owner)` stores user records

### Key Functions

| Function           | Description                                      |
|--------------------|--------------------------------------------------|
| `depositAndNominee()` | Deposit ETH + register nominee & timeout       |
| `checkIn()`        | Refresh your check-in timestamp                  |
| `claimFunds()`     | Allows nominee to claim if timeout expired       |
| `topUp()`          | Add more ETH to your vault                       |
| `updateNominee()`  | Change the nominee anytime                       |
| `timeLeft()`       | View time remaining before nominee can claim     |

## ⛓ Deployments

| Network   | Status   |
|-----------|----------|
| Sepolia   | Coming soon |
| Mainnet   | Later stage (not deployed yet) |

## 🛠 Tech Stack

- Solidity ^0.8.x
- Remix IDE / Hardhat (optional)
- Chainlink (for future automation)

## 📸 Demo Image
> ![dead-mans-switch-demo](link_to_thumbnail_image)

## 🧑‍💻 Author

Built with care by [@buildArjun](https://x.com/buildArjun)  
Follow for more smart contract builds, threads, and real-world dApps.

## 📝 License
MIT License

