.class public interface abstract Lcom/taobao/tao/log/ITLogController;
.super Ljava/lang/Object;
.source "ITLogController.java"


# virtual methods
.method public abstract checkLogLength(Ljava/lang/String;)Z
.end method

.method public abstract compress(Ljava/lang/String;)Ljava/lang/String;
.end method

.method public abstract destroyLog(Z)V
.end method

.method public abstract ecrypted([B)[B
.end method

.method public abstract ecrypted([BII)[B
.end method

.method public abstract getLogLevel(Ljava/lang/String;)Lcom/taobao/tao/log/LogLevel;
.end method

.method public abstract isFilter(Lcom/taobao/tao/log/LogLevel;Ljava/lang/String;)Z
.end method

.method public abstract isOpenLog()Z
.end method

.method public abstract openLog(Z)V
.end method

.method public abstract setEndTime(J)V
.end method

.method public abstract setLogLevel(Ljava/lang/String;)V
.end method

.method public abstract setModuleFilter(Ljava/util/Map;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/taobao/tao/log/LogLevel;",
            ">;)V"
        }
    .end annotation
.end method
