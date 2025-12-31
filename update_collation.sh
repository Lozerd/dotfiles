#!/usr/bin/env bash
set -euo pipefail

# Default connection params (can be overridden via env)
export PGUSER="${PGUSER:=postgres}"
export PGDATABASE="${PGDATABASE:=postgres}"
export PGHOST="${PGHOST:=127.0.0.1}"

read -p 'Enter Postgres password: ' -s PGPASSWORD
export PGPASSWORD

# Base psql command
PSQL="psql -At"

# Get list of databases (excluding templates)
databases=$(psql -At -d "$PGDATABASE" -c "SELECT datname FROM pg_database WHERE datistemplate = false;")

for db in $databases; do
    echo "🔄 Refreshing collation for database: $db"
    $PSQL -d "$db" -c "ALTER DATABASE \"$db\" REFRESH COLLATION VERSION;" || true
done

echo "✨ Done refreshing collations!"

