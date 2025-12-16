-- Auto-generated from schema-map-mysql.yaml (map@sha1:B9D3BE28A74392B9B389FDAFB493BD80FA1F6FA4)
-- engine: mysql
-- table:  book_assets

CREATE INDEX idx_book_assets_tenant ON book_assets (tenant_id);

CREATE UNIQUE INDEX ux_book_assets_tenant_unique ON book_assets (tenant_id, book_id, asset_type);

CREATE UNIQUE INDEX ux_book_assets_tenant_id ON book_assets (tenant_id, id);
