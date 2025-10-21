<!-- Auto-generated from schema-map.psd1 @ 1e83bb6 (2025-10-21T10:18:36+02:00) -->
# Definition – book_assets

Binary and ancillary assets for books (covers, files, extras).

## Columns
| Column | Type | Null | Default | Description | Notes |
|-------:|:-----|:----:|:--------|:------------|:------|
| id | BIGINT UNSIGNED | — | — | Surrogate primary key. |  |
| book_id | BIGINT UNSIGNED | NO | — | Book (FK books.id). |  |
| asset_type | ENUM('cover','pdf','epub','mobi','sample','extra') | NO | — | Kind of asset. | enum: cover, pdf, epub, mobi, sample, extra |
| filename | VARCHAR(255) | NO | — | Original file name. |  |
| mime_type | VARCHAR(100) | NO | — | MIME type. |  |
| size_bytes | BIGINT | NO | — | File size in bytes. |  |
| storage_path | TEXT | YES | — | Backend storage path or URI. |  |
| content_hash | VARCHAR(64) | YES | — | Optional file content hash (hex). |  |
| download_filename | VARCHAR(255) | YES | — | Suggested download file name. |  |
| is_encrypted | BOOLEAN | NO | 0 | Whether asset is encrypted at rest. |  |
| encryption_algo | VARCHAR(50) | YES | — | Algorithm identifier (e.g., AES-256-GCM). |  |
| encryption_key_enc | BLOB | YES | — | Wrapped DEK or encrypted key blob. | PII: encrypted |
| encryption_iv | VARBINARY(32) | YES | — | IV/nonce used for encryption. |  |
| encryption_tag | VARBINARY(32) | YES | — | Auth tag for AEAD ciphers. |  |
| encryption_aad | VARBINARY(255) | YES | — | Associated data for AEAD ciphers. |  |
| encryption_meta | JSON | YES | — | JSON metadata about encryption layers. |  |
| key_version | VARCHAR(64) | YES | — | Local key version reference. |  |
| key_id | BIGINT UNSIGNED | YES | — | Optional link to crypto_keys.id. |  |
| created_at | DATETIME(6) | NO | CURRENT_TIMESTAMP(6) | Creation timestamp (UTC). |  |
