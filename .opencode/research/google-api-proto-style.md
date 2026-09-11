# Google API Proto Style: Documentation & Commenting Conventions

## Summary

GoogleのAPI設計規約（AIP-192）では、protoファイル内の**すべての公開コンポーネント**（service, rpc, message, field, enum, enum value）に**leading comment**が**必須**である。コメントはCommonMarkフォーマットを使用し、最初の文は主語を省略した三人称現在形で記述する。buf.ioのCOMMENTSカテゴリはこれらのルールを個別のlintルールとして機械的に検査可能。

---

## 1. AIP-192: Documentation（Google API Style Guide）

> Source: https://google.aip.dev/192

### 1.1 必須コメント要素（MUST）

AIP-192では、protoファイル内の**すべての公開コンポーネント**にコメントが**必須（must）**：

| 要素 | 必須度 | コメントスタイル |
|------|--------|----------------|
| **File** | 推奨 | ファイル概要（License headerの次） |
| **Service** | **必須** | サービスの目的と機能の説明 |
| **RPC (Method)** | **必須** | 操作の説明 |
| **Message** | **必須** | メッセージの内容と用途 |
| **Field** | **必須** | フィールドの内容、単位、制約 |
| **Enum** | **必須** | 列挙型の目的 |
| **Enum Value** | **必須** | 各値の意味 |
| **Oneof** | **必須** | 選択肢の説明 |

### 1.2 コメントの文体規約

#### 最初の文の形式（MUST — bufがenforce可能な範囲外だがAIPで規定）

- **主語を省略**する三人称現在形
- 先頭は大文字で開始、ピリオドで終了
- 例:
  ```proto
  // Creates a book under the given publisher.
  rpc CreateBook(CreateBookRequest) returns (Book);
  ```

#### 言語

- **アメリカ英語**で記述
- ジャーゴン、俗語、比喩、ポップカルチャー参照は避ける
- 非英語話者にも理解できるよう平易な表現を使用

### 1.3 コメントの内容ガイドライン

メッセージ・フィールドのコメントでは、以下の質問を考慮すべき（SHOULD）：

- **What is it?** — 何を表すか
- **How do you use it?** — どう使うか
- **成功/失敗時の動作** — 何が起きるか
- **Is it idempotent?** — 冪等性
- **What are the units?** — 単位（メートル、度、ピクセル等）
- **What are the side effects?** — 副作用
- **Common errors** — よくあるエラー
- **Input format** — 入力フォーマット
- **Value range** — 値の範囲（例: `[0.0, 1.0)`、包含/除外）
- **String length** — 最小/最大長、許容文字
- **Always present?** — 常に存在するか（条件付きの説明）
- **Default setting** — デフォルト値の説明

### 1.4 フォーマット規約

| 規約 | 必須度 | 内容 |
|------|--------|------|
| CommonMark形式 | **必須** | Markdownを使用 |
| 見出し・テーブル | **禁止** | ツール互換性の問題のため |
| コードフォント | 推奨 | フィールド名・メソッド名・リテラルにバッククォート |
| 生HTML | **禁止** | 使用不可 |
| ASCII Art | **禁止** | 代わりに外部リンクで図表を参照 |
| 外部リンク | 条件付き | 絶対URL（`https`）を使用、ホストを仮定しない |

### 1.5 クロスリファレンス（他要素へのリンク）

```proto
// Fully-qualified: [Book][google.example.v1.Book]
// Scope-relative:  [Sci-Fi genre][Genre.GENRE_SCI_FI]
// Implied:         [Book][] (equates to [Book][Book])
```

**注意**: フィールド名を含む参照は**解決されない**:
- ❌ `[author][Book.author.family_name]`
- ✅ `[author][Author.family_name]`

### 1.6 非推奨（Deprecation）のコメント形式

```proto
// Deprecated: Use `NewMethod` instead. This method will be removed on 2025-01-01.
// Deprecated: No alternative exists. This field was removed because the underlying
// feature is no longer supported.
```

- `deprecated` optionを`true`に設定（MUST）
- コメントの**最初の行**を`"Deprecated: "`で開始（MUST）
- 代替手段または非推奨の理由を記載（MUST）

### 1.7 内部コメント（Internal Comments）

内部メモは `(--` と `--)` で囲む：

```proto
// This field is used for tracking internal metrics.
// (-- TODO(b/12345): Migrate to the new metric format. --)
string legacy_metric = 1;
```

- TODO/FIXMEディレクティブは内部マーク必須
- **leading commentsのみ**使用（trailing comments禁止）
- leading + trailingの両方を同一要素に使用しない（内部アノテーション欠落の原因）

---

## 2. Protocol Buffers公式スタイルガイド

> Source: https://protobuf.dev/programming-guides/style/

### 2.1 コメント形式

Protocol Buffersは3種類のコメント形式をサポート：

| 形式 | 用途 | ツールによる抽出 |
|------|------|-----------------|
| `// ...` (Single-line) | **推奨** — ドキュメントコメント | ✅ buf lintが認識 |
| `/* ... */` (Block) | ファイルヘッダー等 | ⚠️ buf lintが認識しない |
| `/// ...` (Doc comment) | 言語拡張用 | 言語依存 |

### 2.2 ファイル構造（コメントを含む推奨順序）

1. **License header** (if applicable)
2. **File overview** (ファイル全体の説明)
3. Syntax
4. Package
5. Imports (sorted)
6. File options
7. Everything else (messages, services, enums...)

`buf format`が 3-7 を自動整列。1-2 は手動管理。

### 2.3 Proto3コメントの3種類（言語仕様）

> Source: https://protobuf.dev/programming-guides/proto3/#comments

1. **Leading comment（先頭コメント）**: 要素の直前にある`//`コメント
   - ツールがドキュメントとして認識
   - **AIP-192 / buf lintで唯一有効なドキュメントコメント形式**

2. **Trailing comment（末尾コメント）**: 要素と同じ行の末尾の`//`コメント
   - ツールが無視する可能性がある
   - AIP-192では使用を推奨しない

3. **Detached comment（分離コメント）**: 要素間に独立した`//`コメント
   - ツールが無視する可能性がある
   - AIP-192では使用を推奨しない

---

## 3. buf.io Best Practices

> Source: https://buf.build/docs/best-practices/style-guide/
> Source: https://buf.build/docs/lint/rules/#comments

### 3.1 コメント規約

| 規約 | 詳細 |
|------|------|
| コメント記号 | `//` のみ使用、`/* */` は避ける |
| 過剰に文書化 | 「過剰にドキュメント化」することを推奨 |
| 完全な文 | 完全な文で記述 |
| 位置 | 要素の**上に**配置（inlineではない） |

### 3.2 COMMENTS lintカテゴリ（buf lintで enforce）

buf.yaml で有効化:

```yaml
version: v2
lint:
  use:
    - STANDARD
    - COMMENTS
```

| ルール名 | 対象 | 説明 |
|---------|------|------|
| `COMMENT_SERVICE` | service | サービスに非空leading comment必須 |
| `COMMENT_RPC` | rpc | RPCに非空leading comment必須 |
| `COMMENT_MESSAGE` | message | メッセージに非空leading comment必須 |
| `COMMENT_FIELD` | field | フィールドに非空leading comment必須 |
| `COMMENT_ENUM` | enum | 列挙型に非空leading comment必須 |
| `COMMENT_ENUM_VALUE` | enum value | 列挙値に非空leading comment必須 |
| `COMMENT_ONEOF` | oneof | oneofに非空leading comment必須 |

**重要**: **Leading commentのみ**がカウントされる。trailing/detached commentは無視される。

---

## 4. 現在のコードベースとの比較

### 4.1 現状分析（13ファイル）

| ファイル | コメント率 | Fields: | Example: | Notes: | コードブロック(```) |
|---------|----------|---------|----------|--------|----------------------|
| plugin.proto | 73.0% | ✅ | ✅ | ❌ | ✅ |
| plugin_manifest.proto | 73.1% | ✅ | ✅ | ❌ | ✅ |
| package_config.proto | 77.6% | ✅ | ✅ | ❌ | ✅ |
| permission.proto | 69.9% | ✅ | ✅ | ✅ | ✅ |
| workflow.proto | 53.8% | ✅ | ❌ | ✅ | ❌ |
| plugin_service.proto | 72.6% | ❌ | ❌ | ❌ | ❌ |
| workflow_service.proto | 39.6% | ❌ | ✅ | ❌ | ❌ |
| version.proto | 63.5% | ❌ | ❌ | ❌ | ❌ |
| model.proto | 47.2% | ❌ | ❌ | ❌ | ❌ |
| model_service.proto | ~30% | ❌ | ❌ | ❌ | ❌ |
| provider.proto | 48.1% | ❌ | ❌ | ❌ | ❌ |
| provider_service.proto | 40.3% | ❌ | ❌ | ❌ | ❌ |
| search_model_service.proto | 20.0% | ❌ | ❌ | ❌ | ❌ |

### 4.2 既存パターンの評価

#### ✅ 良い点（AIP準拠）
- 全ファイルでlicense headerを配置
- `//` のみ使用（`/* */`不使用）
- 主要なmessage/fieldにleading comment
- enumの0値に_UNSPECIFIED接尾辞
- パッケージ名がlower_snake_case + version suffix

#### ⚠️ AIP-192との不一致点
1. **`// Fields:` セクションの使用**: AIP-192では推奨されない（ツールが認識しない可能性）
2. **`// Example:` にコードブロック（```）の使用**: AIP-192では禁止（見出しや複雑なMarkdownフォーマットはツール互換性の問題）
3. **`// Notes:` セクション**: 構造化セクションはAIPにない慣習
4. **ai/v1/ パッケージのコメント率が低い**: コメントの品質にばらつき
5. **コメントの文体**: 一部のファイルで「A ...」形式（冠詞付き）が使用されている → AIP-192では主語省略が推奨

---

## 5. チェックリスト（実践用）

### 各要素のコメント要件

#### ファイル（File）
- [ ] License header（Apache 2.0など）
- [ ] ファイル概要のコメント（1-3文、ファイルの内容と目的）

#### サービス（Service）
- [ ] Leading comment（サービスの目的と機能）
- [ ] 大文字開始、ピリオド終了
- [ ] ユーザーがこのサービスで何ができるかを説明

#### RPC（Method）
- [ ] Leading comment（主語省略の三人称現在形）
- [ ] 例: `// Creates a new workflow for the given project.`
- [ ] 冪等性の記載（該当場合）
- [ ] 成功/失敗時の動作

#### メッセージ（Message）
- [ ] Leading comment（メッセージの内容と用途）
- [ ] 簡潔かつ完全な説明
- [ ] 条件付きフィールドの記載（"Present only when..."）

#### フィールド（Field）
- [ ] Leading comment（必須、全フィールド）
- [ ] 単位を明記（該当場合）
- [ ] 値の範囲を明記（該当場合）
- [ ] デフォルト値を明記（該当場合）
- [ ] フィールド名を`code font`で囲む

#### 列挙型（Enum）
- [ ] Leading comment（enumの目的）
- [ ] 全enum valueにleading comment
- [ ] 0値: ```// Default value. Do not use.```

#### 非推奨（Deprecated）
- [ ] `option deprecated = true;` を設定
- [ ] 最初の行: `// Deprecated: <reason or alternative>`

### 全般的な禁止事項
- [ ] ❌ `/* */` ブロックコメント（`//` のみ使用）
- [ ] ❌ Trailing comments（leading commentsのみ）
- [ ] ❌ 見出し（`#`）やテーブル
- [ ] ❌ 生HTML
- [ ] ❌ ASCII Art
- [ ] ❌ 相対URL（絶対`https` URLのみ）

---

## 6. 推奨buf.yaml設定

```yaml
version: v2
lint:
  use:
    - STANDARD
    - COMMENTS
  except:
    # 必要に応じて例外を追加
    # - COMMENT_ENUM_VALUE
```

`buf lint`をCIに導入することで、コメントの**有無**を自動検査可能。
コメントの**品質**（文体、内容の完全性）は手動レビューで確認。

---

## Sources

- [AIP-192: Documentation](https://google.aip.dev/192) — Google APIにおけるドキュメント規約の主要ソース
- [AIP-130: Methods](https://google.aip.dev/130) — メソッドカテゴリのガイダンス
- [Protocol Buffers Style Guide](https://protobuf.dev/programming-guides/style/) — 公式スタイルガイド
- [Protocol Buffers Language Guide (proto3)](https://protobuf.dev/programming-guides/proto3/) — コメントの3種類（leading/trailing/detached）
- [Buf Style Guide](https://buf.build/docs/best-practices/style-guide/) — buf推奨の規約
- [Buf Lint Rules - COMMENTS](https://buf.build/docs/lint/rules/#comments) — COMMENTSカテゴリのlintルール定義
- [Buf Lint Rules (Full)](https://buf.build/docs/lint/rules/) — 全lintルール一覧

---

_調査日: 2025-06-24_
_対象バージョン: AIP-192 (2024-10-29 updated), buf v2, proto3_
