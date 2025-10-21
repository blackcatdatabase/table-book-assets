# 📦 Book Assets

![SQL](https://img.shields.io/badge/SQL-MySQL%208.0%2B-4479A1?logo=mysql&logoColor=white) ![License](https://img.shields.io/badge/license-BlackCat%20Proprietary-red) ![Status](https://img.shields.io/badge/status-stable-informational) ![Generated](https://img.shields.io/badge/generated-from%20schema--map-blue)

> Schema package for table **book_assets** (repo: $slug).

## Files
```
schema/
  001_table.sql
  # (no deferred indexes declared in map)
  030_foreign_keys.sql
```

## Quick apply
```bash
# Apply schema (Linux/macOS):
mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" < schema/001_table.sql
mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" < schema/030_foreign_keys.sql
```

```powershell
# Apply schema (Windows PowerShell):
mysql -h $env:DB_HOST -u $env:DB_USER -p$env:DB_PASS $env:DB_NAME < schema/001_table.sql
mysql -h $env:DB_HOST -u $env:DB_USER -p$env:DB_PASS $env:DB_NAME < schema/030_foreign_keys.sql
```

## Docker quickstart
```bash
# Spin up a throwaway MySQL and apply just this package:
docker run --rm -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=app -p 3307:3306 -d mysql:8
sleep 15
mysql -h 127.0.0.1 -P 3307 -u root -proot app < schema/001_table.sql
mysql -h 127.0.0.1 -P 3307 -u root -proot app < schema/030_foreign_keys.sql
```

## Columns
| Column | Type | Null | Default | Extra |
|-------:|:-----|:----:|:--------|:------|
| id | BIGINT UNSIGNED | — | — | AUTO_INCREMENT, PK |
| book_id | BIGINT UNSIGNED | NO | — |  |
| asset_type | ENUM(''cover'',''pdf'',''epub'',''mobi'',''sample'',''extra'') | NO | — |  |
| filename | VARCHAR(255) | NO | — |  |
| mime_type | VARCHAR(100) | NO | — |  |
| size_bytes | BIGINT | NO | — |  |
| storage_path | TEXT | YES | — |  |
| content_hash | VARCHAR(64) | YES | — |  |
| download_filename | VARCHAR(255) | YES | — |  |
| is_encrypted | BOOLEAN | NO | 0 |  |
| encryption_algo | VARCHAR(50) | YES | — |  |
| encryption_key_enc | BLOB | YES | — |  |
| encryption_iv | VARBINARY(32) | YES | — |  |
| encryption_tag | VARBINARY(32) | YES | — |  |
| encryption_aad | VARBINARY(255) | YES | — |  |
| encryption_meta | JSON | YES | — |  |
| key_version | VARCHAR(64) | YES | — |  |
| key_id | BIGINT UNSIGNED | YES | — |  |
| created_at | DATETIME(6) | NO | CURRENT_TIMESTAMP(6) |  |

## Relationships
- FK → **books** via (book_id) (ON DELETE CASCADE).
- FK → **crypto_keys** via (key_id) (ON DELETE SET NULL).

```mermaid
erDiagram
  BOOK_ASSETS {
    BIGINT id PK
    BIGINT book_id
    ENUM(''cover'',''pdf'',''epub'',''mobi'',''sample'',''extra'') asset_type
    VARCHAR(255) filename
    VARCHAR(100) mime_type
    BIGINT size_bytes
    TEXT storage_path
    VARCHAR(64) content_hash
    VARCHAR(255) download_filename
    BOOLEAN is_encrypted
    VARCHAR(50) encryption_algo
    BLOB encryption_key_enc
    VARBINARY(32) encryption_iv
    VARBINARY(32) encryption_tag
    VARBINARY(255) encryption_aad
    JSON encryption_meta
    VARCHAR(64) key_version
    BIGINT key_id
    DATETIME(6) created_at
  }
  BOOK_ASSETS }o--|| BOOKS : (book_id)
  BOOK_ASSETS }o--|| CRYPTO_KEYS : (key_id)
```

## Indexes
- No deferred indexes declared for this table.

## Notes
- Generated from the umbrella repository **blackcat-database** using `scripts/schema-map.psd1`.
- To change the schema, update the map and re-run the generators.

## License
Distributed under the **BlackCat Store Proprietary License v1.0**. See `LICENSE`.

