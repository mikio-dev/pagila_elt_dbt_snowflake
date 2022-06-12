from datetime import datetime, timedelta
from pathlib import Path

current_dir = Path.cwd()
output_dir = current_dir / 'ddl'

host = 'localhost'
port = '5432'
user = 'postgres'
dbname = 'pagila'

# tables
batch_tables = [
    'actor',
    'address',
    'category',
    'city',
    'country',
    'customer',
    'film',
    'film_actor',
    'film_category',
    'inventory',
    'language',
    'rental',
    'staff',
    'store',
]

event_tables = [
    'rental',
    'payment',
]

export_ddl = open('export_ddl.sh', 'w')
export_ddl.write('#!/bin/bash\n')
export_ddl.write(f'mkdir -p {output_dir}\n')

for table in batch_tables:
    export_command = f'pg_dump -h {host} -p {port} -U {user} -w -d {dbname} -t public.{table} -f {output_dir}/{table}.sql --schema-only\n'
    export_ddl.write(export_command + '\n')

export_ddl.close()

