CREATE TYPE daterangex;

CREATE FUNCTION date_minus(date1 date, date2 date) RETURNS float AS $$
    SELECT cast(date1 - date2 AS float);
$$ LANGUAGE sql immutable;

CREATE FUNCTION daterangex_canonical(dr daterangex) RETURNS daterangex AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE TYPE daterangex AS RANGE (
    SUBTYPE = date,
    SUBTYPE_DIFF = date_minus,
    CANONICAL = daterangex_canonical    
);

CREATE FUNCTION daterange_to_daterangex(dr daterange) RETURNS daterangex AS 'MODULE_PATHNAME', 'daterangex_canonical'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION daterangex_to_daterange(dr daterangex) RETURNS daterange AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE CAST (daterange AS daterangex) WITH FUNCTION daterange_to_daterangex(daterange) AS IMPLICIT;
CREATE CAST (daterangex AS daterange) WITH FUNCTION daterangex_to_daterange(daterangex) AS IMPLICIT;

