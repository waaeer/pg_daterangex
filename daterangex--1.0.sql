CREATE TYPE daterangex;

CREATE FUNCTION date_minus(date1 date, date2 date) RETURNS float AS $$
    SELECT cast(date1 - date2 AS float);
$$ LANGUAGE sql IMMUTABLE;

CREATE FUNCTION daterangex_canonical(dr daterangex) RETURNS daterangex AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE TYPE daterangex AS RANGE (
    SUBTYPE = date,
    SUBTYPE_DIFF = date_minus,
    CANONICAL = daterangex_canonical    
);

CREATE CAST (daterange AS daterangex) WITH INOUT AS IMPLICIT;
CREATE CAST (daterangex AS daterange) WITH INOUT AS IMPLICIT;

