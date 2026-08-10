.class public Lcom/taobao/tao/log/godeye/core/module/GodEyeAppInfo$PerformanceInfo;
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
    name = "PerformanceInfo"
.end annotation


# instance fields
.field public anrCount:I

.field public appProgressImportance:I

.field public cpuPerformance:I

.field public deviceScore:I

.field public ioPerformance:I

.field public isLowPerformance:Z

.field public memPerformance:I

.field public myPidScore:I

.field public runTimeThreadCount:I

.field public runningThreadCount:I

.field public schedPerformance:I

.field public sysRunningProgress:I

.field public sysRunningService:I

.field public systemRunningScore:I

.field public threadCount:I


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 209
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lcom/taobao/tao/log/godeye/core/module/GodEyeAppInfo$PerformanceInfo;->systemRunningScore:I

    iput v0, p0, Lcom/taobao/tao/log/godeye/core/module/GodEyeAppInfo$PerformanceInfo;->myPidScore:I

    return-void
.end method
