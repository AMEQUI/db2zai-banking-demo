# IBM Db2 AI for z/OS — Banking EOD Batch Optimization Demo & Web Simulator

[![GitHub Pages](https://img.shields.io/badge/Live%20Demo-GitHub%20Pages-0f62fe?style=flat&logo=github)](https://AMEQUI.github.io/db2zai-banking-demo/)
[![Db2 for z/OS](https://img.shields.io/badge/Db2%20for%20z%2FOS-v13-blue)](https://www.ibm.com/products/db2-for-zos)
[![IBM Carbon Design](https://img.shields.io/badge/IBM%20Carbon-Design%20System-black)](https://carbondesignsystem.com/)

An end-to-end interactive demonstration kit showcasing **IBM Db2 AI for z/OS (Db2ZAI)** optimizing an overnight core banking batch workload.

---

## 🎯 Demonstration Scenario

* **Workload:** Nightly End-of-Day (EOD) Transaction Ledger & Balance Reconciliation batch (`BNK7100B`).
* **Problem:** Static SQL statement (#420) runs with `INDEXONLY = 'N'`, generating **2.48M getpages** and taking **47 seconds** per cycle.
* **Db2 AI for z/OS Action:** Flags the slow access path and surfaces an actionable tuning insight to extend the existing index into a **Covering Index**.
* **Outcome:** Package rebind enables **100% Index-Only access (`INDEXONLY = 'Y'`)**, dropping getpages by **98.2%** and elapsed time down to **3.05 seconds** with **zero application code changes**.

---

## 🚀 Live Interactive Simulator

Run the interactive web simulation directly from your browser:  
👉 **[Launch Live Web Simulator](https://AMEQUI.github.io/db2zai-banking-demo/)**

Features included in the web simulation:
1. **System & Package Assessment:** Inspect monitored package `COL_BANKING.BNK7100B` and detect Stmt #420 anomaly.
2. **AI Tuning Insight:** Interactive recommendation card with projected cost delta and DDL script.
3. **Simulated DDL & Package Rebind:** Live animated rebind execution progress with `EXPLAIN(YES)`.
4. **Side-by-Side Verification:** Access path and performance metrics delta with presenter notes drawer (`🎙️`).

---

## 📂 Repository Contents

```text
db2zai-banking-demo/
│
├── index.html                        # Interactive Web Simulation (Carbon Design System)
│
├── docs/
│   └── demo-runbook.md               # Step-by-step presenter script & client pitch
│
├── mainframe-artifacts/              # z/OS Sandbox Reference Assets
│   ├── cobol/
│   │   └── BNK7100B.cbl              # Core banking COBOL batch program (Stmt #420)
│   ├── jcl/
│   │   ├── BNKEOD01.jcl              # Batch execution JCL (IKJEFT01)
│   │   └── REBIND.jcl                # Db2 Package rebind job with EXPLAIN(YES)
│   └── ddl/
│       ├── 01_baseline_tables.sql    # Table & initial non-covering index DDL
│       └── 02_recommended_index.sql  # Db2AI recommended covering index DDL
│
└── .github/
    └── workflows/
        └── deploy-pages.yml          # GitHub Pages automated deployment workflow
```

---

## 📊 Before vs. After Optimization Summary

| Metric / Parameter | Baseline (Before Db2ZAI) | Optimized (After Db2ZAI) | Improvement |
| :--- | :--- | :--- | :--- |
| **Access Type (`ACCESSTYPE`)** | `I` (Index Scan) | `I` (Covering Index Scan) | Optimized |
| **Index-Only Access (`INDEXONLY`)** | ❌ `N` (Table page reads) | 🟢 **`Y` (Index-Only)** | **100% Table I/O Eliminated** |
| **Matching Columns (`MATCHCOLS`)** | 1 (`ACCT_ID`) | 2 (`ACCT_ID`, `TXN_DATE`) | +100% Filter Efficiency |
| **Buffer Pool Getpages** | 2,480,120 | 44,210 | **-98.2% Reduction** |
| **Class 2 CPU Time** | 18.42s | 1.18s | **-93.6% CPU Savings** |
| **Batch Elapsed Time** | 47.10s | 3.05s | **-93.5% Faster** |
| **Optimizer Estimated Cost** | 84,250 Timerons | 6,810 Timerons | **-91.9% Lower Cost** |
