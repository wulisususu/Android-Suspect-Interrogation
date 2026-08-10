.class public interface abstract Lcom/aliyun/emas/apm/inject/Deferred;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/aliyun/emas/apm/inject/Deferred$DeferredHandler;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Ljava/lang/Object;",
        ">",
        "Ljava/lang/Object;"
    }
.end annotation


# virtual methods
.method public abstract whenAvailable(Lcom/aliyun/emas/apm/inject/Deferred$DeferredHandler;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/aliyun/emas/apm/inject/Deferred$DeferredHandler<",
            "TT;>;)V"
        }
    .end annotation
.end method
