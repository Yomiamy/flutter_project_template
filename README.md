# Flutter Home Work

這個專案展示了一個結構穩固、具備良好架構品味 (Good Taste) 的音頻播放清單應用。它不只是將功能完成，更專注於**資料流向控制**、**零依賴 UI** 與**跨元件通訊**的優雅設計。

## 🎯 功能 (Features)

*   **無限滾動播放清單 (Infinite Scroll Playlist)**：滑動至底部時自動請求分頁資料，無縫銜接。
*   **非同步音檔下載 (Async File Download)**：支援背景下載實體音檔，並配有真實進度條顯示。
*   **本地端播放 (Local Playback)**：下載完成後，點擊可直接讀取本機端檔案，並跳轉至獨立播放詳情頁進行音效播放控制。
*   **國際化多語系 (i18n)**：全 App 字串抽離至 `.arb`，支援動態多語系切換。

## 🎯 開發重點 (Key Development Focus)

*   **狀態與介面的絕對隔離**：確保介面 (UI) 僅做畫面渲染與發起 Intent。從「判定是否還有下一頁」到「檢查檔案是否已經存在」，全數由 BLoC (Business Logic Component) 接管。
*   **流暢的跳轉體驗**：消除點擊播放後，還需要透過非同步運算尋找檔案路徑的耗時操作，達成點擊即刻開播的完美流暢度。

## 🛠 技術選擇 (Technology Choices)

*   **狀態管理 `flutter_bloc`**：強制執行單向資料流 (Unidirectional Data Flow)。我們拆分了 `GetPlayListBloc` (負責分頁清單) 和 `DownloadBloc` (負責下載狀態)。
*   **網路請求 `dio`**：抽離成 `DioProvider` 單例模式，統一註冊 BaseURL 與 Config，讓各 BLoC 無需重複撰寫底層網路配置。
*   **多語系 `intl`**：Google 官方推薦的多語系解決方案。
*   **資源與維度管理 `flutter_gen` & 常數靜態化**：
    *   以 `ColorName.color333333` 等強型別取代容易打字錯誤的字串。
    *   移除所有的 Magic Numbers (如 24.0, 16.0)，抽離為 `Sizes` 常數體系對齊 Material Design 3 規範。
*   **音訊與儲存 `audioplayers` + `path_provider`**：穩定雙平台音訊庫搭配應用程式目錄存取。

## 🧠 特殊設計考量 (Special Design Considerations)

### A. 依賴注入消除 UI 搬運工 (Bloc-to-Bloc Dependency Injection)
> 「如果你的 UI 負責把 A 狀態傳給 B 組件，你的架構就搞砸了。」

*   **痛點**：下載模組 `DownloadBloc` 需要遍歷目前的播放清單 `items`，確定哪些已經載進手機裡了。傳統作法是讓 UI 去讀取 `GetPlayListBloc`，然後用 Event 參數丟給 `DownloadBloc`。
*   **決策**：我們在 `MultiBlocProvider` 創建期，直接將 `context.read<GetPlayListBloc>()` 注入到 `DownloadBloc` 建構子內。當事件觸發時，`DownloadBloc` 直接讀取鄰居的狀態。這讓 Event 清理得極度乾淨，UI 也不必擔任狀態快遞員。

### B. 狀態驅動的路徑存取 (State-driven Path Access)
> 「用空間換取極致的流暢度與程式碼簡潔性。」

*   **痛點**：原本點擊要進入播放頁時，需要先非同步 (`await`) 組合與確認檔案路徑。這樣的操作夾在 UI 行為裡很容易飄出非同步 context 警告或卡頓。
*   **決策**：在 `DownloadState` 狀態機中，我們內建了 `downloadedPaths` 这个 Map。當任何檔案下載完成或是初始化狀態檢查確認有檔案時，直接把實體路徑塞進 Map 裡。
*   **結果**：UI 層點擊跳轉時，只需調用同步方法 `state.getDownloadedPath(id)`，就可以立即拿到實體路徑直接 Navigation 導航，達成零延遲啟動。

### C. 防禦性分頁狀態管理 (Cohesive Pagination Logic)
*   將 `page` 與 `hasMore` 收合至 `GetPlayListState` 內部做屬性封裝。
*   防禦性程式設計：`hasMore => total == null || currentLength < total`。這一行布林運算徹底消滅了以前為了等第一次 `total` 回傳而產生的一大堆 `if-else` 例外情況處理。
