.class public Lcom/ali/alihadeviceevaluator/util/AliHALifecycle;
.super Ljava/lang/Object;
.source "AliHALifecycle.java"

# interfaces
.implements Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 8
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onBackground(Landroid/app/Activity;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "activity"
        }
    .end annotation

    .line 12
    invoke-static {}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->getInstance()Lcom/ali/alihadeviceevaluator/AliHAHardware;

    move-result-object p1

    invoke-virtual {p1}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->onAppBackGround()V

    return-void
.end method

.method public onForeground(Landroid/app/Activity;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "activity"
        }
    .end annotation

    .line 17
    invoke-static {}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->getInstance()Lcom/ali/alihadeviceevaluator/AliHAHardware;

    move-result-object p1

    invoke-virtual {p1}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->onAppForeGround()V

    return-void
.end method
