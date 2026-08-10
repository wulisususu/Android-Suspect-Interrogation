.class Lcom/taobao/monitor/adapter/SimpleApmInitiator$1;
.super Ljava/lang/Object;
.source "SimpleApmInitiator.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/monitor/adapter/SimpleApmInitiator;->initDeviceEvaluation(Landroid/app/Application;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/taobao/monitor/adapter/SimpleApmInitiator;


# direct methods
.method constructor <init>(Lcom/taobao/monitor/adapter/SimpleApmInitiator;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010
        }
        names = {
            "this$0"
        }
    .end annotation

    iput-object p1, p0, Lcom/taobao/monitor/adapter/SimpleApmInitiator$1;->this$0:Lcom/taobao/monitor/adapter/SimpleApmInitiator;

    .line 82
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    .line 85
    invoke-static {}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->getInstance()Lcom/ali/alihadeviceevaluator/AliHAHardware;

    move-result-object v0

    invoke-virtual {v0}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->getOutlineInfo()Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;

    return-void
.end method
