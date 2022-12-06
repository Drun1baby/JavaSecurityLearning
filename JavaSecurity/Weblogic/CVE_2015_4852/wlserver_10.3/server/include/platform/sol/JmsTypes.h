/* Copyright (c) 2002, BEA Systems, Inc. */
/* All Rights Reserved.                  */

#ifndef _JMS_TYPES_H
#define _JMS_TYPES_H 1

#define JMS32I int
#ifdef _LP64
#define JMS64I long
#else
#define JMS64I long long
#endif
#define JMSENTRY

#endif /* _JMS_TYPES_H */

