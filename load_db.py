import sqlite3, pandas as pd
con = sqlite3.connect("btc.db")
for table, f in [("predictions", "predictions.csv"), ("outcomes", "outcomes.csv")]:
    df = pd.read_csv(f)
    df.to_sql(table, con, if_exists="replace", index=False)
    print(table, len(df), list(df.columns))
con.close()