import sqlite3, pandas as pd
con = sqlite3.connect("btc.db")
for block in open("queries.sql").read().split("-- name:")[1:]:
    name, _, sql = block.partition("\n")
    name = name.strip()
    df = pd.read_sql(sql, con)
    print("\n==", name)
    print(df.head(15).to_string(index=False))
    df.to_csv(f"result_{name}.csv", index=False)