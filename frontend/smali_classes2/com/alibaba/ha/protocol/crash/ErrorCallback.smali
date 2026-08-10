.class public interface abstract Lcom/alibaba/ha/protocol/crash/ErrorCallback;
.super Ljava/lang/Object;
.source "ErrorCallback.java"


# virtual methods
.method public abstract onError(Lcom/alibaba/ha/protocol/crash/ErrorInfo;)Ljava/util/Map;
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "info"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/alibaba/ha/protocol/crash/ErrorInfo;",
            ")",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end method
