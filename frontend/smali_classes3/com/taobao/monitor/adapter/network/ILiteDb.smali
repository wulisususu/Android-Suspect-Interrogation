.class public interface abstract Lcom/taobao/monitor/adapter/network/ILiteDb;
.super Ljava/lang/Object;
.source "ILiteDb.java"


# virtual methods
.method public abstract delete()V
.end method

.method public abstract insert(Ljava/lang/String;)V
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "content"
        }
    .end annotation
.end method

.method public abstract select()Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end method
