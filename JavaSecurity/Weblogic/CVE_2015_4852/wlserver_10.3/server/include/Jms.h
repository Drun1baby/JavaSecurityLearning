/*! \file Jms.h
    \brief A single header file which pulls in all necessary JMS C API header files
    \author Copyright (c) 2002, BEA Systems, Inc.
*/

#ifndef _JMS_H
#define _JMS_H 1

#include <JmsCommon.h>
#include <JmsException.h>
#include <JmsBrowser.h>
#include <JmsBytesMessage.h>
#include <JmsConnection.h>
/* #include <JmsConnectionFactory.h> */
#include <JmsMapMessage.h>
#include <JmsConsumer.h>
#include <JmsDestination.h>
#include <JmsEnumeration.h>
#include <JmsMessage.h>
#include <JmsMetaData.h>
#include <JmsProducer.h>
#include <JmsQueue.h>
#include <JmsSession.h>
#include <JmsStreamMessage.h>
#include <JmsTextMessage.h>
#include <JmsTopic.h>
#include <JmsTypes.h>

/*!
  A return code indicating that an exception occurred in this thread of execution
  */
#define JMS_GOT_EXCEPTION 1

/*!
  A return code indicating success
  */
#define JMS_NO_ERROR 0

/*!
  A return code indicating that an error was detected with one of the input parameters
  */
#define JMS_INPUT_PARAM_ERROR -1

/*!
  A return code indicating that an attempt to allocated memory failed.  Either
  the heap has run out of memory or the malloc memory arena has been
  corrupted
  */
#define JMS_MALLOC_ERROR -2

/*!
  An unexpected error has occurred in the JVM.  This return code is only valid if
  the implementation uses JNI
  */
#define JMS_JVM_ERROR -3

/*!
  There is not enough space in an input parameter for all of the output
  */
#define JMS_NEED_SPACE -4

/*!
  An attempt was made to extract information from the wrong type of exception
  */
#define JMS_INVALID_EXCEPTION_TYPE -5

/*!
  A system error has occurred.  The exact nature of the error may be provided in a log file.
  */
#define JMS_SYSTEM_ERROR -6

#endif /* _JMS_H */

