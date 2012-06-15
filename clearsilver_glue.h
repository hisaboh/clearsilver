/****************************************************************************
 * Copyright (c) 2012, the Konoha project authors. All rights reserved.
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *  * Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 *  * Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 ***************************************************************************/

#ifndef CLEARSILVER_GLUE_H_
#define CLEARSILVER_GLUE_H_

#ifdef __cplusplus
extern "C" {
#endif

#include <ClearSilver/ClearSilver.h>
#include <ClearSilver/cgi/cgi.h>

/* ======================================================================== */

typedef struct kRawPtr {
	kObjectHeader h;
	union {
		void *rawptr;
		HDF *hdf;
	};
} kRawPtr;

typedef kRawPtr kHdf;

#define RawPtr_to(T, a)    ((T)((kRawPtr *)a.o)->rawptr)

static void kHdf_init(CTX, kObject *o, void *conf)
{
	kHdf *h = (kHdf *)o;
	hdf_init(&h->hdf);
}

static void kHdf_free(CTX, kObject *o)
{
	kHdf *h = (kHdf *)o;
	if(h->hdf != NULL) {
		hdf_destroy(&h->hdf);
		h->hdf = NULL;
	}
}

/* ======================================================================== */
/* [API bindings] */

//## Hdf Hdf.new();
static KMETHOD Hdf_new(CTX, ksfp_t *sfp _RIX)
{
	RETURN_(new_kObject(O_ct(sfp[K_RTNIDX].o), 0));
}

//## void Hdf.setValue(String name, String value);
static KMETHOD Hdf_setValue(CTX, ksfp_t *sfp _RIX)
{
	HDF *hdf = RawPtr_to(HDF *, sfp[0]);
	const char *name = S_text(sfp[1].s);
	const char *value = S_text(sfp[2].s);
	hdf_set_value(hdf, name, value);
	RETURNvoid_();
}

#define CT_Hdf cHdf
#define TY_Hdf cHdf->cid

static kbool_t clearsilver_initPackage(CTX, kKonohaSpace *ks, int argc, const char **args, kline_t pline)
{
// class definition
	KDEFINE_CLASS defHdf = {
		STRUCTNAME(Hdf),
		.cflag = kClass_Final,
		.init = kHdf_init,
		.free = kHdf_free,
	};
	kclass_t *cHdf = Konoha_addClassDef(ks->packid, ks->packdom, NULL, &defHdf, pline);

// method definition
#define _Public   kMethod_Public
#define _F(F)   (intptr_t)(F)
	intptr_t MethodData[] = {
		_Public, _F(Hdf_new)     , TY_Hdf , TY_Hdf, MN_("new"), 0,
		_Public, _F(Hdf_setValue), TY_void, TY_Hdf, MN_("setValue"), 2, TY_String, FN_("name"), TY_String, FN_("value"),
		DEND,
	};
	kKonohaSpace_loadMethodData(ks, MethodData);

// const definition
//#define _KVi(T) #T, TY_Int, T
//	KDEFINE_INT_CONST IntData[] = {
//		{_KVi(SIGHUP)},
//		{}
//	};
//	kKonohaSpace_loadConstData(kmodsugar->rootks, IntData, 0);

	return true;
}

static kbool_t clearsilver_setupPackage(CTX, kKonohaSpace *ks, kline_t pline)
{
	return true;
}

static kbool_t clearsilver_initKonohaSpace(CTX,  kKonohaSpace *ks, kline_t pline)
{
	return true;
}

static kbool_t clearsilver_setupKonohaSpace(CTX, kKonohaSpace *ks, kline_t pline)
{
	return true;
}

/* ======================================================================== */

#ifdef __cplusplus
}
#endif

#endif /* CLEARSILVER_GLUE_H_ */
