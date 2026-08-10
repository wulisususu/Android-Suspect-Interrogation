.class public abstract Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "Event"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;,
        Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutAssignment;,
        Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutsState;,
        Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;,
        Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device;,
        Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;
    .locals 1

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/crash/internal/model/m$b;

    invoke-direct {v0}, Lcom/aliyun/emas/apm/crash/internal/model/m$b;-><init>()V

    return-object v0
.end method


# virtual methods
.method public abstract getApp()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;
.end method

.method public abstract getDevice()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device;
.end method

.method public abstract getLogcat()[B
.end method

.method public abstract getMemory()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;
.end method

.method public abstract getRollouts()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutsState;
.end method

.method public abstract getTimestamp()J
.end method

.method public abstract getType()Ljava/lang/String;
.end method

.method public abstract toBuilder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;
.end method
