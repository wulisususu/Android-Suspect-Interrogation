.class public Lcom/taobao/tao/log/godeye/core/module/GodEyeAppInfo;
.super Ljava/lang/Object;
.source "GodEyeAppInfo.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/tao/log/godeye/core/module/GodEyeAppInfo$PerformanceInfo;,
        Lcom/taobao/tao/log/godeye/core/module/GodEyeAppInfo$BatteryInfo;,
        Lcom/taobao/tao/log/godeye/core/module/GodEyeAppInfo$TrafficStatsInfo;,
        Lcom/taobao/tao/log/godeye/core/module/GodEyeAppInfo$DeviceInfo;,
        Lcom/taobao/tao/log/godeye/core/module/GodEyeAppInfo$IOStat;,
        Lcom/taobao/tao/log/godeye/core/module/GodEyeAppInfo$CpuStat;
    }
.end annotation


# instance fields
.field public batteryInfo:Lcom/taobao/tao/log/godeye/core/module/GodEyeAppInfo$BatteryInfo;

.field public cpuStat:Lcom/taobao/tao/log/godeye/core/module/GodEyeAppInfo$CpuStat;

.field public deviceInfo:Lcom/taobao/tao/log/godeye/core/module/GodEyeAppInfo$DeviceInfo;

.field public iOStat:Lcom/taobao/tao/log/godeye/core/module/GodEyeAppInfo$IOStat;

.field public performanceInfo:Lcom/taobao/tao/log/godeye/core/module/GodEyeAppInfo$PerformanceInfo;

.field public trafficStatsInfo:Lcom/taobao/tao/log/godeye/core/module/GodEyeAppInfo$TrafficStatsInfo;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 13
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 15
    new-instance v0, Lcom/taobao/tao/log/godeye/core/module/GodEyeAppInfo$CpuStat;

    invoke-direct {v0}, Lcom/taobao/tao/log/godeye/core/module/GodEyeAppInfo$CpuStat;-><init>()V

    iput-object v0, p0, Lcom/taobao/tao/log/godeye/core/module/GodEyeAppInfo;->cpuStat:Lcom/taobao/tao/log/godeye/core/module/GodEyeAppInfo$CpuStat;

    .line 16
    new-instance v0, Lcom/taobao/tao/log/godeye/core/module/GodEyeAppInfo$IOStat;

    invoke-direct {v0}, Lcom/taobao/tao/log/godeye/core/module/GodEyeAppInfo$IOStat;-><init>()V

    iput-object v0, p0, Lcom/taobao/tao/log/godeye/core/module/GodEyeAppInfo;->iOStat:Lcom/taobao/tao/log/godeye/core/module/GodEyeAppInfo$IOStat;

    .line 17
    new-instance v0, Lcom/taobao/tao/log/godeye/core/module/GodEyeAppInfo$DeviceInfo;

    invoke-direct {v0}, Lcom/taobao/tao/log/godeye/core/module/GodEyeAppInfo$DeviceInfo;-><init>()V

    iput-object v0, p0, Lcom/taobao/tao/log/godeye/core/module/GodEyeAppInfo;->deviceInfo:Lcom/taobao/tao/log/godeye/core/module/GodEyeAppInfo$DeviceInfo;

    .line 18
    new-instance v0, Lcom/taobao/tao/log/godeye/core/module/GodEyeAppInfo$TrafficStatsInfo;

    invoke-direct {v0}, Lcom/taobao/tao/log/godeye/core/module/GodEyeAppInfo$TrafficStatsInfo;-><init>()V

    iput-object v0, p0, Lcom/taobao/tao/log/godeye/core/module/GodEyeAppInfo;->trafficStatsInfo:Lcom/taobao/tao/log/godeye/core/module/GodEyeAppInfo$TrafficStatsInfo;

    .line 19
    new-instance v0, Lcom/taobao/tao/log/godeye/core/module/GodEyeAppInfo$BatteryInfo;

    invoke-direct {v0}, Lcom/taobao/tao/log/godeye/core/module/GodEyeAppInfo$BatteryInfo;-><init>()V

    iput-object v0, p0, Lcom/taobao/tao/log/godeye/core/module/GodEyeAppInfo;->batteryInfo:Lcom/taobao/tao/log/godeye/core/module/GodEyeAppInfo$BatteryInfo;

    .line 20
    new-instance v0, Lcom/taobao/tao/log/godeye/core/module/GodEyeAppInfo$PerformanceInfo;

    invoke-direct {v0}, Lcom/taobao/tao/log/godeye/core/module/GodEyeAppInfo$PerformanceInfo;-><init>()V

    iput-object v0, p0, Lcom/taobao/tao/log/godeye/core/module/GodEyeAppInfo;->performanceInfo:Lcom/taobao/tao/log/godeye/core/module/GodEyeAppInfo$PerformanceInfo;

    return-void
.end method
