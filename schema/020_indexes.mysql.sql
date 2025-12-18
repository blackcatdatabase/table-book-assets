-- Auto-generated from schema-map-mysql.yaml (map@sha1:0D716345C0228A9FD8972A3D31574000D05317DB)
-- engine: mysql
-- table:  book_assets

CREATE INDEX idx_book_assets_tenant ON book_assets (tenant_id);

CREATE UNIQUE INDEX ux_book_assets_tenant_unique ON book_assets (tenant_id, book_id, asset_type);

CREATE UNIQUE INDEX ux_book_assets_tenant_id ON book_assets (tenant_id, id);
