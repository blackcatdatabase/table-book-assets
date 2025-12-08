# book_assets

Binary and ancillary assets for books (covers, files, extras). UNIQUE (book_id, asset_type) â€” max. one asset of a given type per book.

## Columns
| Column | Type | Null | Default | Description |
| --- | --- | --- | --- | --- |
| asset_type | ENUM('cover','pdf','epub','mobi','sample','extra') | NO |  | Kind of asset. (enum: cover, pdf, epub, mobi, sample, extra) |
| book_id | BIGINT | NO |  | Book (FK books.id). |
| content_hash | VARCHAR(64) | YES |  | Optional file content hash (hex). |
| created_at | DATETIME(6) | NO | CURRENT_TIMESTAMP(6) | Creation timestamp (UTC). |
| download_filename | VARCHAR(255) | YES |  | Suggested download file name. |
| encryption_aad | VARBINARY(255) | YES |  | Associated data for AEAD ciphers. |
| encryption_algo | VARCHAR(50) | YES |  | Algorithm identifier (e.g., AES-256-GCM). |
| encryption_iv | VARBINARY(32) | YES |  | IV/nonce used for encryption. |
| encryption_key_enc | BLOB | YES |  | Wrapped DEK or encrypted key blob. |
| encryption_meta | JSON | YES |  | JSON metadata about encryption layers. |
| encryption_tag | VARBINARY(32) | YES |  | Auth tag for AEAD ciphers. |
| filename | VARCHAR(255) | NO |  | Original file name. |
| id | BIGINT | NO |  | Surrogate primary key. |
| is_encrypted | BOOLEAN | NO | 0 | Whether asset is encrypted at rest. |
| key_id | BIGINT | YES |  | Optional link to crypto_keys.id. |
| key_version | VARCHAR(64) | YES |  | Local key version reference. |
| mime_type | VARCHAR(100) | NO |  | MIME type. |
| size_bytes | BIGINT | NO |  | File size in bytes. |
| storage_path | TEXT | YES |  | Backend storage path or URI. |

## Engine Details

### mysql

Unique keys:
| Name | Columns |
| --- | --- |
| ux_book_assets_tenant_id | tenant_id, id |
| ux_book_assets_tenant_unique | tenant_id, book_id, asset_type |

Indexes:
| Name | Columns | SQL |
| --- | --- | --- |
| idx_book_assets_book | book_id | INDEX idx_book_assets_book (book_id) |
| idx_book_assets_tenant | tenant_id | CREATE INDEX idx_book_assets_tenant ON book_assets (tenant_id) |
| idx_book_assets_type | asset_type | INDEX idx_book_assets_type (asset_type) |
| ux_book_assets_tenant_id | tenant_id,id | CREATE UNIQUE INDEX ux_book_assets_tenant_id ON book_assets (tenant_id, id) |
| ux_book_assets_tenant_unique | tenant_id,book_id,asset_type | CREATE UNIQUE INDEX ux_book_assets_tenant_unique ON book_assets (tenant_id, book_id, asset_type) |

Foreign keys:
| Name | Columns | References | Actions |
| --- | --- | --- | --- |
| fk_book_assets_book | tenant_id,book_id | books(tenant_id,id) | ON DELETE CASCADE |
| fk_book_assets_key | key_id | crypto_keys(id) | ON DELETE SET |
| fk_book_assets_tenant | tenant_id | tenants(id) | ON DELETE RESTRICT |

### postgres

Unique keys:
| Name | Columns |
| --- | --- |
| ux_book_assets_tenant_id | tenant_id, id |
| ux_book_assets_tenant_unique | tenant_id, book_id, asset_type |

Indexes:
| Name | Columns | SQL |
| --- | --- | --- |
| gin_book_assets_enc_meta | encryption_metajsonb_path_ops | CREATE INDEX IF NOT EXISTS gin_book_assets_enc_meta ON book_assets USING GIN (encryption_meta jsonb_path_ops) |
| idx_book_assets_book | book_id | CREATE INDEX IF NOT EXISTS idx_book_assets_book ON book_assets (book_id) |
| idx_book_assets_tenant | tenant_id | CREATE INDEX IF NOT EXISTS idx_book_assets_tenant ON book_assets (tenant_id) |
| idx_book_assets_type | asset_type | CREATE INDEX IF NOT EXISTS idx_book_assets_type ON book_assets (asset_type) |
| ux_book_assets_tenant_id | tenant_id,id | CREATE UNIQUE INDEX IF NOT EXISTS ux_book_assets_tenant_id ON book_assets (tenant_id, id) |
| ux_book_assets_tenant_unique | tenant_id,book_id,asset_type | CREATE UNIQUE INDEX IF NOT EXISTS ux_book_assets_tenant_unique ON book_assets (tenant_id, book_id, asset_type) |

Foreign keys:
| Name | Columns | References | Actions |
| --- | --- | --- | --- |
| fk_book_assets_book | tenant_id,book_id | books(tenant_id,id) | ON DELETE CASCADE |
| fk_book_assets_key | key_id | crypto_keys(id) | ON DELETE SET |
| fk_book_assets_tenant | tenant_id | tenants(id) | ON DELETE RESTRICT |

## Engine differences

## Views
| View | Engine | Flags | File |
| --- | --- | --- | --- |
| vw_book_assets | mysql | algorithm=MERGE, security=INVOKER | [schema\040_views.mysql.sql](schema\040_views.mysql.sql) |
| vw_book_assets_encryption_coverage | mysql | algorithm=TEMPTABLE, security=INVOKER | [schema\040_views_joins.mysql.sql](schema\040_views_joins.mysql.sql) |
| vw_book_assets | postgres |  | [schema\040_views.postgres.sql](schema\040_views.postgres.sql) |
| vw_book_assets_encryption_coverage | postgres |  | [schema\040_views_joins.postgres.sql](schema\040_views_joins.postgres.sql) |
