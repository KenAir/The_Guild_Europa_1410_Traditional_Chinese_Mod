# 【繁體中文模組】《行會 1：歐洲 1410》（The Guild 1 Remake: Europa 1410）100% 完整精修在地化與一鍵安裝指南

本指南提供《行會 1：歐洲 1410》（The Guild 1 Remake: Europa 1410）目前最完整、最高品質的 100% 繁體中文本地化模組安裝教學與功能介紹。

---

## 🌟 模組特色亮點

1. **全庫 6,845 條文字 100% 覆蓋**：
   - 包含主遊戲文本（6,196 條）、配音對白字幕（269 條）、未分類系統文本（380 條），0 缺譯、0 英文殘留。
2. **中世紀歷史、工商與政治語域深度考究**：
   - **市政政治**：全域統一公職機構為「**議事會**」（Chamber，絕非公會或辦公室）、「**公職**」（Civic Office）、「**城鎮公僕**」（Town Servants，摒棄含僕從階級歧視聯想之舊譯「僕役」）。
   - **工坊工商**：職業組織統一為「**行會**」（Guild），職階統一為「學徒 / 熟練工 / 師傅」，貨車語境統一為「**貨位**」（非船運貨艙）。
   - **神聖羅馬帝國史實稱謂**：全量規範羅馬人民之王（King of the Romans）、神聖羅馬皇帝（Holy Roman Emperor）、藩侯（Margrave）、選帝侯（Prince-Elector）、選帝票（electoral votes）、1356 年《金璽詔書》（Golden Bull）、西吉斯蒙德（Sigismund）等。
3. **P0 級機翻重大事故全面修復**：
   - 「蟑螂村」→「**白魚村**」（Roach Village 原指淡水擬鯉/白魚）
   - 「購物車」→「**貨車 / 板車**」（還原 15 世紀中世紀物流）
   - 「誠信」→「**完整度**」（建築耐久度 Integrity）
   - 「無中生有」→「**《無事生非》**」（莎士比亞經典名篇劇名）
   - 「鐵石心腸」→「**鋼鐵體魄**」（Iron Constitution 指體質與抗病力）
   - 「戴上手銬」→「**身陷囹圄**」（sit in chains 枷鎖鐵鏈）
   - 「嚴厲的處罰」→「**粗暴的對待**」（rough treatment 苛待）
4. **全域去性別化防禦**：
   - `firstborn` 統一為「**長嗣**」（不預設男性）
   - `child` 修正「喜得貴子」為「**喜獲新嗣**」
   - `widowed` 統一為「**喪偶**」
   - 婚姻生活修正「嫁入豪門」為中性「**結為連理**」
5. **無損熱插拔與安全一鍵安裝**：
   - 採用德文語言槽位（Deutsch Slot）無損置換技術，不改動遊戲主程式本體。
   - 原生支援 Windows PowerShell 5.1，具備檔案 SHA-256 完整性校驗、自動備份與安全還原機制。

---

## 📥 下載與安裝教學

### 步驟 1：下載模組
請前往 GitHub 專案發布頁下載最新版本：
🔗 **GitHub 專案庫**：[https://github.com/KenAir/The_Guild_Europa_1410_Traditional_Chinese_Mod](https://github.com/KenAir/The_Guild_Europa_1410_Traditional_Chinese_Mod)

點擊綠色 `Code` 按鈕選擇 `Download ZIP`，或直接下載 Release 壓縮包：`The Guild - Europa 1410_Traditional_Chinese_Mod_v1.0.zip`。

### 步驟 2：執行一鍵安裝
1. **完全退出遊戲**。
2. 解壓縮下載的檔案至任意資料夾。
3. 雙擊執行資料夾內的 `一鍵安裝.bat`。
   - 安裝程式會自動搜尋您的 Steam 遊戲目錄，校驗封包 SHA-256 並完成安裝。
   - 若命令提示字元顯示 `Traditional Chinese pack installed` 即代表安裝成功！

> 💡 **手動指定遊戲目錄（非預設硬碟安裝者）**：
> 若遊戲安裝於自訂硬碟路徑，可以在命令提示字元中帶參數執行：
> ```bat
> 一鍵安裝.bat -GameDir "D:\SteamLibrary\steamapps\common\The Guild - Europa 1410"
> ```

### 步驟 3：在遊戲中切換為繁體中文
1. 啟動遊戲。
2. 進入「**Settings**」（設定）→「**Game**」（遊戲設定）。
3. 在「**Text Language**」（文字語言）下拉選單中，選擇「**繁體中文（Traditional Chinese）**」。
4. **完全退出遊戲並重新啟動**，即可享受 100% 繁中沉浸體驗！

---

## 🗑️ 解除安裝教學

1. 進入遊戲設定，將「**Text Language**」切換回 **English**（英文）並退出遊戲。
2. 雙擊執行模組資料夾內的 `一鍵移除.bat`。
3. 程式將安全刪除中文封包並還原備份，遊戲將恢復原版純淨狀態。

---

## ❓ 常見問題 FAQ

**Q1：為什麼文字語言選單中替換的是德文（Deutsch）？**
> **A**：本作當前版本的選單未開放獨立的 `zh-Hant` 下拉選項。我們透過技術替換德文槽位（Deutsch Slot）並注入語系名稱資源，讓您無須修改遊戲可執行檔即可完美使用繁體中文，且完全不影響 English 的切換。

**Q2：語音會變成中文嗎？**
> **A**：本模組為純文字在地化，語音保留高品質中世紀英文原音配音。請在「語音語言」（Audio Language）中保持選擇 English。

**Q3：遊戲更新後模組會失效嗎？**
> **A**：若遊戲日後發布更新覆蓋了 Pak 目錄，您只需重新執行一次 `一鍵安裝.bat` 即可重新套用。

---

## 📜 常用關鍵名詞對照表

| 英文原名 | 繁體中文譯名 | 語境與說明 |
| :--- | :--- | :--- |
| **Guild** | **行會** | 職業工商業組織（嚴防誤譯為「公會」） |
| **Chamber** | **議事會** | 市政政治公職機構（嚴防誤譯為「公會」或「辦公室」） |
| **Civic Office** | **公職** | 城市公職職位 |
| **Town Servants** | **城鎮公僕** | 基層公職人員（摒棄含僕從階級貶義之「僕役」） |
| **Cart** | **貨車 / 馬車** | 物流運輸工具（修復機翻「購物車」事故） |
| **Integrity** | **完整度** | 建築物耐久度（修復機翻「誠信」事故） |
| **King of the Romans** | **羅馬人民之王** | 神聖羅馬帝國皇儲與歷史君王頭銜 |
| **Holy Roman Emperor** | **神聖羅馬皇帝** | 神聖羅馬帝國最高君主 |
| **Prince-Elector** | **選帝侯** | 具備皇帝選舉權之帝國大諸侯 |
| **Golden Bull** | **金璽詔書** | 1356 年神聖羅馬帝國憲章詔書 |
| **Firstborn** | **長嗣** | 家族第一個出生的孩子（落實去性別化防禦） |
| **Jiří** | **伊日** | 捷克語男性人名（全庫跨資產一致性統一） |

---

## 📄 開源許可與致謝

- **授權協議**：[MIT License](https://opensource.org/licenses/MIT)
- **維護者**：KenAir
- **框架支援**：LocAI Game Localization Framework
- 如有任何翻譯建議、錯字回報或疑難雜症，歡迎於 [GitHub Issues](https://github.com/KenAir/The_Guild_Europa_1410_Traditional_Chinese_Mod/issues) 提出反饋！
