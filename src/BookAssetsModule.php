<?php
declare(strict_types=1);

namespace BlackCat\Database\Packages\BookAssets;

use BlackCat\Database\SqlDialect;
use BlackCat\Database\Contracts\ModuleInterface;
use BlackCat\Database\Support\SqlIdentifier;
use BlackCat\Database\Support\SqlDirectoryRunner;
use BlackCat\Database\Support\SchemaIntrospector;
use BlackCat\Core\Database as Database;

final class BookAssetsModule implements ModuleInterface
{
    public function name(): string { return 'table-book_assets'; }
    public function table(): string { return 'book_assets'; }
    public function version(): string { return '1.0.0'; }

    /** @return string[] */
    public function dialects(): array { return [ 'mysql', 'postgres' ]; }
    /** @return string[] */
    public function dependencies(): array { return [ 'table-books', 'table-crypto_keys', 'table-tenants' ]; }

    public static function contractView(): string { return 'vw_book_assets'; }

    public function install(Database $db, SqlDialect $d): void
    {
        // 1) Run schema files from ../schema for the dialect (NNN_*.sql order respected)
        SqlDirectoryRunner::run($db, $d, __DIR__ . '/../schema');

        // 2) Contract view = SELECT * FROM <table>
        $table = SqlIdentifier::qi($db, $this->table());
        $view  = SqlIdentifier::qi($db, self::contractView());

        if ($d->isMysql()) {
            $createViewSql = <<<'SQL'
CREATE OR REPLACE ALGORITHM=MERGE SQL SECURITY INVOKER VIEW vw_book_assets AS
SELECT
  tenant_id,
  id,
  book_id,
  asset_type,
  filename,
  mime_type,
  size_bytes,
  storage_path,
  content_hash,
  download_filename,
  is_encrypted,
  encryption_algo,
  encryption_meta,
  key_version,
  key_id,
  created_at,
  CAST(LPAD(HEX(encryption_key_enc), 64, '0') AS CHAR(64)) AS encryption_key_enc_hex,
  CAST(LPAD(HEX(encryption_iv),      32, '0') AS CHAR(32)) AS encryption_iv_hex,
  CAST(LPAD(HEX(encryption_tag),     32, '0') AS CHAR(32)) AS encryption_tag_hex,
  CAST(LPAD(HEX(encryption_aad),     64, '0') AS CHAR(64)) AS encryption_aad_hex
FROM book_assets;
SQL;
        } else {
            $createViewSql = <<<'SQL'
CREATE OR REPLACE VIEW vw_book_assets AS
SELECT
  id,
  tenant_id,
  book_id,
  asset_type,
  filename,
  mime_type,
  size_bytes,
  storage_path,
  content_hash,
  download_filename,
  is_encrypted,
  encryption_algo,
  encryption_meta,
  key_version,
  key_id,
  created_at,
  UPPER(encode(encryption_key_enc,'hex'))   AS encryption_key_enc_hex,
  UPPER(encode(encryption_iv,'hex'))        AS encryption_iv_hex,
  UPPER(encode(encryption_tag,'hex'))       AS encryption_tag_hex,
  UPPER(encode(encryption_aad,'hex'))       AS encryption_aad_hex
FROM book_assets;
SQL;
        }

        if (\class_exists('\\BlackCat\\Database\\Support\\DdlGuard')) {
            (new \BlackCat\Database\Support\DdlGuard($db, $d))->applyCreateView($createViewSql);
        } else {
            // Prefer CREATE OR REPLACE VIEW (gentle on dependencies)
            $db->exec($createViewSql);
        }

    }

    public function upgrade(Database $db, SqlDialect $d, string $from): void
    {
        // Optional: generator may place module-specific upgrade steps here (e.g., data migrations).
    }

    /** Does not drop the table, only the contract (view). */
    public function uninstall(Database $db, SqlDialect $d): void
    {
        $qiV = SqlIdentifier::qi($db, self::contractView());
        try {
            $db->exec("DROP VIEW IF EXISTS {$qiV}" . ($d->isMysql() ? "" : " CASCADE"));
        } catch (\Throwable) {
            // swallow
        }
    }

    public function status(Database $db, SqlDialect $d): array
    {
        $table = $this->table();
        $view  = self::contractView();

        $hasTable = SchemaIntrospector::hasTable($db, $d, $table);
        $hasView  = SchemaIntrospector::hasView($db, $d, $view);

        // Quick index/FK check – generator injects names (case-sensitive per DB)
        $expectedIdx = [ 'idx_book_assets_tenant', 'ux_book_assets_tenant_id', 'ux_book_assets_tenant_unique' ];
        if ($d->isMysql()) {
            // Drop PG-only index naming patterns (e.g., GIN/GiST)
            $expectedIdx = array_values(array_filter(
                $expectedIdx,
                static fn(string $n): bool => !str_starts_with($n, 'gin_') && !str_starts_with($n, 'gist_')
            ));
        }
        $expectedFk  = [ 'fk_book_assets_book', 'fk_book_assets_key', 'fk_book_assets_tenant' ];

        $haveIdx = $hasTable ? SchemaIntrospector::listIndexes($db, $d, $table)     : [];
        $haveFk  = $hasTable ? SchemaIntrospector::listForeignKeys($db, $d, $table) : [];

        $missingIdx = array_values(array_diff($expectedIdx, $haveIdx));
        $missingFk  = array_values(array_diff($expectedFk, $haveFk));

        return [
            'table'       => $hasTable,
            'view'        => $hasView,
            'missing_idx' => $missingIdx,
            'missing_fk'  => $missingFk,
            'version'     => $this->version(),
        ];
    }

    public function info(): array
    {
        return [
            'table'       => $this->table(),
            'view'        => self::contractView(),
            'columns'     => Definitions::columns(),
            'version'     => $this->version(),
            'dialects'    => [ 'mysql', 'postgres' ],
            'indexes'     => [ 'idx_book_assets_tenant', 'ux_book_assets_tenant_id', 'ux_book_assets_tenant_unique' ],
            'foreignKeys' => [ 'fk_book_assets_book', 'fk_book_assets_key', 'fk_book_assets_tenant' ],
        ];
    }
}
