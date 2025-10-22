<?php
declare(strict_types=1);

namespace BlackCat\Database\Packages\BookAssets;

final class Definitions {
    // --- základní metadata ---
    public static function table(): string { return 'book_assets'; }
    public static function contractView(): string { return 'v_book_assets_contract'; }
    /** @return string[] */
    public static function columns(): array { return [ 'id', 'book_id', 'asset_type', 'filename', 'mime_type', 'size_bytes', 'storage_path', 'content_hash', 'download_filename', 'is_encrypted', 'encryption_algo', 'encryption_key_enc', 'encryption_iv', 'encryption_tag', 'encryption_aad', 'encryption_meta', 'key_version', 'key_id', 'created_at' ]; }
    public static function pk(): string { return 'id'; }

    // --- volitelná metadata (mohou být prázdná) ---
    public static function softDeleteColumn(): ?string {
        $c = ''; return $c !== '' ? $c : null;
    }
    public static function updatedAtColumn(): ?string {
        $c = ''; return $c !== '' ? $c : null;
    }
    public static function versionColumn(): ?string {
        $c = ''; return $c !== '' ? $c : null; // pro optimistic locking
    }
    /** např. "created_at DESC, id DESC" */
    public static function defaultOrder(): ?string {
        $c = 'created_at DESC, id DESC'; return $c !== '' ? $c : null;
    }
    /** @return array<int,array<int,string>> seznam unikátních klíčů (sloupcových kombinací) */
    public static function uniqueKeys(): array { return []; }
    /** @return string[] JSON sloupce kvůli castům/operacím */
    public static function jsonColumns(): array { return [ 'encryption_meta' ]; }

    // --- pomocníci ---
    public static function hasColumn(string $col): bool {
        static $set = null;
        if ($set === null) { $set = array_fill_keys(self::columns(), true); }
        return isset($set[$col]);
    }
}
