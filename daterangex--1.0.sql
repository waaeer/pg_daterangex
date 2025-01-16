CREATE TYPE daterangex;
CREATE FUNCTION date_minus(date1 date, date2 date) RETURNS float AS $$
    SELECT cast(date1 - date2 as float);
$$ LANGUAGE sql immutable;


CREATE FUNCTION daterangex_canonical(dr daterangex) RETURNS daterangex AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE TYPE daterangex AS RANGE (
    SUBTYPE = date,
    SUBTYPE_DIFF = date_minus,
    CANONICAL = daterangex_canonical    
);
