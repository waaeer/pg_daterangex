CREATE EXTENSION daterangex;
SELECT daterangex('2024-01-01' , '2024-06-01', '[]');
SELECT daterangex('2024-01-01' , '2024-06-01', '[)');
SELECT '[2025-01-01,2025-02-02]'::daterange::daterangex;
SELECT '[2025-01-01,2025-02-02)'::daterange::daterangex;
SELECT '[2025-01-01,2025-02-02]'::daterangex::daterange;
SELECT '[2025-01-01,2025-02-02)'::daterangex::daterange;

CREATE TABLE x (y daterangex);
INSERT INTO x SELECT daterangex(d::date, (d + '1month'::interval)::date, '[]') FROM generate_series('2015-01-01'::date,'2025-02-02', '1day') d;
INSERT INTO x SELECT daterangex(d::date, NULL::date, '[)') FROM generate_series('2015-01-01'::date,'2025-02-02', '1day') d;
SELECT COUNT(*) FROM x;
CREATE INDEX ON x USING gist (y);
INSERT INTO x SELECT '[2024-01-01,)'::daterange::daterangex;



