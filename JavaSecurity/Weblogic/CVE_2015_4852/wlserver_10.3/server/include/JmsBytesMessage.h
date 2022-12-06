/*! \file JmsBytesMessage.h
    \brief Describes a JmsBytesMessage handle
    \author Copyright (c) 2002, BEA Systems, Inc.
    This file describes the functions that can be performed on a JmsBytesMessage handle
    A JmsBytesMessage handle corresponds to javax.jms.BytesMessage
*/
#ifndef _JMS_BYTES_MESSAGE_H
#define _JMS_BYTES_MESSAGE_H 1

#include <JmsCommon.h>
#include <JmsSession.h>
#include <JmsMessage.h>
#include <JmsTypes.h>

/*!
  A bytes message handle that represents the class javax.jms.BytesMessage
  */
typedef JmsMessage JmsBytesMessage;

#ifdef __cplusplus
extern "C" {
#endif

/*!
  Gets a bytes message handle from the given session
  \param session Must be a valid session handle.  May not be NULL
  \param message May not be NULL.  On success *message will contain a
    valid JmsBytesMessage handle
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsSessionBytesMessageCreate(
  JmsSession           *  session,
  JmsBytesMessage ** message,
  JMS64I              flags
);

/*!
  Gets the body length of a bytes message
  \param message Must be a valid bytes message handle.  May not be NULL
  \param length Must not be NULL.  On success *length will contain the
  body length of the bytes message
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsBytesMessageGetBodyLength(
  JmsBytesMessage * message,
  JMS64I          * length,
  JMS64I              flags
);

/*!
  Reads a boolean from the bytes message stream
  \param message Must be a valid bytes message handle.  May not be NULL
  \param value Must not be NULL.  On success *value will contain the
    boolean value from the bytes message stream
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsBytesMessageReadBoolean(
  JmsBytesMessage * message,
  int             * value,
  JMS64I              flags
);

/*!
  Reads a byte from the bytes message stream
  \param message Must be a valid bytes message handle.  May not be NULL
  \param value Must not be NULL.  On success *value will contain the
    byte value from the bytes message stream
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsBytesMessageReadByte(
  JmsBytesMessage * message,
  unsigned char            * value,
  JMS64I              flags
);

/*!
  Reads an unsigned byte from the bytes message stream
  \param message Must be a valid bytes message handle.  May not be NULL
  \param value Must not be NULL.  On success *value will contain the
    unsigned byte value from the bytes message stream
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsBytesMessageReadUnsignedByte(
  JmsBytesMessage * message,
  unsigned char   * value,
  JMS64I              flags
);

/*!
  Reads a short from the bytes message stream
  \param message Must be a valid bytes message handle.  May not be NULL
  \param value Must not be NULL.  On success *value will contain the
    short value from the bytes message stream
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsBytesMessageReadShort(
  JmsBytesMessage * message,
  short           * value,
  JMS64I              flags
);

/*!
  Reads an unsigned short from the bytes message stream
  \param message Must be a valid bytes message handle.  May not be NULL
  \param value Must not be NULL.  On success *value will contain the
    unsigned short value from the bytes message stream
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsBytesMessageReadUnsignedShort(
  JmsBytesMessage * message,
  unsigned short  * value,
  JMS64I              flags
);

/*!
  Reads a two-byte java character from the bytes message stream
  \param message Must be a valid bytes message handle.  May not be NULL
  \param value Must not be NULL.  On success *value will contain the
    two-byte java character value from the bytes message stream
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsBytesMessageReadChar(
  JmsBytesMessage * message,
  short            * value,
  JMS64I              flags
);

/*!
  Reads an integer from the bytes message stream
  \param message Must be a valid bytes message handle.  May not be NULL
  \param value Must not be NULL.  On success *value will contain the
    integer value from the bytes message stream
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsBytesMessageReadInt(
  JmsBytesMessage * message,
  JMS32I          * value,
  JMS64I              flags
);

/*!
  Reads a long from the bytes message stream
  \param message Must be a valid bytes message handle.  May not be NULL
  \param value Must not be NULL.  On success *value will contain the
    long value from the bytes message stream
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsBytesMessageReadLong(
  JmsBytesMessage * message,
  JMS64I          * value,
  JMS64I              flags
);

/*!
  Reads a float from the bytes message stream
  \param message Must be a valid bytes message handle.  May not be NULL
  \param value Must not be NULL.  On success *value will contain the
    float value from the bytes message stream
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsBytesMessageReadFloat(
  JmsBytesMessage * message,
  float           * value,
  JMS64I              flags
);

/*!
  Reads a double from the bytes message stream
  \param message Must be a valid bytes message handle.  May not be NULL
  \param value Must not be NULL.  On success *value will contain the
    double value from the bytes message stream
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsBytesMessageReadDouble(
  JmsBytesMessage * message,
  double          * value,
  JMS64I              flags
);

/*!
  Reads a UTF-8 encoded string from the bytes message stream
  \param message Must be a valid bytes message handle.  May not be NULL
  \param value Must not be NULL
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsBytesMessageReadUTF(
  JmsBytesMessage * message,
  JmsString      * value,
  JMS64I              flags
);

/*!
  Reads a byte array from the bytes message stream
  \param message Must be a valid bytes message handle.  May not be NULL
  \param bytes Must not be NULL.  On success will be filled in with *length
    bytes from the bytes message stream
  \param length *length must contain the number of bytes available to be written in
    bytes.  On success, *length will contain the number of bytes written to bytes
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsBytesMessageReadBytes(
  JmsBytesMessage * message,
  void       * bytes,
  JMS32I          * length,
  JMS64I              flags
);

/*!
  Writes a boolean value to the bytes message stream
  \param message Must be a valid bytes message handle.  May not be NULL
  \param value The boolean value to write to the bytes message stream
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsBytesMessageWriteBoolean(
  JmsBytesMessage * message,
  int               value,
  JMS64I              flags
);

/*!
  Writes a byte value to the bytes message stream
  \param message Must be a valid bytes message handle.  May not be NULL
  \param value The byte value to write to the bytes message stream
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsBytesMessageWriteByte(
  JmsBytesMessage * message,
  unsigned char              value,
  JMS64I              flags
);

/*!
  Writes a short value to the bytes message stream
  \param message Must be a valid bytes message handle.  May not be NULL
  \param value The short value to write to the bytes message stream
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsBytesMessageWriteShort(
  JmsBytesMessage * message,
  short             value,
  JMS64I              flags
);

/*!
  Writes a two byte java character value to the bytes message stream
  \param message Must be a valid bytes message handle.  May not be NULL
  \param value The two byte java character value to write to the bytes
    message stream
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsBytesMessageWriteChar(
  JmsBytesMessage * message,
  short              value,
  JMS64I              flags
);

/*!
  Writes an integer value to the bytes message stream
  \param message Must be a valid bytes message handle.  May not be NULL
  \param value The integer value to write to the bytes message stream
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsBytesMessageWriteInt(
  JmsBytesMessage * message,
  JMS32I            value,
  JMS64I              flags
);

/*!
  Writes a long value to the bytes message stream
  \param message Must be a valid bytes message handle.  May not be NULL
  \param value The long value to write to the bytes message stream
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsBytesMessageWriteLong(
  JmsBytesMessage * message,
  JMS64I            value,
  JMS64I              flags
);

/*!
  Writes a float value to the bytes message stream
  \param message Must be a valid bytes message handle.  May not be NULL
  \param value The float value to write to the bytes message stream
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsBytesMessageWriteFloat(
  JmsBytesMessage * message,
  float             value,
  JMS64I              flags
);

/*!
  Writes a double value to the bytes message stream
  \param message Must be a valid bytes message handle.  May not be NULL
  \param value The double value to write to the bytes message stream
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsBytesMessageWriteDouble(
  JmsBytesMessage * message,
  double            value,
  JMS64I              flags
);

/*!
  Writes a UTF-8 encoded string value to the bytes message stream
  \param message Must be a valid bytes message handle.  May not be NULL
  \param value May not be NULL.  The UTF-8 encoded string value to write
    to the bytes message stream
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsBytesMessageWriteUTF(
  JmsBytesMessage * message,
  JmsString        * value,
  JMS64I              flags
);

/*!
  Writes a byte array value to the bytes message stream
  \param message Must be a valid bytes message handle.  May not be NULL
  \param value The bytes to write to the bytes message stream
  \param length The number of bytes to write
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsBytesMessageWriteBytes(
  JmsBytesMessage * message,
  void       * value,
  int               length,
  JMS64I              flags
);

/*!
  Resets the bytes message stream.
  Puts the message body in read-only mode and repositions the stream of bytes to the beginning.
  \param message Must be a valid bytes message handle.  May not be NULL
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsBytesMessageReset(
  JmsBytesMessage * message,
  JMS64I              flags
);

#ifdef __cplusplus
}
#endif /* __cplusplus */
#endif /* _BYTES_MESSAGE_H */

