.class public Lcom/taobao/application/common/a;
.super Ljava/lang/Object;
.source "ApmHelper.java"


# direct methods
.method public static a()V
    .locals 1

    .line 1
    invoke-static {}, Lcom/taobao/application/common/impl/b;->a()Lcom/taobao/application/common/impl/b;

    move-result-object v0

    invoke-static {v0}, Lcom/taobao/application/common/ApmManager;->setApmDelegate(Lcom/taobao/application/common/IApplicationMonitor;)V

    return-void
.end method
