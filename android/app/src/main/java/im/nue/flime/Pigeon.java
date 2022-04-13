// Autogenerated from Pigeon (v2.0.3), do not edit directly.
// See also: https://pub.dev/packages/pigeon

package im.nue.flime;

import android.util.Log;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
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
    private @Nullable String text;
    public @Nullable String getText() { return text; }
    public void setText(@Nullable String setterArg) {
      this.text = setterArg;
    }

    public static final class Builder {
      private @Nullable String text;
      public @NonNull Builder setText(@Nullable String setterArg) {
        this.text = setterArg;
        return this;
      }
      public @NonNull Content build() {
        Content pigeonReturn = new Content();
        pigeonReturn.setText(text);
        return pigeonReturn;
      }
    }
    @NonNull Map<String, Object> toMap() {
      Map<String, Object> toMapResult = new HashMap<>();
      toMapResult.put("text", text);
      return toMapResult;
    }
    static @NonNull Content fromMap(@NonNull Map<String, Object> map) {
      Content pigeonResult = new Content();
      Object text = map.get("text");
      pigeonResult.setText((String)text);
      return pigeonResult;
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
    @NonNull Boolean commit(@NonNull Content content);
    @NonNull Boolean send(@NonNull String keyLabel);
    @NonNull Boolean sendShortcut(@NonNull String keyLabel, @NonNull Long modifier);

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
            new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.ContextApi.send", getCodec());
        if (api != null) {
          channel.setMessageHandler((message, reply) -> {
            Map<String, Object> wrapped = new HashMap<>();
            try {
              ArrayList<Object> args = (ArrayList<Object>)message;
              String keyLabelArg = (String)args.get(0);
              if (keyLabelArg == null) {
                throw new NullPointerException("keyLabelArg unexpectedly null.");
              }
              Boolean output = api.send(keyLabelArg);
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
            new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.ContextApi.sendShortcut", getCodec());
        if (api != null) {
          channel.setMessageHandler((message, reply) -> {
            Map<String, Object> wrapped = new HashMap<>();
            try {
              ArrayList<Object> args = (ArrayList<Object>)message;
              String keyLabelArg = (String)args.get(0);
              if (keyLabelArg == null) {
                throw new NullPointerException("keyLabelArg unexpectedly null.");
              }
              Number modifierArg = (Number)args.get(1);
              if (modifierArg == null) {
                throw new NullPointerException("modifierArg unexpectedly null.");
              }
              Boolean output = api.sendShortcut(keyLabelArg, (modifierArg == null) ? null : modifierArg.longValue());
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
    @NonNull Boolean enable();
    @NonNull Boolean pick();

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
    void setHeight(@NonNull Long height);

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
              api.setHeight((heightArg == null) ? null : heightArg.longValue());
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
  private static class ProcessTextApiCodec extends StandardMessageCodec {
    public static final ProcessTextApiCodec INSTANCE = new ProcessTextApiCodec();
    private ProcessTextApiCodec() {}
  }

  /** Generated interface from Pigeon that represents a handler of messages from Flutter.*/
  public interface ProcessTextApi {
    @NonNull String getText();

    /** The codec used by ProcessTextApi. */
    static MessageCodec<Object> getCodec() {
      return ProcessTextApiCodec.INSTANCE;
    }

    /** Sets up an instance of `ProcessTextApi` to handle messages through the `binaryMessenger`. */
    static void setup(BinaryMessenger binaryMessenger, ProcessTextApi api) {
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.ProcessTextApi.getText", getCodec());
        if (api != null) {
          channel.setMessageHandler((message, reply) -> {
            Map<String, Object> wrapped = new HashMap<>();
            try {
              String output = api.getText();
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
  private static Map<String, Object> wrapError(Throwable exception) {
    Map<String, Object> errorMap = new HashMap<>();
    errorMap.put("message", exception.toString());
    errorMap.put("code", exception.getClass().getSimpleName());
    errorMap.put("details", "Cause: " + exception.getCause() + ", Stacktrace: " + Log.getStackTraceString(exception));
    return errorMap;
  }
}
