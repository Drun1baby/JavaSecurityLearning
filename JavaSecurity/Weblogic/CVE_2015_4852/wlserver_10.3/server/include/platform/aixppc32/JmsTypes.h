/* Copyright (c) 2002, BEA Systems, Inc. */
/* All Rights Reserved.                  */
/* JmsTypes.h for aixppc32 */

/*
 * JMS32I must be a 32 bit signed primitive integer, usually int
 */
#define JMS32I int

/*
 * JMS64I should be a 64 bit signed primitive integer, but on platforms
 * that do not support a 64-bit primitive type it can be 32 bits.  Note
 * that if JMS64I is actually 32 bits, the macro JMS64IS32 must be set to
 * one.  This is usually a long
 */
#define JMS64I long

/*
 * JMS64IS32 should be set to one if a JMS64I is actually 32 bits, and set
 * to zero if 64 is 64.
 */
#define JMS64IS32 1

/*
 * JMSENTRY is the qualifier needed for platforms such as windows that need
 * to know if a method is to be exported from a DLL or shared library.
 * This value is set to nothing on most platforms except windows, which will
 * typicaly set it to __stdcall
 */
#define JMSENTRY
