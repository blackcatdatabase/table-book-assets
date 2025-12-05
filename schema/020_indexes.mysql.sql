-- Auto-generated from schema-map-mysql.yaml (map@sha1:5E62933580349BE7C623D119AC9D1301A62F03EF)
-- engine: mysql
-- table:  book_assets

CREATE INDEX idx_book_assets_tenant ON book_assets (tenant_id);

CREATE UNIQUE INDEX ux_book_assets_tenant_unique ON book_assets (tenant_id, book_id, asset_type);

CREATE UNIQUE INDEX ux_book_assets_tenant_id ON book_assets (tenant_id, id);
