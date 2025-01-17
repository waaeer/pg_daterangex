CREATE EXTENSION daterangex;
SELECT daterangex('2024-01-01' , '2024-06-01', '[]');
SELECT daterangex('2024-01-01' , '2024-06-01', '[)');
SELECT '[2025-01-01,2025-02-02]'::daterange::daterangex;
SELECT '[2025-01-01,2025-02-02)'::daterange::daterangex;
SELECT '[2025-01-01,2025-02-02]'::daterangex::daterange;
SELECT '[2025-01-01,2025-02-02)'::daterangex::daterange;

