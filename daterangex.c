#include "postgres.h"
#include "utils/rangetypes.h"
#include "utils/date.h"
#include "utils/fmgrprotos.h"

PG_MODULE_MAGIC;

PG_FUNCTION_INFO_V1(daterangex_canonical);

Datum
daterangex_canonical(PG_FUNCTION_ARGS)
{
	RangeType  *r = PG_GETARG_RANGE_P(0);
	Node	   *escontext = fcinfo->context;
	TypeCacheEntry *typcache;
	RangeBound	lower;
	RangeBound	upper;
	bool		empty;

	typcache = range_get_typcache(fcinfo, RangeTypeGetOid(r));

	range_deserialize(typcache, r, &lower, &upper, &empty);

	if (empty)
		PG_RETURN_RANGE_P(r);

	if (!lower.infinite && !DATE_NOT_FINITE(DatumGetDateADT(lower.val)) &&
		!lower.inclusive)
	{
		DateADT		bnd = DatumGetDateADT(lower.val);

		bnd++;
		if (unlikely(!IS_VALID_DATE(bnd)))
			ereturn(escontext, (Datum) 0,
					(errcode(ERRCODE_DATETIME_VALUE_OUT_OF_RANGE),
					 errmsg("date out of range")));
		lower.val = DateADTGetDatum(bnd);
		lower.inclusive = true;
	}

	if (!upper.infinite && !DATE_NOT_FINITE(DatumGetDateADT(upper.val)) &&
		!upper.inclusive)
	{
		DateADT		bnd = DatumGetDateADT(upper.val);

		bnd--;
		if (unlikely(!IS_VALID_DATE(bnd)))
			ereturn(escontext, (Datum) 0,
					(errcode(ERRCODE_DATETIME_VALUE_OUT_OF_RANGE),
					 errmsg("date out of range")));
		upper.val = DateADTGetDatum(bnd);
		upper.inclusive = true;
	}

	PG_RETURN_RANGE_P(range_serialize(typcache, &lower, &upper,
									  false, escontext));
}

PG_FUNCTION_INFO_V1(daterangex_to_daterange);

Datum
daterangex_to_daterange(PG_FUNCTION_ARGS)
{
	return daterange_canonical(fcinfo);
}

PG_FUNCTION_INFO_V1(daterange_to_daterangex);

Datum
daterange_to_daterangex(PG_FUNCTION_ARGS)
{	
	RangeType  *r = PG_GETARG_RANGE_P(0);
	RangeTypeGetOid(r) = 2246043;
	return daterangex_canonical(fcinfo);
}




