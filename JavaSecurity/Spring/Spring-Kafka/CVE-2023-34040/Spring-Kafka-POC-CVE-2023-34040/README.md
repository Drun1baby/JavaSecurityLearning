# Spring Kafka Deserialization POC


## Requirements
* Java 11
* Maven
* Docker ( or Kafka )


## Usage

First start up the Dockerized Kafka instance. This will start up Kafka and make it available on port 29092.
```shell
docker-compose up
```

Start up the Consumer application.
```shell
cd spring-kafka-consumer
mvn clean install
mvn spring-boot:run
```
This will build and start the Consumer application. The Consumer will wait for a maximum of 10 minutes for a message before shutting down.


Producer
```shell
cd spring-kafka-producer
mvn clean install
mvn spring-boot:run
```
This will build and start the producer application. The producer will send a message to the kafka queue then shutdown.

### Spring-Kafka-Consumer configuration
For this vulnerability to succeed either or both of the following flags need to be enabled on the consumer.
`CheckDeserExWhenValueNull`
`CheckDeserExWhenKeyNull`
This is done in the Consumer application under `KafkaConsumerConfig.greetingKafkaListenerContainerFactory()`

### Payloads
There are two payloads that can be triggered, by default the RCE payload is used.

#### Denial of Service
To enable the DOS payload, modify the method KafkaApplication.sendGreetingMessage()
Change the payload that is added as a header to `dosPayload` and rebuild and run the producer.
NOTE : As the DOS happens as the message is read, and the read never finishes the message remains in the queue, until either deleted manually or the
message retention time expires. This increases the potency of the DOS as it renders that queue useless until either manual intervention occurs, or the retention time expires.
Potentially leading to data loss for messages sent immediately after the DOS message.

#### RCE
To enable the DOS payload, modify the method KafkaApplication.sendGreetingMessage()
Change the payload that is added as a header to `rcePayload` and rebuild and run the producer. By default the command that is run is
`touch /tmp/newfile` to see if the attack was successful look for a file named newfile under /tmp.
If running on Windows, you can modify the command string to something more suitable.
This Gadget is very much just a POC. For a RCE to occur in the real world, there would need to be a gadget class available on the Consumers class path.

#### How It works
The Denial of Service does not require there to be any specific gadget class available on the Consumers class path. It relies on generating a modified version of the class
`org.springframework.kafka.support.serializer.DeserializationException` that contains a Object.
This makes it easy to then add whichever payload we like into the serialized object.
This modified class is called `xrg.springframework.kafka.support.serializer.DeserializationException` ( Note the x at the start of the package name).
Once the payload is injected, in this case a billion laughs style attack using `java.util.Set` and `java.lang.Object` it is serialized.
then the binary data is modified to change the x to o matching what the consumer expects.

This serialized exception class is then added as a message header in both the `springDeserializerExceptionValue` header and the `springDeserializerExceptionKey` header.
These are then read by the consumer if either the key or message is null. After that just ensure the key or message is null and the consumer will read it.

There is some deserialization protection within Spring-Kafka. In ListenerUtils.
```java
public static DeserializationException byteArrayToDeserializationException(LogAccessor logger, byte[] value) {
    try {
        ObjectInputStream ois = new ObjectInputStream(new ByteArrayInputStream(value)) {

            boolean first = true;

            @Override
            protected Class<?> resolveClass(ObjectStreamClass desc) throws IOException, ClassNotFoundException {
                if (this.first) {
                    this.first = false;
                    Assert.state(desc.getName().equals(DeserializationException.class.getName()),
                            "Header does not contain a DeserializationException");
                }
                return super.resolveClass(desc);
            }


        };
        return (DeserializationException) ois.readObject();
    }
    catch (IOException | ClassNotFoundException | ClassCastException e) {
        logger.error(e, "Failed to deserialize a deserialization exception");
        return null;
    }
}
```
You can see a check is made to ensure that the top level class is `org.springframework.kafka.support.serializer.DeserializationException`. But note only the top level class is checked, and then only the class name ( which is within the attackers ability to modify ). So any payload below that level is deserialized.
