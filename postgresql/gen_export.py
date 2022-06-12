from datetime import datetime, timedelta
from pathlib import Path

current_dir = Path.cwd()
base_dir = current_dir / 'staging'

host = 'localhost'
port = '5432'
export_user = 'postgres'
export_db = 'pagila'
export_schema = 'public'

# Batch tables

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
    'staff',
    'store'
]

# Event tables

event_tables = [
    ('rental', 'rental_date'),
    ('payment', 'payment_date')
]

start_date = datetime.strptime("2022-01-01", "%Y-%m-%d")
end_date = datetime.strptime("2022-04-02", "%Y-%m-%d")
date_range = [start_date + timedelta(days=x) for x in range(0, (end_date-start_date).days)]

export_sql = open("export.sql", "w")

export_sh = open("export.sh", "w")
export_sh.write('#!/bin/bash\n')

# Export batch tables 

output_dir = base_dir / 'batch'
output_dir.mkdir(exist_ok = True)

for table in batch_tables:
    export_command = f"\copy {export_schema}.{table} TO '{output_dir}/{table}.csv' with csv header;"
    export_sql.write(f'-- {export_schema}.{table}\n')
    export_sql.write(export_command + '\n')

# Export event tables

for d in date_range:

    date_str = datetime.strftime(d, '%Y%m%d')
    output_dir = base_dir / 'events'
    output_dir.mkdir(exist_ok = True)

    export_sql.write(f'-- {date_str}\n')

    for table, column in event_tables:
        export_command = f"\copy (select * from {export_schema}.{table} where to_char({column}, 'YYYYMMDD') = '{date_str}')"
        export_command += f" TO '{output_dir}/{table}_{date_str}.csv' with csv header;"
        export_sql.write(f'-- {export_schema}.{table}_{date_str}\n')
        export_sql.write(export_command + '\n')

    export_sql.write(f'\n')

export_sh.write(f'mkdir -p {base_dir}/batch\n')
export_sh.write(f'mkdir -p {base_dir}/events\n')
export_sh.write(f'psql -h {host} -p {port} -U {export_user} -d {export_db} -f export.sql\n')

export_sql.close()
export_sh.close()

