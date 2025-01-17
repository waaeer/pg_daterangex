# pg_daterangex
PostgreSQL extension defining a daterange type with inclusive upper limit

The daterange type is by default output with non-exclusive upper range. This extension is the same but with inclusive upper range.
See example: 

```
CREATE EXTENSION daterangex;
SELECT daterange('[2024-01-01,2024-06-01]');
        daterange        
-------------------------
 [2024-01-01,2024-06-02)

SELECT daterangex('[2024-01-01,2024-06-01]');
       daterangex        
-------------------------
 [2024-01-01,2024-06-01]
```

## Building

```
USE_PGXS=1 PG_CONFIG=/path_to_pgconfig make install
```
