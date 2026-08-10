.class public Lcom/taobao/tao/log/task/q;
.super Ljava/lang/Object;
.source "UpdateNickTask.java"


# direct methods
.method public static execute()V
    .locals 2

    .line 9
    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/taobao/tao/log/task/q$1;

    invoke-direct {v1}, Lcom/taobao/tao/log/task/q$1;-><init>()V

    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 14
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    return-void
.end method
