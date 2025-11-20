# 📦 Book Assets

![SQL](https://img.shields.io/badge/SQL-MySQL%208.0%2B-4479A1?logo=mysql&logoColor=white) ![License](https://img.shields.io/badge/license-BlackCat%20Proprietary-red) ![Status](https://img.shields.io/badge/status-stable-informational) ![Generated](https://img.shields.io/badge/generated-from%20schema--map-blue)

<!-- Auto-generated from schema-map-postgres.psd1 @ 62c9c93 (2025-11-20T21:38:11+01:00) -->

> Schema package for table **book_assets** (repo: `book-assets`).

## Files
```
schema/
  001_table.sql
  020_indexes.sql
  030_foreign_keys.sql
```

## Quick apply
```bash
# Apply schema (Linux/macOS):
mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" < schema/001_table.sql
mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" < schema/020_indexes.sql
mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" < schema/030_foreign_keys.sql
```

```powershell
# Apply schema (Windows PowerShell):
mysql -h $env:DB_HOST -u $env:DB_USER -p$env:DB_PASS $env:DB_NAME < schema/001_table.sql
mysql -h $env:DB_HOST -u $env:DB_USER -p$env:DB_PASS $env:DB_NAME < schema/020_indexes.sql
mysql -h $env:DB_HOST -u $env:DB_USER -p$env:DB_PASS $env:DB_NAME < schema/030_foreign_keys.sql
```

## Docker quickstart
```bash
# Spin up a throwaway MySQL and apply just this package:
docker run --rm -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=app -p 3307:3306 -d mysql:8
sleep 15
mysql -h 127.0.0.1 -P 3307 -u root -proot app < schema/001_table.sql
mysql -h 127.0.0.1 -P 3307 -u root -proot app < schema/020_indexes.sql
mysql -h 127.0.0.1 -P 3307 -u root -proot app < schema/030_foreign_keys.sql
```

## Columns
| Column | Type | Null | Default | Extra |
|-------:|:-----|:----:|:--------|:------|
| id | BIGINT | — | AS | PK |
| tenant_id | BIGINT | NO | — |  |
| book_id | BIGINT | NO | — |  |
| asset_type | TEXT | NO | — |  |
| filename | VARCHAR(255) | NO | — |  |
| mime_type | VARCHAR(100) | NO | — |  |
| size_bytes | BIGINT | NO | — |  |
| storage_path | TEXT | YES | — |  |
| content_hash | VARCHAR(64) | YES | — |  |
| download_filename | VARCHAR(255) | YES | — |  |
| is_encrypted | BOOLEAN | NO | FALSE |  |
| encryption_algo | VARCHAR(50) | YES | — |  |
| encryption_key_enc | BYTEA | YES | — |  |
| encryption_iv | BYTEA | YES | — |  |
| encryption_tag | BYTEA | YES | — |  |
| encryption_aad | BYTEA | YES | — |  |
| encryption_meta | JSONB | YES | — |  |
| key_version | VARCHAR(64) | YES | — |  |
| key_id | BIGINT | YES | — |  |
| created_at | TIMESTAMPTZ(6) | NO | CURRENT_TIMESTAMP(6) |  |

## Relationships
- FK → **books** via (tenant_id,book_id) (ON DELETE CASCADE).
- FK → **crypto_keys** via (key_id) (ON DELETE SET NULL).
- FK → **tenants** via (tenant_id) (ON DELETE RESTRICT).

```mermaid
erDiagram
  BOOK_ASSETS {
    INT id PK
    INT tenant_id
    INT book_id
    VARCHAR asset_type
    VARCHAR filename
    VARCHAR mime_type
    INT size_bytes
    VARCHAR storage_path
    VARCHAR content_hash
    VARCHAR download_filename
    BOOLEAN is_encrypted
    VARCHAR encryption_algo
    BYTEA encryption_key_enc
    BYTEA encryption_iv
    BYTEA encryption_tag
    BYTEA encryption_aad
    JSONB encryption_meta
    VARCHAR key_version
    INT key_id
    TIMESTAMPTZ created_at
  }
  BOOK_ASSETS }o--|| BOOKS : "tenant_id, book_id"
  BOOK_ASSETS }o--|| CRYPTO_KEYS : "key_id"
  BOOK_ASSETS }o--|| TENANTS : "tenant_id"
```

## Indexes
- 6 deferred index statement(s) in schema/020_indexes.sql.

## Notes
- Generated from the umbrella repository **blackcat-database** using `scripts/schema-map.psd1`.
- To change the schema, update the map and re-run the generators.

## License
Distributed under the **BlackCat Store Proprietary License v1.0**. See `LICENSE`.
