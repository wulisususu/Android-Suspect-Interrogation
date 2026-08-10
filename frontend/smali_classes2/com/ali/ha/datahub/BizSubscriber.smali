.class public interface abstract Lcom/ali/ha/datahub/BizSubscriber;
.super Ljava/lang/Object;
.source "BizSubscriber.java"


# virtual methods
.method public abstract onBizDataReadyStage()V
.end method

.method public abstract onStage(Ljava/lang/String;Ljava/lang/String;J)V
.end method

.method public abstract pub(Ljava/lang/String;Ljava/util/HashMap;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/HashMap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation
.end method

.method public abstract pubAB(Ljava/lang/String;Ljava/util/HashMap;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/HashMap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation
.end method

.method public abstract setMainBiz(Ljava/lang/String;Ljava/lang/String;)V
.end method
