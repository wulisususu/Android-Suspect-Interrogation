.class public interface abstract Lcom/taobao/monitor/performance/IWXApmAdapter;
.super Ljava/lang/Object;
.source "IWXApmAdapter.java"


# virtual methods
.method public abstract addBiz(Ljava/lang/String;Ljava/util/Map;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)V"
        }
    .end annotation
.end method

.method public abstract addBizAbTest(Ljava/lang/String;Ljava/util/Map;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)V"
        }
    .end annotation
.end method

.method public abstract addBizStage(Ljava/lang/String;Ljava/util/Map;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)V"
        }
    .end annotation
.end method

.method public abstract addProperty(Ljava/lang/String;Ljava/lang/Object;)V
.end method

.method public abstract addStatistic(Ljava/lang/String;D)V
.end method

.method public abstract onEnd()V
.end method

.method public abstract onEvent(Ljava/lang/String;Ljava/lang/Object;)V
.end method

.method public abstract onStage(Ljava/lang/String;J)V
.end method

.method public abstract onStart()V
.end method

.method public abstract onStart(Ljava/lang/String;)V
.end method

.method public abstract onStop()V
.end method
