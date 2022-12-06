/*! \file JmsMapMessage.h
    \brief Describes a JmsMapMessage handle
    
    This file describes the functions that can be performed on a JmsMapMessage handle
    A JmsMapMessage handle corresponds to javax.jms.MapMessage
    \author Copyright (c) 2002, BEA Systems, Inc.
*/
#ifndef _JMS_MAP_MESSAGE_H
#define _JMS_MAP_MESSAGE_H 1

#include <JmsCommon.h>
#include <JmsSession.h>
#include <JmsMessage.h>
#include <JmsEnumeration.h>
#include <JmsTypes.h>

/*!
  A map message handle that represents the class javax.jms.MapMessage
  */
typedef JmsMessage JmsMapMessage;

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

/*!
  Gets a map message handle from the given session handle
  \param session Must be a valid session handle.  May not be NULL
  \param message May not be NULL.  On success, *message will contain
  a valid map message handle
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsSessionMapMessageCreate(
  JmsSession        *  session,
  JmsMapMessage ** message,
  JMS64I              flags
);

/*!
  Gets a boolean value of the given tag name from a map message handle
  \param message Must be a valid map message handle.  May not be NULL
  \param name The tag name to retrieve
  \param value May not be NULL.  On success, *value will contain the
  boolean value with the given tag name
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMapMessageGetBoolean(
  JmsMapMessage   * message,
  JmsString       * name,
  int             * value,
  JMS64I              flags
);

/*!
  Gets a byte value of the given tag name from a map message handle
  \param message Must be a valid map message handle.  May not be NULL
  \param name The tag name to retrieve
  \param value May not be NULL.  On success, *value will contain the
  byte value with the given tag name
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMapMessageGetByte(
  JmsMapMessage   * message,
  JmsString       * name,
  unsigned char            * value,
  JMS64I              flags
);

/*!
  Gets a two byte java character value of the given tag name from a map
  message handle
  \param message Must be a valid map message handle.  May not be NULL
  \param name The tag name to retrieve
  \param value May not be NULL.  On success, *value will contain the
  two byte java character value with the given tag name
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMapMessageGetChar(
  JmsMapMessage   * message,
  JmsString       * name,
  short            * value,
  JMS64I              flags
);

/*!
  Gets a short value of the given tag name from a map message handle
  \param message Must be a valid map message handle.  May not be NULL
  \param name The tag name to retrieve
  \param value May not be NULL.  On success, *value will contain the
  short value with the given tag name
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMapMessageGetShort(
  JmsMapMessage   * message,
  JmsString       * name,
  short           * value,
  JMS64I              flags
);

/*!
  Gets an integer value of the given tag name from a map message handle
  \param message Must be a valid map message handle.  May not be NULL
  \param name The tag name to retrieve
  \param value May not be NULL.  On success, *value will contain the
  integer value with the given tag name
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMapMessageGetInt(
  JmsMapMessage   * message,
  JmsString       * name,
  JMS32I          * value,
  JMS64I              flags
);

/*!
  Gets a long value of the given tag name from a map message handle
  \param message Must be a valid map message handle.  May not be NULL
  \param name The tag name to retrieve
  \param value May not be NULL.  On success, *value will contain the
  long value with the given tag name
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMapMessageGetLong(
  JmsMapMessage   * message,
  JmsString       * name,
  JMS64I          * value,
  JMS64I              flags
);

/*!
  Gets a float value of the given tag name from a map message handle
  \param message Must be a valid map message handle.  May not be NULL
  \param name The tag name to retrieve
  \param value May not be NULL.  On success, *value will contain the
  float value with the given tag name
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMapMessageGetFloat(
  JmsMapMessage   * message,
  JmsString            * name,
  float           * value,
  JMS64I              flags
);

/*!
  Gets a double value of the given tag name from a map message handle
  \param message Must be a valid map message handle.  May not be NULL
  \param name The tag name to retrieve
  \param value May not be NULL.  On success, *value will contain the
  double value with the given tag name
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMapMessageGetDouble(
  JmsMapMessage   * message,
  JmsString       * name,
  double          * value,
  JMS64I              flags
);

/*!
  Gets a string value of the given tag name from a map message handle
  \param message Must be a valid map message handle.  May not be NULL
  \param name The tag name to retrieve
  \param value May not be NULL.  On success, will contain the
  string value with the given tag name
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
    - JMS_NEED_SPACE
  */
extern int JMSENTRY JmsMapMessageGetString(
  JmsMapMessage   * message,
  JmsString       * name,
  JmsString           * value,
  JMS64I              flags
);

/*!
  Gets a byte array value of the given tag name from a map message handle
  \param message Must be a valid map message handle.  May not be NULL
  \param name The tag name to retrieve
  \param bytes May not be NULL.  Must have at least *length bytes to be
  written into.  On success this array will be filled in up to *length bytes
  \param length May not be NULL.  On input, *length must contain the number
  of bytes that can be written to bytes.  If the return is JMS_NEED_SPACE
  then *length will contain the number of bytes necessary to get the
  complete byte array and bytes will have been filled in as much as possible.
  On success, *length will contain the actual number of bytes written to
  bytes
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
    - JMS_NEED_SPACE
  */
extern int JMSENTRY JmsMapMessageGetBytes(
  JmsMapMessage   * message,
  JmsString       * name,
  void            * bytes,
  JMS32I          * length,
  JMS64I              flags
);

/*!
  Gets an enumeration handle containing the names of all the tags in this
  map message handle
  \param message Must be a valid map message handle.  May not be NULL
  \param enumeration May not be NULL.  On success, *enumeration will
  contain a valid enumeration handle.  The value parameter of
  JmsEnumerationNextElement should be a JmsString ** with this enumeration.
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
    - JMS_NEED_SPACE
  */
extern int JMSENTRY JmsMapMessageGetNames(
  JmsMapMessage   * message,
  JmsEnumeration ** enumeration,
  JMS64I              flags
);

/*!
  Sets a boolean value with the given tag name on a map message
  \param message Must be a valid map message handle.  May not be NULL
  \param name The tag name to set
  \param value The boolean value to set on the map message handle
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMapMessageSetBoolean(
  JmsMapMessage   * message,
  JmsString       * name,
  int               value,
  JMS64I              flags
);

/*!
  Sets a byte value with the given tag name on a map message
  \param message Must be a valid map message handle.  May not be NULL
  \param name The tag name to set
  \param value The byte value to set on the map message handle
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMapMessageSetByte(
  JmsMapMessage   * message,
  JmsString       * name,
  unsigned char              value,
  JMS64I              flags
);

/*!
  Sets a short value with the given tag name on a map message
  \param message Must be a valid map message handle.  May not be NULL
  \param name The tag name to set
  \param value The short value to set on the map message handle
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMapMessageSetShort(
  JmsMapMessage   * message,
  JmsString       * name,
  short             value,
  JMS64I              flags
);

/*!
  Sets a two byte java character value with the given tag name on a
  map message
  \param message Must be a valid map message handle.  May not be NULL
  \param name The tag name to set
  \param value The two byte java character value to set on the map
  message handle
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMapMessageSetChar(
  JmsMapMessage   * message,
  JmsString       * name,
  short              value,
  JMS64I              flags
);

/*!
  Sets an integer value with the given tag name on a map message
  \param message Must be a valid map message handle.  May not be NULL
  \param name The tag name to set
  \param value The integer value to set on the map message handle
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMapMessageSetInt(
  JmsMapMessage   * message,
  JmsString       * name,
  JMS32I            value,
  JMS64I              flags
);

/*!
  Sets a long value with the given tag name on a map message
  \param message Must be a valid map message handle.  May not be NULL
  \param name The tag name to set
  \param value The long value to set on the map message handle
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMapMessageSetLong(
  JmsMapMessage   * message,
  JmsString       * name,
  JMS64I            value,
  JMS64I              flags
);

/*!
  Sets a float value with the given tag name on a map message
  \param message Must be a valid map message handle.  May not be NULL
  \param name The tag name to set
  \param value The float value to set on the map message handle
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMapMessageSetFloat(
  JmsMapMessage   * message,
  JmsString       * name,
  float             value,
  JMS64I              flags
);

/*!
  Sets a double value with the given tag name on a map message
  \param message Must be a valid map message handle.  May not be NULL
  \param name The tag name to set
  \param value The double value to set on the map message handle
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMapMessageSetDouble(
  JmsMapMessage   * message,
  JmsString       * name,
  double            value,
  JMS64I              flags
);

/*!
  Sets a string value with the given tag name on a map message
  \param message Must be a valid map message handle.  May not be NULL
  \param name The tag name to set
  \param value The string value to set on the map message handle
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMapMessageSetString(
  JmsMapMessage   * message,
  JmsString       * name,
  JmsString       * value,
  JMS64I              flags
);

/*!
  Sets a byte array value with the given tag name on a map message
  \param message Must be a valid map message handle.  May not be NULL
  \param name The tag name to set
  \param value The byte array to set on the map message handle
  \param length The number of bytes to write from bytes
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMapMessageSetBytes(
  JmsMapMessage   * message,
  JmsString       * name,
  void            * value,
  JMS32I               length,
  JMS64I              flags
);

/*!
  Tells whether or not a given tag name exists on the map message handles
  \param message Must be a valid map message handle.  May not be NULL
  \param name The tag name to query
  \param boolean May not be NULL.  On success, *boolean will be zero if the tag
  name does not exist on the message and will be non-zero if the tag name
  does exist
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMapMessageItemExists(
  JmsMapMessage   * message,
  JmsString       * name,
  int             * boolean,
  JMS64I              flags
);

#ifdef __cplusplus
}
#endif /* __cplusplus */
#endif /* _JMS_MAP_MESSAGE_H */
