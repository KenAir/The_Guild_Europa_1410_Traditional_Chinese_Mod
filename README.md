# The Guild - Europa 1410 繁體中文模組

本模組為《行會 1：歐洲 1410》（The Guild 1 Remake: Europa 1410）的繁體中文在地化語言包，適用於 Steam 版本。

---

## 內容說明

* **文字涵蓋**：使用者介面、劇情對白、技能與物品說明、建築描述、歷史事件、隨機事件敘事及配音字幕，共 6,912 條。
* **語言風格**：繁體中文書面語，名詞依神聖羅馬帝國歷史與中世紀城市制度翻譯。
* **運作機制**：遊戲原版未內建繁體中文選項，本模組透過替換德語（Deutsch）槽位載入，遊戲內設定選單會顯示為「繁體中文（Traditional Chinese）」。
* **語音設定**：本模組僅包含文字翻譯，語音維持英文原音，請在設定中將語音語言保持為 English。

---

## 下載與安裝

### 檔案下載
* [GitHub Releases 最新版本](https://github.com/KenAir/The_Guild_Europa_1410_Traditional_Chinese_Mod/releases/latest)
* [直接下載安裝壓縮包 (v1.1.0)](https://github.com/KenAir/The_Guild_Europa_1410_Traditional_Chinese_Mod/releases/download/v1.1.0/The_Guild_Europa_1410_Traditional_Chinese_Mod_v1.1.0.zip)

### 安裝步驟
1. 下載 `The_Guild_Europa_1410_Traditional_Chinese_Mod_v1.1.0.zip` 並解壓縮。
2. 退出遊戲。
3. 執行資料夾內的 `一鍵安裝.bat`（程式會自動偵測 Steam 遊戲目錄並安裝）。
4. 啟動遊戲，至 **Settings → Game → Text Language** 選擇 **繁體中文（Traditional Chinese）**。
5. 退出並重新啟動遊戲即可。

> **手動指定路徑**：若遊戲安裝於非預設路徑，可在命令提示字元輸入：
> ```bat
> 一鍵安裝.bat -GameDir "D:\SteamLibrary\steamapps\common\The Guild - Europa 1410"
> ```

---

## 解除安裝

1. 進入遊戲設定，將 **Text Language** 切換回 **English** 後關閉遊戲。
2. 執行資料夾內的 `一鍵移除.bat`，即可清除模組檔案並還原設定。

---

## 主要術語對照

| 原文 (English) | 譯名 | 說明 |
| :--- | :--- | :--- |
| **Guild** | **行會** | 職業商業組織 |
| **Chamber** | **議事會** | 市政公職管理機構 |
| **Civic Office** | **公職** | 市政政治職位 |
| **Master** | **師傅** | 工坊最高職級（設定選單中「主音量」單獨處理） |
| **Cart** | **貨車** | 物流運輸工具 |
| **Integrity** | **完整度** | 建築結構數值 |
| **King of the Romans** | **羅馬人民之王** | 神聖羅馬帝國君王頭銜 |
| **Prince-Elector** | **選帝侯** | 具備帝位選舉權之諸侯 |
| **Firstborn** | **長嗣** | 無性別預設，家族第一個出生的孩子 |

---

## 檔案校驗 (SHA-256)

* `Guild1_TraditionalChinese_DeutschSlot_P.pak`: `FFEFC1D1C32188477A35BB1A62719C793FC6DE2D8A66A4F063B45E0207A30C69`
* `Guild1_TraditionalChinese_DeutschSlot_P.utoc`: `7B6F224DDA8AC297B74D04A196FB586EA4AD0120951D62C70E3F4750EA1EB224`
* `Guild1_TraditionalChinese_DeutschSlot_P.ucas`: `AE83DC840CCF6EAF1077C9135D6D54A764C942EC591F659A9A2FD62E60318553`

---

## 版本記錄

### v1.1.0（2026-09-26）
- 同步支援 2026-09-26 官方遊戲更新（新增與更新 76 條文本，涵蓋領養孤兒、物價機制、店面槽位、養蜂 v2 等）
- 精修六大領域高風險長文本（381 條，涵蓋行動、建築、角色、戰鬥、物品、狀態效果）
- 白名單條目 Critic 覆核後更新（177 條）
- 各領域審校修正（436 條，涵蓋挑戰、對白、事件、政治、通知等）
- 音量設定選單「主音量」語義解耦修正

### v1.0.0（2026-09-25）
- 全文本初始翻譯與德語槽位載入架構

---

## 授權與回報

* 本模組採用 MIT 授權條款開源發布。
* 如發現翻譯遺漏或錯誤，歡迎至 [GitHub Issues](https://github.com/KenAir/The_Guild_Europa_1410_Traditional_Chinese_Mod/issues) 回報。
