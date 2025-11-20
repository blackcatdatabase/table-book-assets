<!-- Auto-generated from schema-map-postgres.psd1 @ 62c9c93 (2025-11-20T21:38:11+01:00) -->
# Definition – book_assets

Binary and ancillary assets for books (covers, files, extras). UNIQUE (book_id, asset_type) — max. one asset of a given type per book.

## Columns
| Column | Type | Null | Default | Description | Notes |
|-------:|:-----|:----:|:--------|:------------|:------|
| id | BIGINT | — | AS | Surrogate primary key. |  |
| tenant_id | BIGINT | NO | — |  |  |
| book_id | BIGINT | NO | — | Book (FK books.id). |  |
| asset_type | TEXT | NO | — | Kind of asset. | enum: cover, pdf, epub, mobi, sample, extra |
| filename | VARCHAR(255) | NO | — | Original file name. |  |
| mime_type | VARCHAR(100) | NO | — | MIME type. |  |
| size_bytes | BIGINT | NO | — | File size in bytes. |  |
| storage_path | TEXT | YES | — | Backend storage path or URI. |  |
| content_hash | VARCHAR(64) | YES | — | Optional file content hash (hex). |  |
| download_filename | VARCHAR(255) | YES | — | Suggested download file name. |  |
| is_encrypted | BOOLEAN | NO | FALSE | Whether asset is encrypted at rest. |  |
| encryption_algo | VARCHAR(50) | YES | — | Algorithm identifier (e.g., AES-256-GCM). |  |
| encryption_key_enc | BYTEA | YES | — | Wrapped DEK or encrypted key blob. | PII: encrypted |
| encryption_iv | BYTEA | YES | — | IV/nonce used for encryption. |  |
| encryption_tag | BYTEA | YES | — | Auth tag for AEAD ciphers. |  |
| encryption_aad | BYTEA | YES | — | Associated data for AEAD ciphers. |  |
| encryption_meta | JSONB | YES | — | JSON metadata about encryption layers. |  |
| key_version | VARCHAR(64) | YES | — | Local key version reference. |  |
| key_id | BIGINT | YES | — | Optional link to crypto_keys.id. |  |
| created_at | TIMESTAMPTZ(6) | NO | CURRENT_TIMESTAMP(6) | Creation timestamp (UTC). |  |