.class public interface abstract Lcom/taobao/monitor/adapter/device/ApmDeviceInfoCallback;
.super Ljava/lang/Object;
.source "ApmDeviceInfoCallback.java"


# virtual methods
.method public abstract cpuInfo(Ljava/lang/String;Ljava/lang/String;)V
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x10,
            0x10
        }
        names = {
            "cpuName",
            "cpuBrand"
        }
    .end annotation
.end method

.method public abstract deviceScore(I)V
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x10
        }
        names = {
            "deviceScore"
        }
    .end annotation
.end method

.method public abstract gpuInfo(Ljava/lang/String;Ljava/lang/String;)V
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x10,
            0x10
        }
        names = {
            "gpuName",
            "gpuBrand"
        }
    .end annotation
.end method
