
/* Compiler implementation of the D programming language
 * Copyright (C) 1999-2019 by The D Language Foundation, All Rights Reserved
 * All Rights Reserved
 * http://www.digitalmars.com
 * Distributed under the Boost Software License, Version 1.0.
 * http://www.boost.org/LICENSE_1_0.txt
 * https://github.com/D-Programming-Language/dmd/blob/master/src/gluestub.c
 */

#include "module.h"
#include "declaration.h"
#include "aggregate.h"
#include "enum.h"
#include "attrib.h"
#include "template.h"
#include "statement.h"
#include "init.h"
#include "ctfe.h"
#include "lib.h"
#include "nspace.h"

// tocsym

Symbol *toInitializer(AggregateDeclaration *ad)
{
    return NULL;
}

// glue

void obj_write_deferred(Library *library)
{
}

void obj_start(char *srcfile)
{
}

void obj_end(Library *library, File *objfile)
{
}

void genObjFile(Module *m, bool multiobj)
{
}

// msc

void backend_init()
{
}

void backend_term()
{
}

// lib

Library *LibMSCoff_factory()
{
    assert(0);
    return NULL;
}

Library *LibOMF_factory()
{
    assert(0);
    return NULL;
}

Library *LibElf_factory()
{
    assert(0);
    return NULL;
}

Library *LibMach_factory()
{
    assert(0);
    return NULL;
}

Statement* asmSemantic(AsmStatement *s, Scope *sc)
{
    assert(0);
    return NULL;
}

// toir

RET retStyle(TypeFunction *tf)
{
    return RETregs;
}