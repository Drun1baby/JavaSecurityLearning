package xrg.springframework.kafka.support.serializer;

import java.io.Serializable;
import java.util.Set;

public class DeserializationException implements Serializable {

    private static final long serialVersionUID = 8280022391259546509L;

    private Object set;

    public DeserializationException(Object set) {
        this.set = set;
    }



}
