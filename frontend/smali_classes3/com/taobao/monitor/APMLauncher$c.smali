.class final Lcom/taobao/monitor/APMLauncher$c;
.super Ljava/lang/Object;
.source "APMLauncher.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/monitor/APMLauncher;->firstAsyncMessage()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .line 1
    invoke-static {}, Lcom/taobao/monitor/APMLauncher;->access$100()V

    .line 2
    invoke-static {}, Lcom/taobao/monitor/APMLauncher;->access$200()V

    .line 3
    invoke-static {}, Lcom/taobao/monitor/APMLauncher;->access$300()V

    .line 5
    invoke-static {}, Lcom/taobao/monitor/APMLauncher;->access$400()V

    .line 7
    new-instance v0, Lcom/taobao/application/common/data/DeviceHelper;

    invoke-direct {v0}, Lcom/taobao/application/common/data/DeviceHelper;-><init>()V

    .line 8
    invoke-static {}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->getInstance()Lcom/ali/alihadeviceevaluator/AliHAHardware;

    move-result-object v1

    invoke-virtual {v1}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->getOutlineInfo()Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;

    move-result-object v1

    iget v1, v1, Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;->deviceLevel:I

    invoke-virtual {v0, v1}, Lcom/taobao/application/common/data/DeviceHelper;->setDeviceLevel(I)V

    .line 9
    invoke-static {}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->getInstance()Lcom/ali/alihadeviceevaluator/AliHAHardware;

    move-result-object v1

    invoke-virtual {v1}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->getCpuInfo()Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;

    move-result-object v1

    iget v1, v1, Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;->deviceLevel:I

    invoke-virtual {v0, v1}, Lcom/taobao/application/common/data/DeviceHelper;->setCpuScore(I)V

    .line 10
    invoke-static {}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->getInstance()Lcom/ali/alihadeviceevaluator/AliHAHardware;

    move-result-object v1

    invoke-virtual {v1}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->getMemoryInfo()Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;

    move-result-object v1

    iget v1, v1, Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;->deviceLevel:I

    invoke-virtual {v0, v1}, Lcom/taobao/application/common/data/DeviceHelper;->setMemScore(I)V

    return-void
.end method
