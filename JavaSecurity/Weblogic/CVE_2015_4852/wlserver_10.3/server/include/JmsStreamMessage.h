/*! \file JmsStreamMessage.h
    \brief Describes a JmsStreamMessage handle
    
    This file describes the functions that can be performed on a JmsStreamMessage handle
    A JmsStreamMessage handle corresponds to javax.jms.StreamMessage
    \author Copyright (c) 2002, BEA Systems, Inc.
*/

#ifndef _JMS_STREAM_MESSAGE_H
#define _JMS_STREAM_MESSAGE_H 1

#include <JmsCommon.h>
#include <JmsSession.h>
#include <JmsMessage.h>
#include <JmsTypes.h>

/*!
  A stream message handle that represents the class javax.jms.StreamMessage
  */
typedef JmsMessage JmsStreamMessage;

#ifdef __cplusplus
extern "C" {
#endif

/*!
  Gets a stream message handle from the given session handle
  \param session Must be a valid session handle.  May not be NULL
  \param message May not be NULL.  On success, *message will contain
  a valid stream message handle
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsSessionStreamMessageCreate(
  JmsSession             *  session,
  JmsStreamMessage ** message,
  JMS64I              flags
);

/*!
  Reads the next boolean value from a stream message handle
  \param message Must be a valid stream message handle.  May not be NULL
  \param value May not be NULL.  On success, *value will contain the
  boolean value
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsStreamMessageReadBoolean(
  JmsStreamMessage  * message,
  int               * value,
  JMS64I              flags
);

/*!
  Reads the next byte value from a stream message handle
  \param message Must be a valid stream message handle.  May not be NULL
  \param value May not be NULL.  On success, *value will contain the
  byte value
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsStreamMessageReadByte(
  JmsStreamMessage  * message,
  unsigned char              * value,
  JMS64I              flags
);

/*!
  Reads the next short value from a stream message handle
  \param message Must be a valid stream message handle.  May not be NULL
  \param value May not be NULL.  On success, *value will contain the
  short value
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsStreamMessageReadShort(
  JmsStreamMessage  * message,
  short             * value,
  JMS64I              flags
);

/*!
  Reads the next two byte java character value from a stream message handle
  \param message Must be a valid stream message handle.  May not be NULL
  \param value May not be NULL.  On success, *value will contain the
  two byte java character value
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsStreamMessageReadChar(
  JmsStreamMessage  * message,
  short              * value,
  JMS64I              flags
);

/*!
  Reads the next integer value from a stream message handle
  \param message Must be a valid stream message handle.  May not be NULL
  \param value May not be NULL.  On success, *value will contain the
  integer value
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsStreamMessageReadInt(
  JmsStreamMessage  * message,
  JMS32I            * value,
  JMS64I              flags
);

/*!
  Reads the next long value from a stream message handle
  \param message Must be a valid stream message handle.  May not be NULL
  \param value May not be NULL.  On success, *value will contain the
  long value
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsStreamMessageReadLong(
  JmsStreamMessage  * message,
  JMS64I            * value,
  JMS64I              flags
);

/*!
  Reads the next float value from a stream message handle
  \param message Must be a valid stream message handle.  May not be NULL
  \param value May not be NULL.  On success, *value will contain the
  float value
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsStreamMessageReadFloat(
  JmsStreamMessage  * message,
  float             * value,
  JMS64I              flags
);

/*!
  Reads the next double value from a stream message handle
  \param message Must be a valid stream message handle.  May not be NULL
  \param value May not be NULL.  On success, *value will contain the
  double value
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsStreamMessageReadDouble(
  JmsStreamMessage  * message,
  double            * value,
  JMS64I              flags
);

/*!
  Reads the next string value from a stream message handle
  \param message Must be a valid stream message handle.  May not be NULL
  \param value May not be NULL.  On success, will contain the
  string value
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
    - JMS_NEED_SPACE
  */
extern int JMSENTRY JmsStreamMessageReadString(
  JmsStreamMessage   * message,
  JmsString           * value,
  JMS64I              flags
);

/*!
  Reads the next byte array value from a stream message handle
  \param message Must be a valid stream message handle.  May not be NULL
  \param bytes May not be NULL. An area to read the bytes from the array
  into that must be at least *length bytes in size
  \param length May not be NULL.  On input, *length must contain the number
  of writeable bytes at bytes.  On success, *length will contain the number
  of bytes read
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsStreamMessageReadBytes(
  JmsStreamMessage   * message,
  void               * bytes,
  JMS32I             * length,
  JMS64I              flags
);

/*!
  Writes the boolean value to a stream message handle
  \param message Must be a valid stream message handle.  May not be NULL
  \param value The boolean value to write
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsStreamMessageWriteBoolean(
  JmsStreamMessage   * message,
  int                  value,
  JMS64I              flags
);

/*!
  Writes the byte value to a stream message handle
  \param message Must be a valid stream message handle.  May not be NULL
  \param value The byte value to write
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsStreamMessageWriteByte(
  JmsStreamMessage   * message,
  unsigned char                 value,
  JMS64I              flags
);

/*!
  Writes the short value to a stream message handle
  \param message Must be a valid stream message handle.  May not be NULL
  \param value The short value to write
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsStreamMessageWriteShort(
  JmsStreamMessage   * message,
  short                value,
  JMS64I              flags
);

/*!
  Writes the two byte java character value to a stream message handle
  \param message Must be a valid stream message handle.  May not be NULL
  \param value The two byte java character value to write
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsStreamMessageWriteChar(
  JmsStreamMessage   * message,
  short                 value,
  JMS64I              flags
);

/*!
  Writes the integer value to a stream message handle
  \param message Must be a valid stream message handle.  May not be NULL
  \param value The integer value to write
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsStreamMessageWriteInt(
  JmsStreamMessage   * message,
  JMS32I               value,
  JMS64I              flags
);

/*!
  Writes the long value to a stream message handle
  \param message Must be a valid stream message handle.  May not be NULL
  \param value The long value to write
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsStreamMessageWriteLong(
  JmsStreamMessage   * message,
  JMS64I               value,
  JMS64I              flags
);

/*!
  Writes the float value to a stream message handle
  \param message Must be a valid stream message handle.  May not be NULL
  \param value The float value to write
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsStreamMessageWriteFloat(
  JmsStreamMessage   * message,
  float                value,
  JMS64I              flags
);

/*!
  Writes the double value to a stream message handle
  \param message Must be a valid stream message handle.  May not be NULL
  \param value The double value to write
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsStreamMessageWriteDouble(
  JmsStreamMessage   * message,
  double               value,
  JMS64I              flags
);

/*!
  Writes the string value to a stream message handle
  \param message Must be a valid stream message handle.  May not be NULL
  \param value The string value to write.  May not be NULL
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsStreamMessageWriteString(
  JmsStreamMessage   * message,
  JmsString          * value,
  JMS64I              flags
);

/*!
  Writes the byte array value to a stream message handle
  \param message Must be a valid stream message handle.  May not be NULL
  \param value The bytes to write to the stream
  \param length The number of bytes to write
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsStreamMessageWriteBytes(
  JmsStreamMessage   * message,
  void               * value,
  JMS32I               length,
  JMS64I              flags
);

/*!
  Puts the message body in read-only mode and repositions the
  stream to the beginning
  \param message Must be a valid stream message handle.  May not be NULL
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsStreamMessageReset(
  JmsStreamMessage   * message,
  JMS64I              flags
);

#ifdef __cplusplus
}
#endif /* __cplusplus */
#endif /* _JMS_STREAM_MESSAGE_H */

