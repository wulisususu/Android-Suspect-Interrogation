.class public Lcom/taobao/tao/log/godeye/core/module/GodEyeAppInfo$CpuStat;
.super Ljava/lang/Object;
.source "GodEyeAppInfo.java"

# interfaces
.implements Ljava/io/Serializable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/tao/log/godeye/core/module/GodEyeAppInfo;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "CpuStat"
.end annotation


# instance fields
.field public cpuAlarmInBg:Z

.field public iOWaitTimeAvg:I

.field public mPidPerCpuLoadAvg:F

.field public myAVGPidCPUPercent:I

.field public myMaxPidCPUPercent:I

.field public myPidCPUPercent:I

.field public pidIoWaitCount:I

.field public sysAvgCPUPercent:I

.field public sysCPUPercent:I

.field public sysMaxCPUPercent:I

.field public systemLoadAvg:F


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 22
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
