.class public interface abstract Lcom/aliyun/emas/apm/events/Subscriber;
.super Ljava/lang/Object;
.source "SourceFile"


# virtual methods
.method public abstract subscribe(Ljava/lang/Class;Lcom/aliyun/emas/apm/events/EventHandler;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/Class<",
            "TT;>;",
            "Lcom/aliyun/emas/apm/events/EventHandler<",
            "-TT;>;)V"
        }
    .end annotation
.end method

.method public abstract subscribe(Ljava/lang/Class;Ljava/util/concurrent/Executor;Lcom/aliyun/emas/apm/events/EventHandler;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/Class<",
            "TT;>;",
            "Ljava/util/concurrent/Executor;",
            "Lcom/aliyun/emas/apm/events/EventHandler<",
            "-TT;>;)V"
        }
    .end annotation
.end method

.method public abstract unsubscribe(Ljava/lang/Class;Lcom/aliyun/emas/apm/events/EventHandler;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/Class<",
            "TT;>;",
            "Lcom/aliyun/emas/apm/events/EventHandler<",
            "-TT;>;)V"
        }
    .end annotation
.end method
