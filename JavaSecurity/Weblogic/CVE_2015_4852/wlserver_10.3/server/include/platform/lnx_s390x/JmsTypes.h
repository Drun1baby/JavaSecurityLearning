/* Copyright (c) 2002, BEA Systems, Inc. */
/* All Rights Reserved.                  */


/*************************************************************************
 *
 * This file is a template file, and is not meant to be compiled into
 * any platform.  This file is here to help port the C client to different
 * platforms.  It simply lists and describes all of the pound defines that
 * must be set in the actual JmsTypes.h file for a specific platform.
 * If any new porting variable is added, then it should be added to this
 * file and described so that people porting to new platforms can make
 * an intelligent decision about how to set that variable while doing
 * a new port.
 *
 * The general porting strategy is to have a directory appropriately named
 * for each platform.  There are two files in each directory: JmsTypes.h
 * which will be available for customers, and JmsTypesI.h, which will not.
 * The makefile should determine what platform it is running on, and copy
 * the JmsTypes.h and JmsTypesI.h file to the proper includes directories
 * in the build area.
 *************************************************************************/

/*
 * The following definitions must be in the JmsTypes.h file
 */

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
#define JMS64IS32 0

/*
 * JMSENTRY is the qualifier needed for platforms such as windows that need
 * to know if a method is to be exported from a DLL or shared library.
 * This value is set to nothing on most platforms except windows, which will
 * typicaly set it to __stdcall
 */
#define JMSENTRY
