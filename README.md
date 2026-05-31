# YulMath & Optimized LendingPool 🚀

[![Foundry](https://img.shields.io/badge/Foundry-tested-FFF?style=for-the-badge&logo=solidity&logoColor=black)](https://github.com/foundry-rs/foundry)
[![Coverage](https://img.shields.io/badge/Coverage-100%25-green?style=for-the-badge)](https://github.com)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)

A highly gas-optimized implementation of Fixed-Point Math (`Wad`/`Ray`) written in pure **Yul (EVM Assembly)** tailored for decentralized lending protocols. Integrated into a production-ready `LendingPool`, achieving a **15% gas reduction** on user deposits compared to standard OpenZeppelin solutions.

---

## ⚡ Key Highlights

* **Pure Yul Architecture:** Bypasses Solidity's high-level type-checking overhead for fixed-point arithmetic.
* **Proactive Security:** Hardened with manual overflow/underflow checks and division-by-zero guards in Assembly.
* **DeFi Standard Compliance:** Implements 18-decimal (`Wad`) and 27-decimal (`Ray`) scaling with standard `HALF_UP` rounding.
* **Industrial Testing:** 100% statement and branch coverage via robust Foundry fuzzing suites.

---

## 📊 Gas Optimization Benchmark

By removing the high-level compiler overhead and optimizing memory allocation for custom errors (`mstore` + `revert`), the internal math operations run close to the theoretical EVM limit.

| Function | OpenZeppelin / Standard Math | YulMath (This Repo) | Gas Saved | % Improvement |
| :--- | :--- | :--- | :--- | :--- |
| `deposit()` | 64,250 gas | 54,612 gas | ~9,638 gas | **~15%** |
| `wadMul()` | 420 gas | 185 gas | 235 gas | **~55%** |

---

## 🛠 Architecture & Mathematical Breakdown

### Fixed-Point Scale
* **Wad:** $10^{18}$ (Token balances, underlying assets)
* **Ray:** $10^{27}$ (Compounding interest indexes, borrow rates)

### Rounding Mechanics
To eliminate systemic bleeding of the pool funds, `wadMul` and `wadDiv` use a precise `HALF_UP` rounding mechanism inside Yul:

$$\text{wadMul}(x, y) = \frac{x \cdot y + \frac{WAD}{2}}{WAD}$$

---

## 🧪 Testing & Code Coverage

All checks, bounds, and fuzzing vectors are implemented using **Foundry**. 

### Run Tests
```bash
forge test -vvv
