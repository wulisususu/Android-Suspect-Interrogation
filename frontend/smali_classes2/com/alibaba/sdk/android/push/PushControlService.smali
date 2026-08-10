.class public interface abstract Lcom/alibaba/sdk/android/push/PushControlService;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/alibaba/sdk/android/push/PushControlService$ConnectionChangeListener;
    }
.end annotation


# virtual methods
.method public abstract disconnect()V
.end method

.method public abstract isConnected()Z
.end method

.method public abstract reconnect()V
.end method

.method public abstract reset()V
.end method

.method public abstract setConnectionChangeListener(Lcom/alibaba/sdk/android/push/PushControlService$ConnectionChangeListener;)V
.end method
