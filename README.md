# Claude Code 實驗迴圈體驗（約 15–20 分鐘）

[English](README.en.md)

讓 Claude Code 自己跑「實驗 → 驗證 → 調整 → 下一輪」，直到達到明確的目標。
背景說明見[用 Claude Code 反覆實驗直到達標：工作流程記錄](https://yenjia.github.io/zh-tw/posts/experiment-loop/)。

任務：28×28 的乳房超音波小圖，分類良性／惡性。資料夾裡只有資料，規則由你用一段 prompt 交代，
Claude 會自己寫 `CLAUDE.md`、實驗紀錄與程式。

## 準備

需要 Python 3.10 以上與 Claude Code，只用 CPU。如果已經裝了 numpy、scikit-learn、matplotlib，可以跳過建環境：

```bash
git clone https://github.com/yenjia/claude-loop-demo.git
cd claude-loop-demo
python3 -m venv .venv
.venv/bin/pip install -r requirements.txt     # Windows：.venv\Scripts\pip install -r requirements.txt
```

沒有 git 也可以在 GitHub 頁面按 Code → Download ZIP。

## 開始

```bash
cd claude-loop-demo
claude
```

建議切到 auto mode（Shift+Tab），貼上這段 prompt：

```text
這個資料夾是乳房超音波小圖的良惡性分類，說明見 data/README.md。請先把以下規則寫進 CLAUDE.md，再開始跑實驗迴圈，直到達標：

- 目標：train 上 5-fold CV AUC ≥ 0.80，且 val AUC ≥ 0.80。最多 6 輪；沒達標就如實回報差距與瓶頸，不要對 val 調參湊數字。
- 切分固定，不准重切或合併。選模與調參只看 train 的 CV，val 每輪只評估一次 CV 已選定的設定。
- 正式實驗前先用打亂的標籤跑一次 pipeline，確認沒有資料洩漏。
- 任何達標的結果都要先做捷徑檢查：看判別訊號落在影像的哪裡，並把圖存下來。訊號不在組織上就排除後重跑，兩個數字都要報告，只有乾淨的結果才算數。
- 每輪寫進 EXPERIMENTS.md 之前，核對預測筆數，並由預測檔重算 AUC。
- 只用 numpy、scikit-learn、matplotlib，不安裝其他套件（有 .venv 就用 .venv 裡的 python）。只用 CPU，每個實驗 2 分鐘內跑完。
- 只讀寫這個資料夾內的檔案。每輪記錄在 EXPERIMENTS.md：假設、設定、CV、val、結論。
```

接下來盡量不要介入。可以注意：

- 它寫出來的 `CLAUDE.md` 和你給的 prompt 有什麼不同
- 它在正式實驗前做了什麼檢查
- 第一次「達標」時，它有沒有直接停下來
- 最後有沒有達標、`EXPERIMENTS.md` 每一輪寫了什麼

## 跑完之後

看 `EXPERIMENTS.md` 和存下來的圖：最後有沒有達標？過程中它抓到了什麼問題？
資料做了哪些修改，寫在上面那篇文章的「自己跑一次」一節（跑完再看）。

給下一個人用之前，執行 `./reset.sh` 還原（Windows 可以用 `git clean -fdx -e .venv`），
只會留下資料、說明、授權與 `.venv`。

## 授權與出處

- 程式與說明：MIT，見 `LICENSE`。
- 資料改自 BreastMNIST（MedMNIST v2，CC BY 4.0），重新切分並為教學目的做過修改，不是原始資料的忠實副本，請勿用於研究。原始資料：
  - Jiancheng Yang et al. “MedMNIST v2 – A large-scale lightweight benchmark for 2D and 3D biomedical image classification.” *Scientific Data*, 2023.
  - Walid Al-Dhabyani et al. “Dataset of breast ultrasound images.” *Data in Brief*, 2020.
