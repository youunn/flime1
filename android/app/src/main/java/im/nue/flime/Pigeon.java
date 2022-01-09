// Autogenerated from Pigeon (v1.0.13), do not edit directly.
// See also: https://pub.dev/packages/pigeon

package im.nue.flime;

import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MessageCodec;
import io.flutter.plugin.common.StandardMessageCodec;
import java.io.ByteArrayOutputStream;
import java.nio.ByteBuffer;
import java.util.Arrays;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

/** Generated class from Pigeon. */
@SuppressWarnings({"unused", "unchecked", "CodeBlock2Expr", "RedundantSuppression"})
public class Pigeon {

  /** Generated class from Pigeon that represents data sent in messages. */
  public static class Content {
    private String text;
    public String getText() { return text; }
    public void setText(String setterArg) { this.text = setterArg; }

    Map<String, Object> toMap() {
      Map<String, Object> toMapResult = new HashMap<>();
      toMapResult.put("text", text);
      return toMapResult;
    }
    static Content fromMap(Map<String, Object> map) {
      Content fromMapResult = new Content();
      Object text = map.get("text");
      fromMapResult.text = (String)text;
      return fromMapResult;
    }
  }
  private static class ContextApiCodec extends StandardMessageCodec {
    public static final ContextApiCodec INSTANCE = new ContextApiCodec();
    private ContextApiCodec() {}
    @Override
    protected Object readValueOfType(byte type, ByteBuffer buffer) {
      switch (type) {
        case (byte)128:         
          return Content.fromMap((Map<String, Object>) readValue(buffer));
        
        default:        
          return super.readValueOfType(type, buffer);
        
      }
    }
    @Override
    protected void writeValue(ByteArrayOutputStream stream, Object value)     {
      if (value instanceof Content) {
        stream.write(128);
        writeValue(stream, ((Content) value).toMap());
      } else 
{
        super.writeValue(stream, value);
      }
    }
  }

  /** Generated interface from Pigeon that represents a handler of messages from Flutter.*/
  public interface ContextApi {
    Boolean commit(Content content);
    Boolean delete();
    Boolean enter();

    /** The codec used by ContextApi. */
    static MessageCodec<Object> getCodec() {
      return ContextApiCodec.INSTANCE;
    }

    /** Sets up an instance of `ContextApi` to handle messages through the `binaryMessenger`. */
    static void setup(BinaryMessenger binaryMessenger, ContextApi api) {
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.ContextApi.commit", getCodec());
        if (api != null) {
          channel.setMessageHandler((message, reply) -> {
            Map<String, Object> wrapped = new HashMap<>();
            try {
              ArrayList<Object> args = (ArrayList<Object>)message;
              Content contentArg = (Content)args.get(0);
              if (contentArg == null) {
                throw new NullPointerException("contentArg unexpectedly null.");
              }
              Boolean output = api.commit(contentArg);
              wrapped.put("result", output);
            }
            catch (Error | RuntimeException exception) {
              wrapped.put("error", wrapError(exception));
            }
            reply.reply(wrapped);
          });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.ContextApi.delete", getCodec());
        if (api != null) {
          channel.setMessageHandler((message, reply) -> {
            Map<String, Object> wrapped = new HashMap<>();
            try {
              Boolean output = api.delete();
              wrapped.put("result", output);
            }
            catch (Error | RuntimeException exception) {
              wrapped.put("error", wrapError(exception));
            }
            reply.reply(wrapped);
          });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.ContextApi.enter", getCodec());
        if (api != null) {
          channel.setMessageHandler((message, reply) -> {
            Map<String, Object> wrapped = new HashMap<>();
            try {
              Boolean output = api.enter();
              wrapped.put("result", output);
            }
            catch (Error | RuntimeException exception) {
              wrapped.put("error", wrapError(exception));
            }
            reply.reply(wrapped);
          });
        } else {
          channel.setMessageHandler(null);
        }
      }
    }
  }
  private static class InputMethodApiCodec extends StandardMessageCodec {
    public static final InputMethodApiCodec INSTANCE = new InputMethodApiCodec();
    private InputMethodApiCodec() {}
  }

  /** Generated interface from Pigeon that represents a handler of messages from Flutter.*/
  public interface InputMethodApi {
    Boolean enable();
    Boolean pick();

    /** The codec used by InputMethodApi. */
    static MessageCodec<Object> getCodec() {
      return InputMethodApiCodec.INSTANCE;
    }

    /** Sets up an instance of `InputMethodApi` to handle messages through the `binaryMessenger`. */
    static void setup(BinaryMessenger binaryMessenger, InputMethodApi api) {
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.InputMethodApi.enable", getCodec());
        if (api != null) {
          channel.setMessageHandler((message, reply) -> {
            Map<String, Object> wrapped = new HashMap<>();
            try {
              Boolean output = api.enable();
              wrapped.put("result", output);
            }
            catch (Error | RuntimeException exception) {
              wrapped.put("error", wrapError(exception));
            }
            reply.reply(wrapped);
          });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.InputMethodApi.pick", getCodec());
        if (api != null) {
          channel.setMessageHandler((message, reply) -> {
            Map<String, Object> wrapped = new HashMap<>();
            try {
              Boolean output = api.pick();
              wrapped.put("result", output);
            }
            catch (Error | RuntimeException exception) {
              wrapped.put("error", wrapError(exception));
            }
            reply.reply(wrapped);
          });
        } else {
          channel.setMessageHandler(null);
        }
      }
    }
  }
  private static class LayoutApiCodec extends StandardMessageCodec {
    public static final LayoutApiCodec INSTANCE = new LayoutApiCodec();
    private LayoutApiCodec() {}
  }

  /** Generated interface from Pigeon that represents a handler of messages from Flutter.*/
  public interface LayoutApi {
    void setHeight(Long height);

    /** The codec used by LayoutApi. */
    static MessageCodec<Object> getCodec() {
      return LayoutApiCodec.INSTANCE;
    }

    /** Sets up an instance of `LayoutApi` to handle messages through the `binaryMessenger`. */
    static void setup(BinaryMessenger binaryMessenger, LayoutApi api) {
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.LayoutApi.setHeight", getCodec());
        if (api != null) {
          channel.setMessageHandler((message, reply) -> {
            Map<String, Object> wrapped = new HashMap<>();
            try {
              ArrayList<Object> args = (ArrayList<Object>)message;
              Number heightArg = (Number)args.get(0);
              if (heightArg == null) {
                throw new NullPointerException("heightArg unexpectedly null.");
              }
              api.setHeight(heightArg.longValue());
              wrapped.put("result", null);
            }
            catch (Error | RuntimeException exception) {
              wrapped.put("error", wrapError(exception));
            }
            reply.reply(wrapped);
          });
        } else {
          channel.setMessageHandler(null);
        }
      }
    }
  }
  private static Map<String, Object> wrapError(Throwable exception) {
    Map<String, Object> errorMap = new HashMap<>();
    errorMap.put("message", exception.toString());
    errorMap.put("code", exception.getClass().getSimpleName());
    errorMap.put("details", null);
    return errorMap;
  }
}
